//const cardSetModel = require('../models/cardsets');

// Return a test response
exports.getTestOutput = (req, res) => {
    res.json({
        endpoint: 'cardsets test'
    });
}

// Return a test response
exports.getSeasons = (req, res) => {
    // Connect to DB
    const sql = require('mssql')

    // Configuration
    const config = {
        user: 'Urgele1',
        password: 'goldmOOn78!',
        server: 'MARR2\\GMARRMSSQL1',
        database: 'GeosTradingCards',
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
                .query('select distinct season from cardset');
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
    })()
     
    sql.on('error', err => {
        console.log(err);
    })
}