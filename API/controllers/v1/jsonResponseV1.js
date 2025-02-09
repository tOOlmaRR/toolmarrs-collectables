const JsonResponse = require("../jsonResponse");

class JsonResponseV1 extends JsonResponse
{
    constructor(inputs, endpoint, data) {
        super("1", inputs, endpoint, data);
    }
}

module.exports = JsonResponseV1;