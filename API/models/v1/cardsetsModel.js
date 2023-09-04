const sql = require('mssql');
const { poolPromise } = require('../../db');

// Return a test response
exports.getTestSeasons = (req, res) => {
    return new Promise(async function(resolve, reject) {
        if (req["sport"] == 'hockey') {
            return resolve("1990-91");
        } else {
            return reject("BAD INPUT");
        }
    });
}

// Return seasons for a specified sport
exports.getSeasonsFromDB = (sport) => {   
    return new Promise(async function(resolve, reject) {
        let sqlQuery = `SELECT DISTINCT cs.Season FROM cardset cs WITH (NOLOCK) INNER JOIN sport s WITH (NOLOCK) ON cs.Sport_ID = s.ID AND s.Name = @sport ORDER BY cs.Season ASC`;
        try {
            // wait for the SQL connection pool to be ready
            const pool = await poolPromise;
            
            // build prepared statement
            const ps = new sql.PreparedStatement(pool);
            ps.input("sport", sql.VarChar(25));
            await ps.prepare(sqlQuery);
            const parameters = { sport };

            // get results
            await ps.execute(parameters)
                .then(function(result) {
                    const seasonsFromDb = result.recordset == undefined ? [] : result.recordset;
                    let seasons = [];
                    for (let i = 0; i < seasonsFromDb.length; i++) {
                        const record = seasonsFromDb[i];
                        seasons.push(record.Season);
                    }
                    ps.unprepare();
                    return resolve(seasons);
                })
                .catch(function(err) {
                    // handle logic errors after the statement has been executed
                    ps.unprepare();                    
                    return reject(err);
                });      
        } catch (err) {
            // handle connection and statement preparation (SQL) errors
            if (typeof ps !== "undefined")
            {
                ps.unprepare();
            }
            return reject(err);
        }
    });
}

// Return base set names for a specified sport and season
exports.getBaseSetNamesFromDB = (sport, season) => {   
    return new Promise(async function(resolve, reject) {
        let sqlQuery = `SELECT BaseSetName FROM cardset cs WITH (NOLOCK) INNER JOIN sport s WITH (NOLOCK) ON cs.Sport_ID = s.ID AND s.Name = @sport WHERE Season = @season AND InsertSetName = '' ORDER BY BaseSetName ASC`;
        try {
            // wait for the SQL connection pool to be ready
            const pool = await poolPromise;
            
            // build prepared statement
            const ps = new sql.PreparedStatement(pool);
            ps.input("sport", sql.VarChar(25));
            ps.input("season", sql.Char(7));
            await ps.prepare(sqlQuery);
            const parameters = { sport, season };

            // get results
            await ps.execute(parameters)
                .then(function(result) {
                    const baseSetsFromDb = result.recordset == undefined ? [] : result.recordset;
                    let baseSets = [];
                    for (let i = 0; i < baseSetsFromDb.length; i++) {
                        const record = baseSetsFromDb[i];
                        baseSets.push(record.BaseSetName);
                    }

                    ps.unprepare();
                    return resolve(baseSets);
                })
                .catch(function(err) {
                    // handle logic errors after the statement has been executed
                    ps.unprepare();                    
                    return reject(err);
                });      
        } catch (err) {
            // handle connection and statement preparation (SQL) errors
            if (typeof ps !== "undefined")
            {
                ps.unprepare();
            }
            return reject(err);
        }
    });
}
