// requires
const express = require('express');
const { getTestOutput } = require('../controllers/v1/testController');

// use the Express router
const router = express.Router();

// map up routes to controller methods
router.get(`/`, getTestOutput);

module.exports = router;