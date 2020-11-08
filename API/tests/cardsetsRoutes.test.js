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

const viewSeasonsEndpoint = '/v1/cardsets/:sport/seasons';
describe('View Seasons Endpoint', () => {
    test('Should return a 200 HTTP status code', async() => {
        const sport = 'hockey';
        const response = await request(app).get(viewSeasonsEndpoint.replace(':sport', sport));
        expect(response.statusCode).toBe(200);
    });

    test('Should return JSON including an "inputs" array with the received key-value pairs and a "seasons" array within a "data" object', async() => {
        const sport = 'hockey';
        const response = await request(app).get(viewSeasonsEndpoint.replace(':sport', sport));
        const responseBody = response.body;
        
        expect(responseBody['inputs']).toBeDefined();
        expect(typeof(responseBody['inputs'])).toBe('object');
        
        expect(responseBody['inputs']['sport']).toBeDefined();
        expect(typeof(responseBody['inputs']['sport'])).toBe('string');
        expect(responseBody['inputs']['sport']).toBe(sport);
        
        expect(responseBody['data']).toBeDefined();
        expect(typeof(responseBody['data'])).toBe('object');
        
        expect(responseBody['data']['seasons']).toBeDefined();
        expect(typeof(responseBody['data']['seasons'])).toBe('object');
        expect(Array.isArray(responseBody['data']['seasons'])).toBe(true);
    });
});

const viewBaseCardsetListEndpoint = '/v1/cardsets/:sport/:season/basesets';
describe('View Base Sets Endpoint', () => {
    test('Should return a 200 HTTP status code', async() => {
        const sport = 'hockey';
        const season = 'anything';
        const response = await request(app).get(viewBaseCardsetListEndpoint.replace(':sport', sport).replace(':season', season));
        expect(response.statusCode).toBe(200);
    });

    test('Should return JSON including an "inputs" array with the received key-value pairs and a "basesets" array within a "data" object', async() => {
        const sport = 'hockey';
        const season = 'anything';
        const response = await request(app).get(viewBaseCardsetListEndpoint.replace(':sport', sport).replace(':season', season));
        const responseBody = response.body;
        
        expect(responseBody['inputs']).toBeDefined();
        expect(typeof(responseBody['inputs'])).toBe('object');

        expect(responseBody['inputs']['sport']).toBeDefined();
        expect(typeof(responseBody['inputs']['sport'])).toBe('string');
        expect(responseBody['inputs']['sport']).toBe(sport);

        expect(responseBody['inputs']['season']).toBeDefined();
        expect(typeof(responseBody['inputs']['season'])).toBe('string');
        expect(responseBody['inputs']['season']).toBe(season);
        
        expect(responseBody['data']).toBeDefined();
        expect(typeof(responseBody['data'])).toBe('object');

        expect(responseBody['data']['basesets']).toBeDefined();
        expect(typeof(responseBody['data']['basesets'])).toBe('object');
        expect(Array.isArray(responseBody['data']['basesets'])).toBe(true);
    });
});

// TODO: UPDATE THESE

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
   