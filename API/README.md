# tOOlmaRR's Collectables - API
## Summary
This is a application program interface (API) that will be used by the website, the import tool, and the admin tool, to interface with the database (CRUD).

## Setup Instructions
1. Ensure that your .env file has been created and includes the following key/value pairs:
    - VERSION
    - PORT
1. Run the following command:
    ```
    npm run dev
    ```

## Testing instructions
1. Ensure that jest is installed globally
1. Run the following command to run the test suites:
    ```
    jest --detectOpenHandles --forceExit
    ```
    The *detectOpenHandles* option indicates if any async operations have not completed, and the *forceExit* appears to be needed quite often for Jest to not hang after a round of tests has completed (not sure what causes the hang - perhaps some async issue I haven't tracked down yet).



## Endpoints
### Test
```
GET: /v1/test/
```
- Just a "test" endpoint that can be used for monitoring and confirming that the API resolves correctly

### Cardsets - Test 
```
GET: /v1/cardsets/test
```
- Just a "test" endpoint that can be used for monitoring and confirming that the cardsets API group resolves correctly

### Cardsets - View Seasons
```
GET: /v1/cardsets/seasons
```
- Returns a list of all seasons for which card sets exists within the database
- Used primarily to populate a dropdown in the website

### Cardsets - View Base Sets
```
GET: /v1/cardsets/{season}/basesets
```
- Returns a list of all base set names for card sets in the database
- Used primarily to populate a dropdown in the website

### Cardsets - View Insert Sets
```
GET: /v1/cardsets/{season}/{basesetname}/insertsets
```
- Returns a list of all insert sets with the given base set name from the given season
- Used primarily to populate a drop down in the website

## Currently Known Bugs and Limitations

## History
### v1.0
- basic site creation
- test endpoint
- cardsets - test endpoint
- cardsets - get seasons endpoint
- cardsets - get base sets endpoint
- cardsets - get insert sets endpoint
- a few automated tests for all endpoints
- documentation
- Postman collection and test requests for each endpoint