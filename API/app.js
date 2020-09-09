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



// TODO: Connect to DB


// Bring in route files
const testRoutes = require('./routes/testRoutes');
const cardSetRoutes = require('./routes/cardsetRoutes');

// use middleware
app.use(morgan('dev'));
app.use(bodyParser.json());
app.use(expressValidator());

// set up Controllers as middleware
const apiVersion = process.env.VERSION || 'v1';
app.use(`/${apiVersion}/test`, testRoutes);
app.use(`/${apiVersion}/cardset`, cardSetRoutes);

// export app to server
module.exports = app;