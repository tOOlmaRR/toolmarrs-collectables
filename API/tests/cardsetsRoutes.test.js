const request = require('supertest');
const app = require('../app');

const testEndpoint = '/v1/cardsets/test';
describe(`GET ${testEndpoint}`, () => {
    test('Should return a 200 HTTP status code', async() => {
        const response = await request(app).get(testEndpoint);
        expect(response.statusCode).toBe(200);
    });

    test('Should return JSON that tells us which endpoint we are hitting', async() => {
        const response = await request(app).get(testEndpoint);
        const responseBody = response.body;
        expect(response.body['endpoint']).toBe('cardsets test');
    });
});

const viewSeasonsEndpoint = '/v1/cardsets/seasons';
describe(`GET ${viewSeasonsEndpoint}`, () => {
    test('Should return a 200 HTTP status code', async() => {
        const response = await request(app).get(viewSeasonsEndpoint);
        expect(response.statusCode).toBe(200);
    });

    test('Should return JSON including a seasons array within a data object', async() => {
        const response = await request(app).get(viewSeasonsEndpoint);
        const responseBody = response.body;
        expect(responseBody['data']).toBeDefined();
        expect(typeof(responseBody['data']['seasons'])).toBe('object');
        expect(responseBody['data']['seasons']).toBeDefined();
        expect(typeof(responseBody['data']['seasons'])).toBe('object');
        expect(Array.isArray(responseBody['data']['seasons'])).toBe(true);
    });
});

// const viewBaseCardsetListEndpoint = '/v1/cardsets/basesets';
// describe(`GET ${viewBaseCardsetListEndpoint}`, () => {
//     test('Should return a 200 HTTP status code', async() => {
//         const response = await request(app).get(viewBaseCardsetListEndpoint);
//         expect(response.statusCode).toBe(200);
//     });

//     test('Should return JSON that tells us which endpoint we are hitting', async() => {
//         const response = await request(app).get(viewBaseCardsetListEndpoint);
//         const responseBody = response.body;
//         expect(response.body['data']).toBeDefined();
//     });
// });

 // avoid jest open handle error
afterAll(async () => {
	await new Promise(resolve => setTimeout(() => resolve(), 500));
});
   