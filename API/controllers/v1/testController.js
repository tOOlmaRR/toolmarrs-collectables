// Return a test response
exports.getTestOutput = (req, res) => {
    res.json({
        endpoint: 'test'
    });
}
