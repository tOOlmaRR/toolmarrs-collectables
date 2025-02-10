class JsonResponse
{
    constructor(version, inputs, endpoint, data) {
        this.version = version;
        this.inputs = inputs;
        this.endpoint = endpoint;
        this.data = data;
    }
}
module.exports = JsonResponse