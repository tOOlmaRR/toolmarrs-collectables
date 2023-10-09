const { getTestSeasons, getSeasonsFromDB, getBaseSetNamesFromDB, getInsertSetNamesFromDB, getCardSetDetailsFromDB } = require('../../models/v1/cardsetsModel');
const inputValidator = require('../../validators/inputValidator');



// ENDPOINT: Cardsets Controller Test
// Return a test response directly from the controller
exports.getControllerTestResponse = (req, res) => {
    const endpointName = 'Cardsets Controller Test';
    return res.json({
        endpoint: endpointName
    });
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
            return res.json({
                inputs,
                endpoint: endpointName,
                data: {
                    seasons: result
                }
            });
        })
        .catch(error => {
            return res.json({
                inputs,
                endpoint: endpointName,
                error: { message: error }
            });
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
        const jsonResponse = {
            inputs,
            endpoint: endpointName,
            error: {
                message: "Input Validation Failed (sport)"
            }
        };
        res.status(400);
        return res.json(jsonResponse);
    }

    // Query the DB via the model for seasons data
    getSeasonsFromDB(inputs.sport)
        .then(result => {
            return res.json({
                inputs,
                endpoint: endpointName,
                data: {
                    seasons: result
                }
            });
        })
        .catch(error => {
            res.status(400);
            return res.json({
                inputs,
                endpoint: endpointName,
                error: {
                    message: error.message,
                    stack: error.stack
                }
            });
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

        const jsonResponse = {
            inputs,
            endpoint: endpointName,
            error: {
                message: `Input Validation Failed (${invalidInputs})`
            }
        };
        res.status(400);
        return res.json(jsonResponse);
    }

    // Query the DB via the model for base set names
    getBaseSetNamesFromDB(inputs.sport, inputs.season)
    .then(result => {
        return res.json({
            inputs,
            endpoint: endpointName,
            data: {
                basesetnames: result
            }
        });
    })
    .catch(error => {
        res.status(400);
        return res.json({
            inputs,
            endpoint: endpointName,
            error: {
                message: error.message,
                stack: error.stack
            }
        });
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
        const jsonResponse = {
            inputs,
            endpoint: endpointName,
            error: {
                message: `Input Validation Failed (${invalidInputsString})`
            }
        };
        res.status(400);
        return res.json(jsonResponse);
    }

    // Query the DB via the model for base set names
    getInsertSetNamesFromDB(inputs.sport, inputs.season, inputs.basesetname)
    .then(result => {
        return res.json({
            inputs,
            endpoint: endpointName,
            data: {
                insertsetnames: result
            }
        });
    })
    .catch(error => {
        res.status(400);
        return res.json({
            inputs,
            endpoint: endpointName,
            error: {
                message: error.message,
                stack: error.stack
            }
        });
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
        const jsonResponse = {
            inputs,
            endpoint: endpointName,
            error: {
                message: `Input Validation Failed (${invalidInputsString})`
            }
        };
        res.status(400);
        return res.json(jsonResponse);
    }

    // Query the DB via the model for base set names
    getCardSetDetailsFromDB(inputs.sport, inputs.season, inputs.basesetname, inputs.insertsetname)
    .then(result => {
        return res.json({
            inputs,
            endpoint: endpointName,
            data: {
                cardset: result
            }
        });
    })
    .catch(error => {
        res.status(400);
        return res.json({
            inputs,
            endpoint: endpointName,
            error: {
                message: error.message,
                stack: error.stack
            }
        });
    });
}
