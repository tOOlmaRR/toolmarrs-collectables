const request = require('supertest');
const app = require('../app');

const testEndpoint = '/v1/cardsets/test';
describe('Test Endpoint', () => {
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
describe('View Seasons Endpoint', () => {
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
describe('View Base Sets Endpoints', () => {
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
describe('View Insert Sets Endpoint', () => {
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

const viewBaseSetDetailsEndpoint = '/v1/cardsets/:season/:basesetname';
describe('View Card Set Endpoint for a Base Set', () => {
    test('Should return a 200 HTTP status code', async() => {
        const season = 'anything';
        const baseSetname = 'anything';
        const response = await request(app).get(
            viewBaseSetDetailsEndpoint.replace(':season', season)
                .replace(':basesetname', baseSetname)
        );
        expect(response.statusCode).toBe(200);
    });

    test('Should return JSON including a "cardset" object within a "data" object', async() => {
        const season = 'anything';
        const baseSetname = 'anything';
        const response = await request(app).get(
            viewBaseSetDetailsEndpoint.replace(':season', season)
                .replace(':basesetname', baseSetname)
        );
        const responseBody = response.body;
        expect(responseBody['data']).toBeDefined();
        expect(responseBody['data']['cardset']).toBeDefined();
        expect(typeof(responseBody['data'])).toBe('object');
        expect(typeof(responseBody['data']['cardset'])).toBe('object');
    });
});

const viewInsertSetDetailsEndpoint = '/v1/cardsets/:season/:basesetname/:insertsetname';
describe('View Card Set Endpoint for an Insert Set', () => {
    test('Should return a 200 HTTP status code', async() => {
        const season = 'anything';
        const baseSetname = 'anything';
        const insertSetName = 'anything';    
        const response = await request(app).get(viewInsertSetDetailsEndpoint
            .replace(':season', season)
            .replace(':basesetname', baseSetname)
            .replace(':insertsetname', insertSetName)
            );
        expect(response.statusCode).toBe(200);
    });

    test('Should return JSON including a "cardset" object within a "data" object', async() => {
        const season = 'anything';
        const baseSetname = 'anything';
        const insertSetName = 'anything';
        const response = await request(app).get(viewInsertSetDetailsEndpoint
            .replace(':season', season)
            .replace(':basesetname', baseSetname)
            .replace(':insertsetname', insertSetName)
            );
        const responseBody = response.body;
        expect(responseBody['data']).toBeDefined();
        expect(responseBody['data']['cardset']).toBeDefined();
        expect(typeof(responseBody['data'])).toBe('object');
        expect(typeof(responseBody['data']['cardset'])).toBe('object');
    });
});

// avoid jest open handle error
afterAll(async () => {
	await new Promise(resolve => setTimeout(() => resolve(), 500));
});
   