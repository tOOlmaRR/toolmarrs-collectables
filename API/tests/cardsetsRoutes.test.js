const request = require('supertest');
const app = require('../app');

// ENDPOINT: Cardsets Controller Test
const controllerTestEndpoint = '/v1/cardsets/test';
describe('Cardsets Controller Tests', () => {
    test('Should return a 200 HTTP status code', async() => {
        const response = await request(app).get(controllerTestEndpoint);
        expect(response.statusCode).toBe(200);
    });

    test('Should return standard JSON response', async() => {
        const response = await request(app).get(controllerTestEndpoint);
        const responseBody = response.body;
        expect(responseBody['version']).toBeDefined();
        expect(responseBody['inputs']).toBeDefined();
        expect(responseBody['endpoint']).toBe('Cardsets Controller Test');
        expect(responseBody['data']).toBeDefined();
        expect(responseBody['error']).not.toBeDefined();
    });
});



// ENDPOINT: Cardsets Model Test
const seasonsModelTestEndpoint = '/v1/cardsets/test/:sport/seasons';
describe('Cardsets Model Tests', () => {
    test('Should return a 200 HTTP status code', async() => {
        const sport = 'hockey';
        const response = await request(app).get(seasonsModelTestEndpoint.replace(':sport', sport));
        expect(response.statusCode).toBe(200);
    });

    test('Should return standard JSON response', async() => {
        const sport = 'hockey';
        const response = await request(app).get(seasonsModelTestEndpoint.replace(':sport', sport));
        const responseBody = response.body;
        expect(responseBody['version']).toBeDefined();
        expect(responseBody['inputs']).toBeDefined();
        expect(responseBody['endpoint']).toBe('Cardsets Model Test');
    });

    test('Should return an appropriate JSON results response with data and seasons nodes', async() => {
        const sport = 'hockey';
        const response = await request(app).get(seasonsModelTestEndpoint.replace(':sport', sport));
        const responseBody = response.body;
        expect(responseBody['data']).toBeDefined();
        expect(responseBody['data']['seasons']).toBeDefined();
        expect(responseBody['data']['seasons']).toBe('1990-91');
        expect(responseBody['error']).not.toBeDefined();
    });

    test('Should return a 400 HTTP status code and a JSON error response with an error node and a message node within', async() => {
        const sport = 'BADINPUT';
        const response = await request(app).get(seasonsModelTestEndpoint.replace(':sport', sport));
        const responseBody = response.body;
        
        expect(response.statusCode).toBe(400);
        
        expect(responseBody['error']).toBeDefined();
        expect(responseBody['error']['message']).toBeDefined();
        expect(responseBody['error']['message']).toBe('BAD INPUT');
        
        expect(responseBody['data']).not.toBeDefined();
    });
});



