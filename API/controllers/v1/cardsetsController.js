const { getTestSeasons, getSeasonsFromDB } = require('../../models/v1/cardsetsModel');
const sql = require('mssql'); // remove once all DB ops have moved to the model
const { poolPromise } = require('../../db'); // remove once all DB ops have moved to the model

// Return a test response
exports.getTestOutput = (req, res) => {
    res.json({
        endpoint: 'cardsets controller test'
    });
}

// Return a test response for seasons
exports.getTestSeasonsOutput = (req, res) => {
    let inputs = {};
    inputs.sport = req.params["sport"];

    getTestSeasons(inputs)
        .then(result => {
            res.json({
                inputs,
                endpoint: "cardsets seasons test",
                data: result
            });
        })
        .catch(error => {
            res.json({
                inputs,
                endpoint: "cardsets seasons test",
                error: error
            });
        })
}

// Return a list of distinct seasons based on all card sets in the database
exports.getSeasons = (req, res) => {
    let inputs = {};
    inputs.sport = req.params["sport"];
    
    // validate inputs
    if (!validateSport(inputs.sport))
    {
        const jsonResponse = {
            inputs,
            error: "Input Validation Failed (sport)"
        };
        res.status(400);
        res.json(jsonResponse);
    } else {
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
            res.json({
                inputs,
                endpoint: "cardsets seasons",
                error: error.message,
                stack: error.stack
            });
            // TODO: return friendly error message and log the true error in the database
        })
    }
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