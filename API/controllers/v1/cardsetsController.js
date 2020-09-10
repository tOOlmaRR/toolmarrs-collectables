//const cardSetModel = require('../models/cardsets');

// Return a test response
exports.getTestOutput = (req, res) => {
    res.json({
        endpoint: 'cardsets test'
    });
}

// Return a list of distinct seasons based on all card sets in the database
exports.getSeasons = (req, res) => {
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
    //console.log(config);

    (async function () {
        try {
            const pool = await sql.connect(config)
            const seasonsFromDb = await pool.request()
                .query('SELECT DISTINCT season FROM cardset ORDER BY season ASC');
            const records = seasonsFromDb.recordsets[0];
            let seasons = [];
            for (let i = 0; i < records.length; i++) {
                const record = records[i];
                seasons.push(record.season);
            }
            //console.log(seasons);
            const jsonResponse = {
                data: {
                    seasons
                }
            };
            //console.log(jsonResponse);
            res.json(jsonResponse);
        } catch (err) {
            console.log(err);
        }
    })();
     
    sql.on('error', err => {
        console.log(err);
    });
}

// Return a list of distinct base sets (just their names) for a specified season
exports.getBaseSetNamesBySeason = (req, res) => {
    const season = req.params["season"];

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
    //console.log(config);

    (async function () {
        try {
            const pool = await sql.connect(config)
            const baseSetsFromDb = await pool.request()
                .query(`SELECT BaseSetName FROM cardset WHERE Season = '${season}' AND InsertSetName = '' ORDER BY BaseSetName ASC`);
            const records = baseSetsFromDb.recordsets[0];
            //console.log(records);
            let sets = [];
            for (let i = 0; i < records.length; i++) {
                const record = records[i];
                sets.push(record.BaseSetName);
            }
            console.log(sets);
            const jsonResponse = {
                data: {
                    baseSets: sets
                }
            };
            console.log(jsonResponse);
            res.json(jsonResponse);
        } catch (err) {
            console.log(err);
        }
    })();

    sql.on('error', err => {
        console.log(err);
    });
}