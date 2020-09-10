// requires
const express = require('express');
const { getTestOutput, getSeasons, getBaseSetNamesBySeason, getInsertSetNamesByBaseSetNameAndSeason } = require('../controllers/v1/cardsetsController');

// use the Express router
const router = express.Router();

// map up routes to controller methods
router.get(`/test`, getTestOutput);
router.get(`/seasons`, getSeasons);
router.get(`/:season/basesets`, getBaseSetNamesBySeason);
router.get(`/:season/:basesetname/insertsets`, getInsertSetNamesByBaseSetNameAndSeason);

module.exports = router;