// ENDPOINT: View Seasons
const viewSeasonsEndpoint = '/v1/cardsets/:sport/seasons';
describe('View Seasons Endpoint', () => {
    test('Should return a 200 HTTP status code', async() => {
        const sport = 'hockey';
        const response = await request(app).get(viewSeasonsEndpoint.replace(':sport', sport));
        expect(response.statusCode).toBe(200);
    });

    test('Should return standard JSON response', async() => {
        const sport = 'hockey';
        const response = await request(app).get(viewSeasonsEndpoint.replace(':sport', sport));
        const responseBody = response.body;
        expect(responseBody['version']).toBeDefined();
        expect(responseBody['inputs']).toBeDefined();
        expect(responseBody['endpoint']).toBe('View Seasons');
   });

    test('Should return JSON including an "inputs" array with the received key-value pairs', async() => {
        const sport = 'hockey';
        const response = await request(app).get(viewSeasonsEndpoint.replace(':sport', sport));
        const responseBody = response.body;
        
        expect(responseBody['inputs']).toBeDefined();
        expect(typeof(responseBody['inputs'])).toBe('object');
        
        expect(responseBody['inputs']['sport']).toBeDefined();
        expect(typeof(responseBody['inputs']['sport'])).toBe('string');
        expect(responseBody['inputs']['sport']).toBe(sport);
    });

    test('Should return JSON including a "seasons" array within a "data" object', async() => {
        const sport = 'hockey';
        const response = await request(app).get(viewSeasonsEndpoint.replace(':sport', sport));
        const responseBody = response.body;
        
        expect(responseBody['data']).toBeDefined();
        expect(typeof(responseBody['data'])).toBe('object');
        
        expect(responseBody['data']['seasons']).toBeDefined();
        expect(typeof(responseBody['data']['seasons'])).toBe('object');
        expect(Array.isArray(responseBody['data']['seasons'])).toBe(true);

        expect(responseBody['error']).not.toBeDefined();
    });

    test('Should return a 400 HTTP status code and JSON error response with an error node and a message node within', async() => {
        const sport = 'zzzzzzzzzzzzzzzzzzzzzzzzzZ';
        const response = await request(app).get(viewSeasonsEndpoint.replace(':sport', sport));
        const responseBody = response.body;

        expect(response.statusCode).toBe(400);

        expect(responseBody['inputs']).toBeDefined();
        expect(typeof(responseBody['inputs'])).toBe('object');
        
        expect(responseBody['inputs']['sport']).toBeDefined();
        expect(typeof(responseBody['inputs']['sport'])).toBe('string');
        expect(responseBody['inputs']['sport']).toBe(sport);
        
        expect(responseBody['error']).toBeDefined();
        expect(responseBody['error']['message']).toBeDefined();
        expect(responseBody['data']).not.toBeDefined();
    });
});



// ENDPOINT: View Base Set Names
const viewBaseCardsetListEndpoint = '/v1/cardsets/:sport/:season/basesets';
describe('View Base Sets Endpoint', () => {
    test('Should return a 200 HTTP status code', async() => {
        const sport = 'hockey';
        const season = '2003-04';
        const response = await request(app).get(viewBaseCardsetListEndpoint.replace(':sport', sport).replace(':season', season));
        expect(response.statusCode).toBe(200);
    });

    test('Should return standard JSON response', async() => {
        const sport = 'hockey';
        const season = '2003-04';
        const response = await request(app).get(viewBaseCardsetListEndpoint.replace(':sport', sport).replace(':season', season));
        const responseBody = response.body;
        expect(responseBody['version']).toBeDefined();
        expect(responseBody['inputs']).toBeDefined();
        expect(responseBody['endpoint']).toBe('View Base Set Names');
    });

    test('Should return JSON including an "inputs" array with the received key-value pairs', async() => {
        const sport = 'hockey';
        const season = '2003-04';
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
    });

    test('Should return JSON including a "basesets" array within a "data" object', async() => {
        const sport = 'hockey';
        const season = '2003-04';
        const response = await request(app).get(viewBaseCardsetListEndpoint.replace(':sport', sport).replace(':season', season));
        const responseBody = response.body;

        expect(responseBody['data']).toBeDefined();
        expect(typeof(responseBody['data'])).toBe('object');

        expect(responseBody['data']['basesetnames']).toBeDefined();
        expect(typeof(responseBody['data']['basesetnames'])).toBe('object');
        expect(Array.isArray(responseBody['data']['basesetnames'])).toBe(true);

        expect(responseBody['error']).not.toBeDefined();
    });

    test('Should return a 400 HTTP status code and JSON error response with an error node and a message node within (invalid season))', async() => {
        const sport = 'hockey';
        const season = 'BADINPUT';
        const response = await request(app).get(viewBaseCardsetListEndpoint.replace(':sport', sport).replace(':season', season));
        const responseBody = response.body;
        
        expect(response.statusCode).toBe(400);

        expect(responseBody['inputs']).toBeDefined();
        expect(typeof(responseBody['inputs'])).toBe('object');

        expect(responseBody['inputs']['sport']).toBeDefined();
        expect(typeof(responseBody['inputs']['sport'])).toBe('string');
        expect(responseBody['inputs']['sport']).toBe(sport);

        expect(responseBody['inputs']['season']).toBeDefined();
        expect(typeof(responseBody['inputs']['season'])).toBe('string');
        expect(responseBody['inputs']['season']).toBe(season);

        expect(responseBody['error']).toBeDefined();
        expect(responseBody['error']['message']).toBeDefined();
        expect(responseBody['error']['message']).toEqual(expect.not.stringContaining('sport'));
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('season'));

        expect(responseBody['data']).not.toBeDefined();
    });

    test('Should return JSON error response with an error node and a message node within (invalid sport))', async() => {
        const sport = 'zzzzzzzzzzzzzzzzzzzzzzzzzZ';
        const season = '2003-04';
        const response = await request(app).get(viewBaseCardsetListEndpoint.replace(':sport', sport).replace(':season', season));
        const responseBody = response.body;
        
        expect(responseBody['error']).toBeDefined();
        expect(responseBody['error']['message']).toBeDefined();
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('sport'));
        expect(responseBody['error']['message']).toEqual(expect.not.stringContaining('season'));

        expect(responseBody['data']).not.toBeDefined();
    });

    test('Should return JSON error response with an error node and a message node within (invalid sport and season))', async() => {
        const sport = 'zzzzzzzzzzzzzzzzzzzzzzzzzZ';
        const season = 'BADINPUT';
        const response = await request(app).get(viewBaseCardsetListEndpoint.replace(':sport', sport).replace(':season', season));
        const responseBody = response.body;
        
        expect(responseBody['error']).toBeDefined();
        expect(responseBody['error']['message']).toBeDefined();
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('sport'));
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('season'));

        expect(responseBody['data']).not.toBeDefined();
    });
});



