const JsonErrorResponse = require("../jsonErrorResponse");

class JsonErrorResponseV1 extends JsonErrorResponse
{
    constructor(inputs, endpoint, error) {
        super("1", inputs, endpoint, error);
    }
}

module.exports = JsonErrorResponseV1;