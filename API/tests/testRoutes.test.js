const request = require('supertest');
const app = require('../app');

// ENDPOINT: Test Controller Test
const testEndpoint = '/v1/test';
describe('Test Controller Test', () => {
    test('Should return a 200 HTTP status code', async() => {
        const response = await request(app).get(testEndpoint);
        expect(response.statusCode).toBe(200);
    });

    test('Should return standard JSON response', async() => {
        const response = await request(app).get(testEndpoint);
        const responseBody = response.body;
        expect(responseBody['inputs']).toBeDefined();
        expect(responseBody['endpoint']).toBe('Test Controller Test');
        expect(responseBody['data']).toBeDefined();
        expect(responseBody['error']).not.toBeDefined();
    });
});

 // avoid jest open handle error
afterAll(async () => {
    await new Promise(resolve => setTimeout(() => resolve(), 500));
});