// ENDPOINT: View Insert Set Names
const viewInsertSetListEndpoint = '/v1/cardsets/:sport/:season/:basesetname/insertsets';
describe('View Insert Sets Endpoint', () => {
    test('Should return a 200 HTTP status code', async() => {
        const sport = 'hockey';
        const season = '2003-04';
        const baseSetName = 'anything';
        const response = await request(app).get(viewInsertSetListEndpoint.replace(':sport', sport)
            .replace(':season', season)
            .replace(':basesetname', baseSetName));
        expect(response.statusCode).toBe(200);
    });

    test('Should return standard JSON response', async() => {
        const sport = 'hockey';
        const season = '2003-04';
        const baseSetName = 'anything';
        const response = await request(app).get(viewInsertSetListEndpoint.replace(':sport', sport)
            .replace(':season', season)
            .replace(':basesetname', baseSetName));
        const responseBody = response.body;
        expect(responseBody['version']).toBeDefined();
        expect(responseBody['inputs']).toBeDefined();
        expect(responseBody['endpoint']).toBe('View Insert Set Names');
    });

    test('Should return JSON including an "inputs" array with the received key-value pairs and an "insertsets" array within a "data" object', async() => {
        const sport = 'hockey';
        const season = '2003-04';
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

        expect(responseBody['data']['insertsetnames']).toBeDefined();
        expect(typeof(responseBody['data']['insertsetnames'])).toBe('object');
        expect(Array.isArray(responseBody['data']['insertsetnames'])).toBe(true);

        expect(responseBody['error']).not.toBeDefined();
    });

    test('Should return a 400 HTTP status code and JSON error response with an error node and a message node within (invalid sport))', async() => {
        const sport = 'zzzzzzzzzzzzzzzzzzzzzzzzzZ';
        const season = '2003-04';
        const baseSetName = 'anything';
        const response = await request(app).get(viewInsertSetListEndpoint.replace(':sport', sport)
            .replace(':season', season)
            .replace(':basesetname', baseSetName));
        const responseBody = response.body;

        expect(response.statusCode).toBe(400);

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

        expect(responseBody['error']).toBeDefined();
        expect(responseBody['error']['message']).toBeDefined();
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('sport'));
        expect(responseBody['error']['message']).toEqual(expect.not.stringContaining('season'));
        expect(responseBody['error']['message']).toEqual(expect.not.stringContaining('base set name'));

        expect(responseBody['data']).not.toBeDefined();
    });

    test('Should return JSON error response with an error node and a message node within (invalid sport and season))', async() => {
        const sport = 'zzzzzzzzzzzzzzzzzzzzzzzzzZ';
        const season = 'BADINPUT';
        const baseSetName = 'anything';
        const response = await request(app).get(viewInsertSetListEndpoint.replace(':sport', sport)
            .replace(':season', season)
            .replace(':basesetname', baseSetName));
        const responseBody = response.body;
        
        expect(responseBody['error']).toBeDefined();
        expect(responseBody['error']['message']).toBeDefined();
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('sport'));
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('season'));
        expect(responseBody['error']['message']).toEqual(expect.not.stringContaining('base set name'));

        expect(responseBody['data']).not.toBeDefined();
    });

    test('Should return JSON error response with an error node and a message node within (invalid base set name))', async() => {
        const sport = 'hockey';
        const season = '2003-04';
        const baseSetName = 'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzZ';
        const response = await request(app).get(viewInsertSetListEndpoint.replace(':sport', sport)
            .replace(':season', season)
            .replace(':basesetname', baseSetName));
        const responseBody = response.body;
        
        expect(responseBody['error']).toBeDefined();
        expect(responseBody['error']['message']).toBeDefined();
        expect(responseBody['error']['message']).toEqual(expect.not.stringContaining('sport'));
        expect(responseBody['error']['message']).toEqual(expect.not.stringContaining('season'));
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('base set name'));

        expect(responseBody['data']).not.toBeDefined();
    });

    test('Should return JSON error response with an error node and a message node within (invalid sport, season, and base set name))', async() => {
        const sport = 'zzzzzzzzzzzzzzzzzzzzzzzzzZ';
        const season = 'BADINPUT';
        const baseSetName = 'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzZ';
        const response = await request(app).get(viewInsertSetListEndpoint.replace(':sport', sport)
            .replace(':season', season)
            .replace(':basesetname', baseSetName));
        const responseBody = response.body;
        
        expect(responseBody['error']).toBeDefined();
        expect(responseBody['error']['message']).toBeDefined();
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('sport'));
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('season'));
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('base set name'));

        expect(responseBody['data']).not.toBeDefined();
    });
});



