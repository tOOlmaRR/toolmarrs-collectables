const request = require('supertest');
const app = require('../app');

const controllerTestEndpoint = '/v1/cardsets/test';
describe('Test Endpoint', () => {
    test('Should return a 200 HTTP status code', async() => {
        const response = await request(app).get(controllerTestEndpoint);
        expect(response.statusCode).toBe(200);
    });

    test('Should return JSON that tells us which endpoint we are hitting', async() => {
        const response = await request(app).get(controllerTestEndpoint);
        const responseBody = response.body;
        expect(responseBody['endpoint']).toBe('cardsets controller test');
    });
});

const seasonsModelTestEndpoint = '/v1/cardsets/test/:sport/seasons';
describe('Test Endpoint', () => {
    test('Should return a 200 HTTP status code', async() => {
        const sport = 'hockey';
        const response = await request(app).get(seasonsModelTestEndpoint.replace(':sport', sport));
        expect(response.statusCode).toBe(200);
    });

    test('Should return JSON that tells us which endpoint we are hitting', async() => {
        const sport = 'hockey';
        const response = await request(app).get(seasonsModelTestEndpoint.replace(':sport', sport));
        const responseBody = response.body;
        expect(responseBody['endpoint']).toBe('cardsets seasons test');
    });

    test('Should return an appropriate JSON results response with data and seasons nodes', async() => {
        const sport = 'hockey';
        const response = await request(app).get(seasonsModelTestEndpoint.replace(':sport', sport));
        const responseBody = response.body;
        expect(responseBody['data']).toBeDefined();
        expect(responseBody['data']['seasons']).toBeDefined();
        expect(responseBody['data']['seasons']).toBe('1990-91');
    });

    test('Should return an appropriate JSON error response with an error node', async() => {
        const sport = 'BADINPUT';
        const response = await request(app).get(seasonsModelTestEndpoint.replace(':sport', sport));
        const responseBody = response.body;
        expect(responseBody['error']).toBeDefined();
        expect(responseBody['error']).toBe('BAD INPUT');
        expect(responseBody['data']).not.toBeDefined();
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

        expect(responseBody['error']).not.toBeDefined();
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

const viewInsertSetListEndpoint = '/v1/cardsets/:sport/:season/:basesetname/insertsets';
describe('View Insert Sets Endpoint', () => {
    test('Should return a 200 HTTP status code', async() => {
        const sport = 'hockey';
        const season = 'anything';
        const baseSetName = 'anything';
        const response = await request(app).get(viewInsertSetListEndpoint.replace(':sport', sport)
            .replace(':season', season)
            .replace(':basesetname', baseSetName));
        expect(response.statusCode).toBe(200);
    });

    test('Should return JSON including an "inputs" array with the received key-value pairs and an "insertsets" array within a "data" object', async() => {
        const sport = 'hockey';
        const season = 'anything';
        const baseSetName = 'anything';
        const response = await request(app).get(viewInsertSetListEndpoint.replace(':sport', sport)
            .replace(':season', season)
            .replace(':basesetname', baseSetName));
        const responseBody = response.body;
        
        expect(responseBody['inputs']).toBeDefined();
        expect(typeof(responseBody['inputs'])).toBe('object');

        expect(responseBody['inputs']['sport']).toBeDefined();
        expect(typeof(responseBody['inputs']['sport'])).toBe('string');
        expect(responseBody['inputs']['sport']).toBe(sport);

        expect(responseBody['inputs']['season']).toBeDefined();
        expect(typeof(responseBody['inputs']['season'])).toBe('string');
        expect(responseBody['inputs']['season']).toBe(season);

        expect(responseBody['inputs']['basesetname']).toBeDefined();
        expect(typeof(responseBody['inputs']['basesetname'])).toBe('string');
        expect(responseBody['inputs']['basesetname']).toBe(baseSetName);
        
        expect(responseBody['data']).toBeDefined();
        expect(typeof(responseBody['data'])).toBe('object');

        expect(responseBody['data']['insertsets']).toBeDefined();
        expect(typeof(responseBody['data']['insertsets'])).toBe('object');
        expect(Array.isArray(responseBody['data']['insertsets'])).toBe(true);
    });
});

const viewBaseSetDetailsEndpoint = '/v1/cardsets/details/:sport/:season/:basesetname';
describe('View Card Set Endpoint for a Base Set', () => {
    test('Should return a 200 HTTP status code', async() => {
        const sport = 'hockey';
        const season = 'anything';
        const baseSetName = 'anything';
        const response = await request(app).get(
            viewBaseSetDetailsEndpoint.replace(':sport', sport)
                .replace(':season', season)
                .replace(':basesetname', baseSetName)
        );
        expect(response.statusCode).toBe(200);
    });

    test('Should return JSON including an "inputs" array with the received key-value pairs and a "cardset" object within a "data" object', async() => {
        const sport = 'hockey';
        const season = 'anything';
        const baseSetName = 'anything';
        const response = await request(app).get(
            viewBaseSetDetailsEndpoint.replace(':sport', sport)
                .replace(':season', season)
                .replace(':basesetname', baseSetName)
        );
        const responseBody = response.body;
        
        expect(responseBody['inputs']).toBeDefined();
        expect(typeof(responseBody['inputs'])).toBe('object');

        expect(responseBody['inputs']['sport']).toBeDefined();
        expect(typeof(responseBody['inputs']['sport'])).toBe('string');
        expect(responseBody['inputs']['sport']).toBe(sport);

        expect(responseBody['inputs']['season']).toBeDefined();
        expect(typeof(responseBody['inputs']['season'])).toBe('string');
        expect(responseBody['inputs']['season']).toBe(season);

        expect(responseBody['inputs']['basesetname']).toBeDefined();
        expect(typeof(responseBody['inputs']['basesetname'])).toBe('string');
        expect(responseBody['inputs']['basesetname']).toBe(baseSetName);

        expect(responseBody['data']).toBeDefined();
        expect(typeof(responseBody['data'])).toBe('object');

        expect(responseBody['data']['cardset']).toBeDefined();
        expect(typeof(responseBody['data']['cardset'])).toBe('object');
    });
});

const viewInsertSetDetailsEndpoint = '/v1/cardsets/details/:sport/:season/:basesetname/:insertsetname';
describe('View Card Set Endpoint for an Insert Set', () => {
    test('Should return a 200 HTTP status code', async() => {
        const sport = 'hockey';
        const season = 'anything';
        const baseSetName = 'anything';
        const insertSetName = 'anything';    
        const response = await request(app).get(viewInsertSetDetailsEndpoint
            .replace(':sport', sport)
            .replace(':season', season)
            .replace(':basesetname', baseSetName)
            .replace(':insertsetname', insertSetName)
            );
        expect(response.statusCode).toBe(200);
    });

    test('Should return JSON including a "cardset" object within a "data" object', async() => {
        const sport = 'hockey';
        const season = 'anything';
        const baseSetName = 'anything';
        const insertSetName = 'anything';
        const response = await request(app).get(viewInsertSetDetailsEndpoint
            .replace(':sport', sport)
            .replace(':season', season)
            .replace(':basesetname', baseSetName)
            .replace(':insertsetname', insertSetName)
            );
        const responseBody = response.body;
        
        expect(responseBody['inputs']).toBeDefined();
        expect(typeof(responseBody['inputs'])).toBe('object');

        expect(responseBody['inputs']['sport']).toBeDefined();
        expect(typeof(responseBody['inputs']['sport'])).toBe('string');
        expect(responseBody['inputs']['sport']).toBe(sport);

        expect(responseBody['inputs']['season']).toBeDefined();
        expect(typeof(responseBody['inputs']['season'])).toBe('string');
        expect(responseBody['inputs']['season']).toBe(season);

        expect(responseBody['inputs']['basesetname']).toBeDefined();
        expect(typeof(responseBody['inputs']['basesetname'])).toBe('string');
        expect(responseBody['inputs']['basesetname']).toBe(baseSetName);

        expect(responseBody['inputs']['basesetname']).toBeDefined();
        expect(typeof(responseBody['inputs']['basesetname'])).toBe('string');
        expect(responseBody['inputs']['basesetname']).toBe(insertSetName);
        
        expect(responseBody['data']).toBeDefined();
        expect(typeof(responseBody['data'])).toBe('object');
        
        expect(responseBody['data']['cardset']).toBeDefined();
        expect(typeof(responseBody['data']['cardset'])).toBe('object');
    });
});

// avoid jest open handle error potentially due to DB connections in the pool that need a little extra time to close
afterAll(async () => {
	await new Promise(resolve => setTimeout(() => resolve(), 500));
});
   