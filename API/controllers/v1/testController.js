// ENDPOINT: Test Controller Test
// Return a test response
exports.getTestOutput = (req, res) => {
    const endpointName = 'Test Controller Test';
    return res.json({
        endpoint: endpointName
    });
}
