const { getTestSeasons, getSeasonsFromDB, getBaseSetNamesFromDB } = require('../../models/v1/cardsetsModel');
const sql = require('mssql'); // remove once all DB ops have moved to the model
const { poolPromise } = require('../../db'); // remove once all DB ops have moved to the model

// ENDPOINT: Cardsets Controller Test
// Return a test response directly from the controller
exports.getControllerTestResponse = (req, res) => {
    const endpointName = 'Cardsets Controller Test';
    return res.json({
        endpoint: endpointName
    });
}



// ENDPOINT: Cardsets Model Test
// Return a test response from the model
exports.getModelTestResponse = (req, res) => {
    const endpointName = 'Cardsets Model Test';
    
    // collect inputs
    let inputs = {};
    inputs.sport = req.params["sport"];

    // Get a test reponse via the model
    getTestSeasons(inputs)
        .then(result => {
            return res.json({
                inputs,
                endpoint: endpointName,
                data: {
                    seasons: result
                }
            });
        })
        .catch(error => {
            return res.json({
                inputs,
                endpoint: endpointName,
                error: { message: error }
            });
        });
}



// ENDPOINT: View Seasons
// Return a list of distinct seasons based on all card sets in the database for the specified sport
exports.getSeasons = (req, res) => {
    const endpointName = 'View Seasons';
    
    // collect inputs
    let inputs = {};
    inputs.sport = req.params["sport"];
    
    // validate inputs and return response if invalid
    if (!validateSport(inputs.sport))
    {
        const jsonResponse = {
            inputs,
            endpoint: endpointName,
            error: {
                message: "Input Validation Failed (sport)"
            }
        };
        res.status(400);
        return res.json(jsonResponse);
    }

    // Query the DB via the model for seasons data
    getSeasonsFromDB(inputs.sport)
        .then(result => {
            return res.json({
                inputs,
                endpoint: endpointName,
                data: {
                    seasons: result
                }
            });
        })
        .catch(error => {
            res.status(400);
            return res.json({
                inputs,
                endpoint: endpointName,
                error: {
                    message: error.message,
                    stack: error.stack
                }
            });
            // TODO: interpret and respond with a friendly error message and log the true error in the database
        });
}



// ENDPOINT: View Seasons
// Return a list of base set names for a specified sport and season
exports.getBaseSetNames = (req, res) => {
    const endpointName = 'View Base Set Names';
    
    // collect inputs
    let inputs = {};
    inputs.sport = req.params["sport"];
    inputs.season = req.params["season"];

    // validate inputs
    const validSport = validateSport(inputs.sport);
    const validSeason = validateSeason(inputs.season);
    if (!validSport || !validSeason)
    {
        let invalidInputs;
        if (!validSport && !validSeason) invalidInputs = "sport and season";
        else if (!validSport) invalidInputs = "sport";
        else if (!validSeason) invalidInputs = "season";

        const jsonResponse = {
            inputs,
            endpoint: endpointName,
            error: {
                message: `Input Validation Failed (${invalidInputs})`
            }
        };
        res.status(400);
        return res.json(jsonResponse);
    }

    // Query the DB via the model for base set names
    getBaseSetNamesFromDB(inputs.sport, inputs.season)
    .then(result => {
        return res.json({
            inputs,
            endpoint: endpointName,
            data: {
                basesets: result
            }
        });
    })
    .catch(error => {
        res.status(400);
        return res.json({
            inputs,
            endpoint: endpointName,
            error: {
                message: error.message,
                stack: error.stack
            }
        });
        // TODO: interpret and respond with a friendly error message and log the true error in the database
    });
}

// Return a list of distinct insert set names within a specified base set (by name) in a specified season
exports.getInsertSetNames = (req, res) => {
    // collect inputs
    let inputs = {};
    inputs.sport = req.params["sport"];
    inputs.season = req.params["season"];
    inputs.basesetname = req.params["basesetname"];

    return new Promise(async function(resolve, reject) {
        let jsonResponse;
        let sqlQuery = `SELECT InsertSetName FROM cardset cs WITH (NOLOCK) INNER JOIN sport s WITH (NOLOCK) ON cs.Sport_ID = s.ID AND s.Name = '${inputs.sport}' WHERE Season = '${inputs.season}' AND BaseSetName = '${inputs.basesetname}' AND InsertSetName <> '' ORDER BY InsertSetName ASC`;
        try {
            // wait for the SQL connection pool to be ready
            const pool = await poolPromise;
            
            // get results
            await pool.query(sqlQuery)
                .then(function(result) {
                    const insertSetsFromDb = result.recordset == undefined ? [] : result.recordset;
                    let sets = [];
                    for (let i = 0; i < insertSetsFromDb.length; i++) {
                        const record = insertSetsFromDb[i];
                        sets.push(record.InsertSetName);
                    }

                    // build response
                    const jsonResponse = {
                        inputs,
                        data: {
                            insertsets: sets
                        }
                    };
                    res.json(jsonResponse);
                    return resolve(jsonResponse);
                })
            .catch(function(err) {
                // handle query errors
                res.json(jsonResponse);
                return reject(err);
            });      
        } catch (err) {
            // handle connection and logic errors (but not SQL errors)
            res.json(jsonResponse);
            return reject(err);
        }
    });
}

exports.getCardSetDetails = (req, res) => {
    // collect inputs
    let inputs = {};
    inputs.sport = req.params["sport"];
    inputs.season = req.params["season"];
    inputs.basesetname = req.params["basesetname"];
    inputs.insertsetname = req.params["insertsetname"] == undefined ? '' : req.params["insertsetname"];

    return new Promise(async function(resolve, reject) {
        let jsonResponse;
        let sqlQuery = `SELECT top 1 cs.* FROM cardset cs WITH (NOLOCK) INNER JOIN sport s WITH (NOLOCK) ON cs.Sport_ID = s.ID AND s.Name = '${inputs.sport}' WHERE Season = '${inputs.season}' AND BaseSetName = '${inputs.basesetname}' AND InsertSetName = '${inputs.insertsetname}'`;
        try {
            // wait for the SQL connection pool to be ready
            const pool = await poolPromise;
            
            // get results
            await pool.query(sqlQuery)
                .then(function(result) {
                    const cardset = result.recordset == undefined ? {} : result.recordset;
            
                    // build response
                    jsonResponse = {
                        inputs,
                        data: {
                            cardset
                        }
                    };
                    res.json(jsonResponse);
                    return resolve(jsonResponse);
                })
                .catch(function(err) {
                    // handle query errors
                    res.json(jsonResponse);
                    return reject(err);
                });            
        } catch (err) {
            // handle connection and logic errors (but not SQL errors)
            res.json(jsonResponse);
            return reject(err);
        }
    });
}

/* Input Validation */
function validateSport(sport) {
    var valid = false;
    if (typeof(sport) == "string" && sport.length <= 25)
        return true;
    else
        return false;
}

function validateSeason(season) {
    var valid = false;
    if (typeof(season) == "string" && (season.length == 7 || season.length == 4))
        return true;
    else
        return false;
}