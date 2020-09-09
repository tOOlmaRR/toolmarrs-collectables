const request = require('supertest');
const app = require('../app');

// const test = require('../controllers/v1/test');

describe("GET /v1/test", () => {
    test('Should return a 200 HTTP status code', async() => {
        const response = await request(app).get('/v1/test');
        expect(response.statusCode).toBe(200);
    });

    test('Should return JSON that tells us which endpoint we are hitting', async() => {
        const response = await request(app).get('/v1/test');
        const responseBody = response.body;
        //console.log(responseBody);
        expect(response.body['endpoint']).toBe('test');
    });
});