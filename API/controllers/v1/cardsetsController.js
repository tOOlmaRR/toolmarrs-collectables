const { getTestSeasons, getSeasonsFromDB } = require('../../models/v1/cardsetsModel');
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
            res.json({
                inputs,
                endpoint: endpointName,
                data: {
                    seasons: result
                }
            });
        })
        .catch(error => {
            res.json({
                inputs,
                endpoint: endpointName,
                error: error
            });
        })
}



// Return a list of distinct seasons based on all card sets in the database for the provided sport
exports.getSeasons = (req, res) => {
    // collect inputs
    let inputs = {};
    inputs.sport = req.params["sport"];
    
    // validate inputs and return response if invalid
    if (!validateSport(inputs.sport))
    {
        const jsonResponse = {
            inputs,
            error: "Input Validation Failed (sport)"
        };
        res.status(400);
        return res.json(jsonResponse);
    }

    // Query the DB via the model for seasons data
    getSeasonsFromDB(inputs.sport)
    .then(result => {
        res.json({
            inputs,
            endpoint: "cardsets seasons",
            data: {
                seasons: result
            }
        });
    })
    .catch(error => {
        res.status(400);
        return res.json({
            inputs,
            endpoint: "cardsets seasons",
            error: error.message,
            stack: error.stack
        });
        // TODO: interpret and respond with a friendly error message and log the true error in the database
    })
}

// Return a list of base set names for a specified season
exports.getBaseSetNames = (req, res) => {
    // collect inputs
    let inputs = {};
    inputs.sport = req.params["sport"];
    inputs.season = req.params["season"];



    return new Promise(async function(resolve, reject) {
        let jsonResponse;
        let sqlQuery = `SELECT BaseSetName FROM cardset cs WITH (NOLOCK) INNER JOIN sport s WITH (NOLOCK) ON cs.Sport_ID = s.ID AND s.Name = '${inputs.sport}' WHERE Season = '${inputs.season}' AND InsertSetName = '' ORDER BY BaseSetName ASC`;
        try {
            // wait for the SQL connection pool to be ready
            const pool = await poolPromise;
            
            // get results
            await pool.query(sqlQuery)
                .then(function(result) {
                    const baseSetsFromDb = result.recordset == undefined ? [] : result.recordset;
                    let sets = [];
                    for (let i = 0; i < baseSetsFromDb.length; i++) {
                        const record = baseSetsFromDb[i];
                        sets.push(record.BaseSetName);
                    }

                    // build response
                    const jsonResponse = {
                        inputs,
                        data: {
                            basesets: sets
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