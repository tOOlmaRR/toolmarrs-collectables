// body-parser (https://www.npmjs.com/package/body-parser)
// middleware that parses HTTP request bodies
const bodyParser = require('body-parser');

// dotenv (https://www.npmjs.com/package/dotenv)
// load environment-specific configuration files
const dotenv = require('dotenv');
dotenv.config();

// express (https://www.npmjs.com/package/express)
// minimalistic web framework
const express = require('express');
const app = express();

// express-validator (https://www.npmjs.com/package/express-validator)
// middleware that improves validation
const expressValidator = require('express-validator');

// morgan (https://www.npmjs.com/package/morgan)
// middleware that logs http requests
const morgan = require('morgan');



// Connect to DB


// Bring in routes
const testRoutes = require('./routes/test');
//const cardSetRoutes = require('./routes/cardset');

// use middleware
app.use(morgan('dev'));
app.use(bodyParser.json());
app.use(expressValidator());

// set up endpoints: Controllers act as a middleware
app.get(`/${process.env.VERSION}/test`, testRoutes);

// start a server
const port = process.env.PORT || 8080;
app.listen(port, () => {
    console.log(`Listening on port ${port}`)
});