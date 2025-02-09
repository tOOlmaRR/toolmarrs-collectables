const JsonResponse = require('./jsonResponseV1');



// ENDPOINT: Test Controller Test
// Return a test response
exports.getTestOutput = (req, res) => {
    const inputs = {};
    const endpointName = 'Test Controller Test';
    const data = {};
    
    const result = new JsonResponse(inputs, endpointName, data)
    return res.json(result);
}