// ENDPOINT: View Card Set Details (Base Sets)
const viewBaseSetDetailsEndpoint = '/v1/cardsets/details/:sport/:season/:basesetname';
describe('View Card Set Endpoint for a Base Set', () => {
    test('Should return a 200 HTTP status code', async() => {
        const sport = 'hockey';
        const season = '2003-04';
        const baseSetName = 'anything';
        const response = await request(app).get(
            viewBaseSetDetailsEndpoint.replace(':sport', sport)
                .replace(':season', season)
                .replace(':basesetname', baseSetName)
        );
        expect(response.statusCode).toBe(200);
    });

    test('Should return standard JSON response', async() => {
        const sport = 'hockey';
        const season = '2003-04';
        const baseSetName = 'anything';
        const response = await request(app).get(viewBaseSetDetailsEndpoint.replace(':sport', sport)
        .replace(':season', season)
        .replace(':basesetname', baseSetName));
        const responseBody = response.body;
        expect(responseBody['version']).toBeDefined();
        expect(responseBody['inputs']).toBeDefined();
        expect(responseBody['endpoint']).toBe('View Card Set Details');
    });

    test('Should return JSON including an "inputs" array with the received key-value pairs', async() => {
        const sport = 'hockey';
        const season = '2003-04';
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

        expect(responseBody['inputs']['insertsetname']).not.toBeDefined();

        expect(responseBody['error']).not.toBeDefined();
    });

    test('Should return JSON including a "cardset" object within a "data" object', async() => {
        const sport = 'hockey';
        const season = '2003-04';
        const baseSetName = 'anything';
        const response = await request(app).get(
            viewBaseSetDetailsEndpoint.replace(':sport', sport)
                .replace(':season', season)
                .replace(':basesetname', baseSetName)
        );
        const responseBody = response.body;
        
        expect(responseBody['data']).toBeDefined();
        expect(typeof(responseBody['data'])).toBe('object');

        // when there are no results, we expect no cardset object within the data object
        expect(responseBody['data'].cardset).not.toBeDefined();

        expect(responseBody['error']).not.toBeDefined();
    });

    test('Should return a 400 HTTP status code and JSON error response with an error node and a message node within (invalid sport))', async() => {
        const sport = 'zzzzzzzzzzzzzzzzzzzzzzzzzZ';
        const season = '2003-04';
        const baseSetName = 'anything';
        const response = await request(app).get(viewInsertSetListEndpoint.replace(':sport', sport)
            .replace(':season', season)
            .replace(':basesetname', baseSetName));
        const responseBody = response.body;

        expect(response.statusCode).toBe(400);

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

        expect(responseBody['error']).toBeDefined();
        expect(responseBody['error']['message']).toBeDefined();
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('sport'));
        expect(responseBody['error']['message']).toEqual(expect.not.stringContaining('season'));
        expect(responseBody['error']['message']).toEqual(expect.not.stringContaining('base set name'));

        expect(responseBody['data']).not.toBeDefined();
    });

    test('Should return JSON error response with an error node and a message node within (invalid sport and season))', async() => {
        const sport = 'zzzzzzzzzzzzzzzzzzzzzzzzzZ';
        const season = 'BADINPUT';
        const baseSetName = 'anything';
        const response = await request(app).get(viewInsertSetListEndpoint.replace(':sport', sport)
            .replace(':season', season)
            .replace(':basesetname', baseSetName));
        const responseBody = response.body;
        
        expect(responseBody['error']).toBeDefined();
        expect(responseBody['error']['message']).toBeDefined();
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('sport'));
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('season'));
        expect(responseBody['error']['message']).toEqual(expect.not.stringContaining('base set name'));

        expect(responseBody['data']).not.toBeDefined();
    });

    test('Should return JSON error response with an error node and a message node within (invalid base set name))', async() => {
        const sport = 'hockey';
        const season = '2003-04';
        const baseSetName = 'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzZ';
        const response = await request(app).get(viewInsertSetListEndpoint.replace(':sport', sport)
            .replace(':season', season)
            .replace(':basesetname', baseSetName));
        const responseBody = response.body;
        
        expect(responseBody['error']).toBeDefined();
        expect(responseBody['error']['message']).toBeDefined();
        expect(responseBody['error']['message']).toEqual(expect.not.stringContaining('sport'));
        expect(responseBody['error']['message']).toEqual(expect.not.stringContaining('season'));
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('base set name'));

        expect(responseBody['data']).not.toBeDefined();
    });

    test('Should return JSON error response with an error node and a message node within (invalid sport, season, and base set name))', async() => {
        const sport = 'zzzzzzzzzzzzzzzzzzzzzzzzzZ';
        const season = 'BADINPUT';
        const baseSetName = 'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzZ';
        const response = await request(app).get(viewInsertSetListEndpoint.replace(':sport', sport)
            .replace(':season', season)
            .replace(':basesetname', baseSetName));
        const responseBody = response.body;
        
        expect(responseBody['error']).toBeDefined();
        expect(responseBody['error']['message']).toBeDefined();
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('sport'));
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('season'));
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('base set name'));

        expect(responseBody['data']).not.toBeDefined();
    });
});



