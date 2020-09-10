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

    test('Should return JSON including a "seasons" array within a "data" object', async() => {
        const response = await request(app).get(viewSeasonsEndpoint);
        const responseBody = response.body;
        expect(responseBody['data']).toBeDefined();
        expect(responseBody['data']['seasons']).toBeDefined();
        expect(typeof(responseBody['data'])).toBe('object');
        expect(typeof(responseBody['data']['seasons'])).toBe('object');
        expect(Array.isArray(responseBody['data']['seasons'])).toBe(true);
    });
});

const viewBaseCardsetListEndpoint = '/v1/cardsets/:season/basesets';
describe(`GET ${viewBaseCardsetListEndpoint}`, () => {
    test('Should return a 200 HTTP status code', async() => {
        const season = 'anything';
        const response = await request(app).get(viewBaseCardsetListEndpoint.replace(':season', season));
        expect(response.statusCode).toBe(200);
    });

    test('Should return JSON including a "baseSets" array within a "data" object', async() => {
        const season = 'anything';
        const response = await request(app).get(viewBaseCardsetListEndpoint.replace(':season', season));
        const responseBody = response.body;
        expect(responseBody['data']).toBeDefined();
        expect(responseBody['data']['baseSets']).toBeDefined();
        expect(typeof(responseBody['data'])).toBe('object');
        expect(typeof(responseBody['data']['baseSets'])).toBe('object');
        expect(Array.isArray(responseBody['data']['baseSets'])).toBe(true);
    });
});

const viewInsertSetListEndpoint = '/v1/cardsets/:season/:basesetname/insertsets';
describe(`GET ${viewInsertSetListEndpoint}`, () => {
    test('Should return a 200 HTTP status code', async() => {
        const season = 'anything';
        const baseSetName = 'anything';
        const response = await request(app).get(viewInsertSetListEndpoint.replace(':season', season).replace(':basesetname', baseSetName));
        expect(response.statusCode).toBe(200);
    });

    test('Should return JSON including a "insertSets" array within a "data" object', async() => {
        const season = 'anything';
        const baseSetName = 'anything';
        const response = await request(app).get(viewInsertSetListEndpoint.replace(':season', season).replace(':basesetname', baseSetName));
        const responseBody = response.body;
        expect(responseBody['data']).toBeDefined();
        expect(responseBody['data']['insertSets']).toBeDefined();
        expect(typeof(responseBody['data'])).toBe('object');
        expect(typeof(responseBody['data']['insertSets'])).toBe('object');
        expect(Array.isArray(responseBody['data']['insertSets'])).toBe(true);
    });
});

 // avoid jest open handle error
afterAll(async () => {
	await new Promise(resolve => setTimeout(() => resolve(), 500));
});
   