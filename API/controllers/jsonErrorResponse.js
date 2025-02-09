class JsonErrorResponse
{
    constructor(version, inputs, endpoint, error) {
        this.version = version;
        this.inputs = inputs;
        this.endpoint = endpoint;
        this.error = error
    }
}
module.exports = JsonErrorResponse