// requires
const express = require('express');
const { getTestOutput } = require('../controllers/v1/cardset');

// use the Express router
const router = express.Router();

// map up routes to controller methods
//router.get('/v1/test', getTestOutput);
//router.get(`/${process.env.VERSION}/test`, getTestOutput);
router.get(`/`, getTestOutput);

module.exports = router;