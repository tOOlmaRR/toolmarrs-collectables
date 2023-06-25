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
    stream: false
}

const poolPromise = new sql.ConnectionPool(config)
  .connect()
  .then(pool => {
    if (process.env.NODE_ENV !== 'test') {
      console.log('Connected to MSSQL');
    }
    return pool
  })
  .catch(err => console.log('Database Connection Failed! Bad Config: ', err))

module.exports = {
  sql, poolPromise
}