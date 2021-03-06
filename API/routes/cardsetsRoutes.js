// requires
const express = require('express');
const { getTestOutput, getSeasons, getBaseSetNames, getInsertSetNames, getCardSetDetails } = require('../controllers/v1/cardsetsController');

// use the Express router
const router = express.Router();

// map up routes to controller methods
router.get(`/test`, getTestOutput);
router.get(`/:sport/seasons`, getSeasons);
router.get(`/:sport/:season/basesets`, getBaseSetNames);
router.get(`/:sport/:season/:basesetname/insertsets`, getInsertSetNames);
router.get('/details/:sport/:season/:basesetname', getCardSetDetails);
router.get('/details/:sport/:season/:basesetname/:insertsetname', getCardSetDetails);

module.exports = router;