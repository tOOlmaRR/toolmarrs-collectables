const { getTestSeasons, getSeasonsFromDB, getBaseSetNamesFromDB, getInsertSetNamesFromDB, getCardSetDetailsFromDB } = require('../../models/v1/cardsetsModel');
const inputValidator = require('../../validators/inputValidator');
const JsonResponse = require('./jsonResponseV1');
const JsonErrorResponse = require('./jsonErrorResponseV1');



// ENDPOINT: Cardsets Controller Test
// Return a test response directly from the controller
exports.getControllerTestResponse = (req, res) => {
    const inputs = {};
    const endpointName = 'Cardsets Controller Test';
    const data = {};
    return res.json(new JsonResponse(inputs, endpointName, data));
}



// ENDPOINT: Cardsets Model Test
// Return a test response from the model
exports.getModelTestResponse = (req, res) => {
    const endpointName = 'Cardsets Model Test';
    
    // collect inputs
    let inputs = {};
    inputs.sport = req.params["sport"];

    // Get a test reponse via the model
    getTestSeasons(inputs)
        .then(result => {
            const data =  {
                seasons: result
            };
            return res.json(new JsonResponse(inputs, endpointName, data));
        })
        .catch(error => {
            const errorNode =  { message: error };
            return res.json(new JsonErrorResponse(inputs, endpointName, errorNode));
        });
}



// ENDPOINT: View Seasons
// Return a list of distinct seasons based on all card sets in the database for the specified sport
exports.getSeasons = (req, res) => {
    const endpointName = 'View Seasons';
    
    // collect inputs
    let inputs = {};
    inputs.sport = req.params["sport"];
    
    // validate inputs and return response if invalid
    const validSeason = inputValidator.validateSport(inputs.sport)
    if (!validSeason)
    {
        const errorNode = { message: "Input Validation Failed (sport)" };
        res.status(400);
        return res.json(new JsonErrorResponse(inputs, endpointName, errorNode));
    }

    // Query the DB via the model for seasons data
    getSeasonsFromDB(inputs.sport)
        .then(result => {
            const dataNode = { seasons: result };
            return res.json(new JsonResponse(inputs, endpointName, dataNode));
        })
        .catch(error => {
            const errorNode = {
                message: "Input Validation Failed (sport)",
                stack: error.stack
            };
            return res.json(new JsonErrorResponse(inputs, endpointName, errorNode));
        });
}



// ENDPOINT: View Base Set Names
// Return a list of base set names for a specified sport and season
exports.getBaseSetNames = (req, res) => {
    const endpointName = 'View Base Set Names';
    
    // collect inputs
    let inputs = {};
    inputs.sport = req.params["sport"];
    inputs.season = req.params["season"];

    // validate inputs
    const validSport = inputValidator.validateSport(inputs.sport);
    const validSeason = inputValidator.validateSeason(inputs.season);
    if (!validSport || !validSeason)
    {
        let invalidInputs;
        if (!validSport && !validSeason) invalidInputs = "sport and season";
        else if (!validSport) invalidInputs = "sport";
        else if (!validSeason) invalidInputs = "season";

        const errorNode = { message: `Input Validation Failed (${invalidInputs})` };
        res.status(400);
        return res.json(new JsonErrorResponse(inputs, endpointName, errorNode));
    }

    // Query the DB via the model for base set names
    getBaseSetNamesFromDB(inputs.sport, inputs.season)
    .then(result => {
        const dataNode = { basesetnames: result };
        return res.json(new JsonResponse(inputs, endpointName, dataNode));
    })
    .catch(error => {
        const errorNode = {
            message: error.message,
            stack: error.stack
        };
        res.status(400);
        return res.json(new JsonErrorResponse(inputs, endpointName, errorNode));
    });
}



// ENDPOINT: View Insert Set Names
// Return a list of insert set names within a specified base set (by name) in a specified season and sport
exports.getInsertSetNames = (req, res) => {
    const endpointName = 'View Insert Set Names';
    
    // collect inputs
    let inputs = {};
    inputs.sport = req.params["sport"];
    inputs.season = req.params["season"];
    inputs.basesetname = req.params["basesetname"];

    // validate inputs
    const validSport = inputValidator.validateSport(inputs.sport);
    const validSeason = inputValidator.validateSeason(inputs.season);
    const validBaseSetName = inputValidator.validateBaseSetName(inputs.basesetname);
    
    if (!validSport || !validSeason || !validBaseSetName)
    {
        let invalidInputs = [];
        if (!validSport) invalidInputs.push("sport");
        if (!validSeason) invalidInputs.push("season");
        if (!validBaseSetName) invalidInputs.push("base set name");

        const invalidInputsString = invalidInputs.join();
        const errorNode = { message: `Input Validation Failed (${invalidInputs})` };
        res.status(400);
        return res.json(new JsonErrorResponse(inputs, endpointName, errorNode));
    }

    // Query the DB via the model for base set names
    getInsertSetNamesFromDB(inputs.sport, inputs.season, inputs.basesetname)
    .then(result => {
        const dataNode = { insertsetnames: result };
        return res.json(new JsonResponse(inputs, endpointName, dataNode));
    })
    .catch(error => {
        const errorNode = {
            message: error.message,
            stack: error.stack
        };
        res.status(400);
        return res.json(new JsonErrorResponse(inputs, endpointName, errorNode));
    });
}



// ENDPOINT: View Card Set Details
// returns all details for a specified card set (base set or insert set) in a specific season and sport
exports.getCardSetDetails = (req, res) => {
    const endpointName = 'View Card Set Details';
    
    // collect inputs
    let inputs = {};
    inputs.sport = req.params["sport"];
    inputs.season = req.params["season"];
    inputs.basesetname = req.params["basesetname"];
    inputs.insertsetname = req.params["insertsetname"]

    // validate inputs
    const validSport = inputValidator.validateSport(inputs.sport);
    const validSeason = inputValidator.validateSeason(inputs.season);
    const validBaseSetName = inputValidator.validateBaseSetName(inputs.basesetname);
    const validInsertSetName = inputValidator.validateInsertSetName(inputs.insertsetname);

    if (!validSport || !validSeason || !validBaseSetName || !validInsertSetName)
    {
        let invalidInputs = [];
        if (!validSport) invalidInputs.push("sport");
        if (!validSeason) invalidInputs.push("season");
        if (!validBaseSetName) invalidInputs.push("base set name");
        if (!validInsertSetName) invalidInputs.push("insert set name");

        const invalidInputsString = invalidInputs.join();
        const errorNode = { message: `Input Validation Failed (${invalidInputs})` };
        res.status(400);
        return res.json(new JsonErrorResponse(inputs, endpointName, errorNode));
    }

    // Query the DB via the model for base set names
    getCardSetDetailsFromDB(inputs.sport, inputs.season, inputs.basesetname, inputs.insertsetname)
    .then(result => {
        const dataNode = { cardset: result };
        return res.json(new JsonResponse(inputs, endpointName, dataNode));
    })
    .catch(error => {
        const errorNode = {
            message: error.message,
            stack: error.stack
        };
        res.status(400);
        return res.json(new JsonErrorResponse(inputs, endpointName, errorNode));
    });
}
