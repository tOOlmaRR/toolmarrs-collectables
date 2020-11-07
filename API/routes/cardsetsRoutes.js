// requires
const express = require('express');
const { getTestOutput, getSeasons, getBaseSetNamesBySeason, getInsertSetNamesByBaseSetNameAndSeason, getCardSetDetails } = require('../controllers/v1/cardsetsController');

// use the Express router
const router = express.Router();

// map up routes to controller methods
router.get(`/test`, getTestOutput);
router.get(`/:sport/seasons`, getSeasons);

//TODO: UPDATE THESE
router.get(`/:season/basesets`, getBaseSetNamesBySeason);
router.get(`/:season/:basesetname/insertsets`, getInsertSetNamesByBaseSetNameAndSeason);
router.get('/:season/:basesetname', getCardSetDetails);
router.get('/:season/:basesetname/:insertsetname', getCardSetDetails);

module.exports = router;