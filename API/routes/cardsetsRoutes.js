// requires
const express = require('express');
const { getTestOutput, getSeasons } = require('../controllers/v1/cardsetsController');

// use the Express router
const router = express.Router();

// map up routes to controller methods
router.get(`/test`, getTestOutput);
router.get(`/seasons`, getSeasons);

module.exports = router;