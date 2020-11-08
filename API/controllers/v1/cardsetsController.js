//const cardSetModel = require('../models/cardsets');

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
    
    // Connect to DB
    const sql = require('mssql')

    const config = {
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        server: process.env.DB_SERVER,
        database: process.env.DB_NAME,
        options: {
            enableArithAbort: true,
            encrypt: true
        },
        stream: true
    };

    (async function () {
        try {
            const pool = await sql.connect(config)
            const seasonsFromDb = await pool.request()
                .query(`SELECT DISTINCT cs.Season FROM cardset cs WITH (NOLOCK) INNER JOIN sport s WITH (NOLOCK) ON cs.Sport_ID = s.ID AND s.Name = '${inputs.sport}' ORDER BY cs.Season ASC`);
            const records = seasonsFromDb.recordsets[0];
            let seasons = [];
            for (let i = 0; i < records.length; i++) {
                const record = records[i];
                seasons.push(record.Season);
            }

            const jsonResponse = {
                inputs,
                data: {
                    seasons
                }
            };
            res.json(jsonResponse);
        } catch (err) {
            console.log(err);
        }
    })();
     
    sql.on('error', err => {
        console.log(err);
    });
}

// Return a list of base set names for a specified season
exports.getBaseSetNames = (req, res) => {
    // collect inputs
    let inputs = {};
    inputs.sport = req.params["sport"];
    inputs.season = req.params["season"];

    // Connect to DB
    const sql = require('mssql')

    // Configuration
    const config = {
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        server: process.env.DB_SERVER,
        database: process.env.DB_NAME,
        options: {
            enableArithAbort: true,
            encrypt: true
        },
        stream: true
    };


    (async function () {
        try {
            const pool = await sql.connect(config)
            const baseSetsFromDb = await pool.request()
                .query(`SELECT BaseSetName FROM cardset cs WITH (NOLOCK) INNER JOIN sport s WITH (NOLOCK) ON cs.Sport_ID = s.ID AND s.Name = '${inputs.sport}' WHERE Season = '${inputs.season}' AND InsertSetName = '' ORDER BY BaseSetName ASC`);
            const records = baseSetsFromDb.recordsets[0];

            let sets = [];
            for (let i = 0; i < records.length; i++) {
                const record = records[i];
                sets.push(record.BaseSetName);
            }

            const jsonResponse = {
                inputs,
                data: {
                    basesets: sets
                }
            };
            res.json(jsonResponse);
        } catch (err) {
            console.log(err);
        }
    })();

    sql.on('error', err => {
        console.log(err);
    });
}

// Return a list of distinct insert set names within a specified base set (by name) in a specified season
exports.getInsertSetNames = (req, res) => {
    // collect inputs
    let inputs = {};
    inputs.sport = req.params["sport"];
    inputs.season = req.params["season"];
    inputs.basesetname = req.params["basesetname"];

    // Connect to DB
    const sql = require('mssql')

    // Configuration
    const config = {
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        server: process.env.DB_SERVER,
        database: process.env.DB_NAME,
        options: {
            enableArithAbort: true,
            encrypt: true
        },
        stream: true
    };

    (async function () {
        try {
            const pool = await sql.connect(config)
            const insertSetsFromDb = await pool.request()
                .query(`SELECT InsertSetName FROM cardset cs WITH (NOLOCK) INNER JOIN sport s WITH (NOLOCK) ON cs.Sport_ID = s.ID AND s.Name = '${inputs.sport}' WHERE Season = '${inputs.season}' AND BaseSetName = '${inputs.basesetname}' AND InsertSetName <> '' ORDER BY InsertSetName ASC`);
            const records = insertSetsFromDb.recordsets[0];
            
            let sets = [];
            for (let i = 0; i < records.length; i++) {
                const record = records[i];
                sets.push(record.InsertSetName);
            }

            const jsonResponse = {
                inputs,
                data: {
                    insertsets: sets
                }
            };
            res.json(jsonResponse);
        } catch (err) {
            console.log(err);
        }
    })();

    sql.on('error', err => {
        console.log(err);
    });
}

exports.getCardSetDetails = (req, res) => {
    let inputs = {};
    inputs.sport = req.params["sport"];
    inputs.season = req.params["season"];
    inputs.basesetname = req.params["basesetname"];
    inputs.insertsetname = req.params["insertsetname"] == undefined ? '' : req.params["insertsetname"];

    // Connect to DB
    const sql = require('mssql')

    // Configuration
    const config = {
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        server: process.env.DB_SERVER,
        database: process.env.DB_NAME,
        options: {
            enableArithAbort: true,
            encrypt: true
        },
        stream: true
    };

    (async function () {
        try {
            const pool = await sql.connect(config)
            const cardsetDetailsFromDb = await pool.request()
                .query(`SELECT top 1 cs.* FROM cardset cs WITH (NOLOCK) INNER JOIN sport s WITH (NOLOCK) ON cs.Sport_ID = s.ID AND s.Name = '${inputs.sport}' WHERE Season = '${inputs.season}' AND BaseSetName = '${inputs.basesetname}' AND InsertSetName = '${inputs.insertsetname}'`);
            const cardset = cardsetDetailsFromDb.recordset == undefined ? {} : cardsetDetailsFromDb.recordset;
            
            const jsonResponse = {
                inputs,
                data: {
                    cardset
                }
            };
            res.json(jsonResponse);
        } catch (err) {
            console.log(err);
        }
    })();

    sql.on('error', err => {
        console.log(err);
    });
}