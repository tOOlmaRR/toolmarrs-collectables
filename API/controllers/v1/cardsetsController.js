//const cardSetModel = require('../models/cardsets');

const { poolPromise } = require('../../db')

// Return a test response
exports.getTestOutput = (req, res) => {
    res.json({
        endpoint: 'cardsets test'
    });
}

// Return a list of distinct seasons based on all card sets in the database
exports.getSeasons = (req, res) => {
    // collect inputs
    let inputs = {};
    inputs.sport = req.params["sport"];
    
    return new Promise(async function(resolve, reject) {
        let conn;
        let jsonResponse;
        let sqlQuery = `SELECT DISTINCT cs.Season FROM cardset cs WITH (NOLOCK) INNER JOIN sport s WITH (NOLOCK) ON cs.Sport_ID = s.ID AND s.Name = '${inputs.sport}' ORDER BY cs.Season ASC`;
        try {
            // wait for the SQL connection pool to be ready
            const pool = await poolPromise;
            
            // get results
            await pool.query(sqlQuery)
                .then(function(result) {
                    const seasonsFromDb = result.recordset == undefined ? [] : result.recordset;
                    let seasons = [];
                    for (let i = 0; i < seasonsFromDb.length; i++) {
                        const record = seasonsFromDb[i];
                        seasons.push(record.Season);
                    }

                    // build reponse
                    const jsonResponse = {
                        inputs,
                        data: {
                            seasons
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

// Return a list of base set names for a specified season
exports.getBaseSetNames = (req, res) => {
    // collect inputs
    let inputs = {};
    inputs.sport = req.params["sport"];
    inputs.season = req.params["season"];

    return new Promise(async function(resolve, reject) {
        let conn;
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

                    // build reponse
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
        let conn;
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

                    // build reponse
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
            
                    // build reponse
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