// ENDPOINT: View Card Set Details (Insert Sets)
const viewInsertSetDetailsEndpoint = '/v1/cardsets/details/:sport/:season/:basesetname/:insertsetname';
describe('View Card Set Endpoint for an Insert Set', () => {
    test('Should return a 200 HTTP status code', async() => {
        const sport = 'hockey';
        const season = '2003-04';
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

    test('Should return standard JSON response', async() => {
        const sport = 'hockey';
        const season = '2003-04';
        const baseSetName = 'anything';
        const insertSetName = 'anything';
        const response = await request(app).get(viewInsertSetDetailsEndpoint
            .replace(':sport', sport)
            .replace(':season', season)
            .replace(':basesetname', baseSetName)
            .replace(':insertsetname', insertSetName)
        );
        const responseBody = response.body;
        expect(responseBody['version']).toBeDefined();
        expect(responseBody['inputs']).toBeDefined();
        expect(responseBody['endpoint']).toBe('View Card Set Details');
    });

    test('Should return JSON including an "inputs" array with the received key-value pairs', async() => {
        const sport = 'hockey';
        const season = '2003-04';
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

        expect(responseBody['inputs']['insertsetname']).toBeDefined();
        expect(typeof(responseBody['inputs']['insertsetname'])).toBe('string');
        expect(responseBody['inputs']['insertsetname']).toBe(insertSetName);
    });

    test('Should return JSON including a "cardset" object within a "data" object', async() => {
        const sport = 'hockey';
        const season = '2003-04';
        const baseSetName = 'anything';
        const insertSetName = 'anything';
        const response = await request(app).get(viewInsertSetDetailsEndpoint
            .replace(':sport', sport)
            .replace(':season', season)
            .replace(':basesetname', baseSetName)
            .replace(':insertsetname', insertSetName)
        );
        const responseBody = response.body;
        
        expect(responseBody['data']).toBeDefined();
        expect(typeof(responseBody['data'])).toBe('object');
        
        // when there are no results, we expect no cardset object within the data object
        expect(responseBody['data']['cardset']).not.toBeDefined();

        expect(responseBody['error']).not.toBeDefined();
    });

    test('Should return a 400 HTTP status code and JSON error response with an error node and a message node within (invalid sport))', async() => {
        const sport = 'zzzzzzzzzzzzzzzzzzzzzzzzzZ';
        const season = '2003-04';
        const baseSetName = 'anything';
        const insertSetName = 'anything';
        const response = await request(app).get(viewInsertSetDetailsEndpoint.replace(':sport', sport)
            .replace(':season', season)
            .replace(':basesetname', baseSetName)
            .replace(':insertsetname', insertSetName)
        );
        const responseBody = response.body;

        expect(response.statusCode).toBe(400);

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

        expect(responseBody['inputs']['insertsetname']).toBeDefined();
        expect(typeof(responseBody['inputs']['insertsetname'])).toBe('string');
        expect(responseBody['inputs']['insertsetname']).toBe(insertSetName);

        expect(responseBody['error']).toBeDefined();
        expect(responseBody['error']['message']).toBeDefined();
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('sport'));
        expect(responseBody['error']['message']).toEqual(expect.not.stringContaining('season'));
        expect(responseBody['error']['message']).toEqual(expect.not.stringContaining('base set name'));

        expect(responseBody['data']).not.toBeDefined();
    });

    test('Should return JSON error response with an error node and a message node within (invalid insert set name))', async() => {
        const sport = 'hockey';
        const season = '2003-04';
        const baseSetName = 'anything';
        const insertSetName = 'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzZ';
        const response = await request(app).get(viewInsertSetDetailsEndpoint.replace(':sport', sport)
            .replace(':season', season)
            .replace(':basesetname', baseSetName)
            .replace(':insertsetname', insertSetName)
        );
        const responseBody = response.body;
        
        expect(responseBody['error']).toBeDefined();
        expect(responseBody['error']['message']).toBeDefined();
        expect(responseBody['error']['message']).toEqual(expect.not.stringContaining('sport'));
        expect(responseBody['error']['message']).toEqual(expect.not.stringContaining('season'));
        expect(responseBody['error']['message']).toEqual(expect.not.stringContaining('base set name'));
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('insert set name'));

        expect(responseBody['data']).not.toBeDefined();
    });

    test('Should return JSON error response with an error node and a message node within (invalid sport, season, base set name and insert set name))', async() => {
        const sport = 'zzzzzzzzzzzzzzzzzzzzzzzzzZ';
        const season = 'BADINPUT';
        const baseSetName = 'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzZ';
        const insertSetName = 'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzZ';
        const response = await request(app).get(viewInsertSetDetailsEndpoint.replace(':sport', sport)
            .replace(':season', season)
            .replace(':basesetname', baseSetName)
            .replace(':insertsetname', insertSetName)
        );
        const responseBody = response.body;
        
        expect(responseBody['error']).toBeDefined();
        expect(responseBody['error']['message']).toBeDefined();
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('sport'));
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('season'));
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('base set name'));
        expect(responseBody['error']['message']).toEqual(expect.stringContaining('insert set name'));

        expect(responseBody['data']).not.toBeDefined();
    });
});

// avoid jest open handle error potentially due to DB connections in the pool that need a little extra time to close
afterAll(async () => {
	await new Promise(resolve => setTimeout(() => resolve(), 500));
});
   