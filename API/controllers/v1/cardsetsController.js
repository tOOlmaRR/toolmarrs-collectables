//const cardSetModel = require('../models/cardsets');

const sql = require('mssql')

// DB Configuration
const config = {
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    server: process.env.DB_SERVER,
    database: process.env.DB_NAME,
    options: {
        enableArithAbort: true,
        encrypt: true
    },
    stream: false
};

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
            // connect
            conn = await sql.connect(config);
            
            // get results
            let result = await conn.request().query(sqlQuery);
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
        } catch (err) {
            // Handle connection and logic errors (but not SQL errors)
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
            // connect
            conn = await sql.connect(config);
            
            // get results
            let result = await conn.request().query(sqlQuery);
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
        } catch (err) {
            // Handle connection and logic errors (but not SQL errors)
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
            // connect
            conn = await sql.connect(config);
            
            // get results
            let result = await conn.request().query(sqlQuery);
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
        } catch (err) {
            // Handle connection and logic errors (but not SQL errors)
            res.json(jsonResponse);
            return reject(err);
        }
    });
}

exports.getCardSetDetails = (req, res) => {
    let inputs = {};
    inputs.sport = req.params["sport"];
    inputs.season = req.params["season"];
    inputs.basesetname = req.params["basesetname"];
    inputs.insertsetname = req.params["insertsetname"] == undefined ? '' : req.params["insertsetname"];

    return new Promise(async function(resolve, reject) {
        let conn;
        let jsonResponse;
        let sqlQuery = `SELECT top 1 cs.* FROM cardset cs WITH (NOLOCK) INNER JOIN sport s WITH (NOLOCK) ON cs.Sport_ID = s.ID AND s.Name = '${inputs.sport}' WHERE Season = '${inputs.season}' AND BaseSetName = '${inputs.basesetname}' AND InsertSetName = '${inputs.insertsetname}'`;
    
        try {
            // connect
            conn = await sql.connect(config);
            
            // get results
            let result = await conn.request().query(sqlQuery);
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
        } catch (err) {
            // Handle connection and logic errors (but not SQL errors)
            res.json(jsonResponse);
            return reject(err);
        }
    });
}