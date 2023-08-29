const sql = require('mssql');
const { poolPromise } = require('../../db');

// Return a test response (seasons)
exports.getTestSeasons = (req, res) => {
    return new Promise(async function(resolve, reject) {
        if (req["sport"] == 'hockey') {
            return resolve("1990-91");
        } else {
            return reject("BAD INPUT");
        }
    });
}

