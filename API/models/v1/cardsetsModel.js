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

// Return a list of distinct seasons based on all card sets in the database for the specified sport
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

// Return a list of base set names for a specified sport and season
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
                    const baseSetNamesFromDb = result.recordset == undefined ? [] : result.recordset;
                    let baseSetNames = [];
                    for (let i = 0; i < baseSetNamesFromDb.length; i++) {
                        const record = baseSetNamesFromDb[i];
                        baseSetNames.push(record.BaseSetName);
                    }

                    ps.unprepare();
                    return resolve(baseSetNames);
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

// Return a list of insert set names within a specified base set (by name) in a specified season and sport
exports.getInsertSetNamesFromDB = (sport, season, baseSetName) => {   
    return new Promise(async function(resolve, reject) {
        let sqlQuery = `SELECT InsertSetName FROM cardset cs WITH (NOLOCK) INNER JOIN sport s WITH (NOLOCK) ON cs.Sport_ID = s.ID AND s.Name = @sport WHERE Season = @season AND BaseSetName = @baseSetName AND InsertSetName <> '' ORDER BY InsertSetName ASC`;
        try {
            // wait for the SQL connection pool to be ready
            const pool = await poolPromise;
            
            // build prepared statement
            const ps = new sql.PreparedStatement(pool);
            ps.input("sport", sql.VarChar(25));
            ps.input("season", sql.Char(7));
            ps.input("baseSetName", sql.VarChar(100));
            await ps.prepare(sqlQuery);
            const parameters = { sport, season, baseSetName };

            // get results
            await ps.execute(parameters)
                .then(function(result) {
                    const insertSetNamesFromDb = result.recordset == undefined ? [] : result.recordset;
                    let insertSetNames = [];
                    for (let i = 0; i < insertSetNamesFromDb.length; i++) {
                        const record = insertSetNamesFromDb[i];
                        insertSetNames.push(record.InsertSetName);
                    }

                    ps.unprepare();
                    return resolve(insertSetNames);
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

// returns all details for a specified card set (base set or insert set) in a specific season and sport
exports.getCardSetDetailsFromDB = (sport, season, baseSetName, insertSetName) => {   
    return new Promise(async function(resolve, reject) {
        let sqlQuery = `SELECT top 1 cs.* FROM cardset cs WITH (NOLOCK) INNER JOIN sport s WITH (NOLOCK) ON cs.Sport_ID = s.ID AND s.Name = @sport WHERE Season = @season AND BaseSetName = @baseSetName AND InsertSetName = @insertSetName`;
        try {
            // wait for the SQL connection pool to be ready
            const pool = await poolPromise;
            
            // build prepared statement
            const ps = new sql.PreparedStatement(pool);
            ps.input("sport", sql.VarChar(25));
            ps.input("season", sql.Char(7));
            ps.input("baseSetName", sql.VarChar(100));
            ps.input("insertSetName", sql.VarChar(100));
            
            // if provided insert set name is undefined, treat it as an empty string when querying the DB
            if (insertSetName == undefined)
            {
                insertSetName = '';
            }

            await ps.prepare(sqlQuery);
            const parameters = { sport, season, baseSetName, insertSetName };

            // get results
            await ps.execute(parameters)
                .then(function(result) {
                    const cardsetDetailsFromDb = result.recordset == undefined ? [] : result.recordset;
                    let cardsetDetails = [];
                    for (let i = 0; i < cardsetDetailsFromDb.length; i++) {
                        const record = cardsetDetailsFromDb[i];
                        cardsetDetails.push(record);
                    }

                    ps.unprepare();
                    return resolve(cardsetDetails);
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
