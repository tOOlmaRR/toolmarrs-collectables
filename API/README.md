[BACK](../README.md)

# Geo Trading Cards - tSc API

## Summary
A node.js API used to interface with the database, through which inventory data may be managed. This is in its infancy, but will become the backbone of both the website and the WinAdminUI.

## Setup Instructions
1. Ensure that your .env files have been created for each environment and includes the following key/value pairs:
    - VERSION: API version (eg. v1)
    - PORT: which port to use (eg. 8080)
    - DB_SERVER: the name of the (MS SQL) DB server
    - DB_USER: the name of the (MS SQL) user to use
    - DB_PASSWORD: the MS SQL user's password
    - DB_NAME: the database name
1. To start up the application, you have three options by entering the following commands at the command line:
    1. DEVELOPMENT Environment with nodemon to monitor for changes:
        ```
        npm run dev
        ```
    2. DEVELOPMENT environment without monitoring:
        ```
        npm run start:dev
        ```
    3. PRODUCTION environment without monitoring:
        ```
        npm run start:prod
        ```
### Apache Integration
To run nodejs in Apache, you need to use a reverse-proxy technique by running your node server separately from Apache on a different port, and adding/updating the Apache configuration to redirect requests from the Apache server to the nodejs server.

Add the following to your Apache configuration just below your ServerRoot directive:
- ProxyPass /tsc-api http://localhost:8080

The first parameter is the virtual path you want to map up in your URLs to the nodejs server
The second parameter is the URL and port that your nodejs server is running on (be sure to leave off the traling slash!)

You will also need to ensure that the following modules are enabled:
1. mod_proxy.so
2. mod_proxy_http.so

Reference: https://medium.com/@chamiperera95/how-to-run-node-js-server-and-apache-server-together-ee225ece6a44

## Testing instructions
1. Ensure that *Jest* is installed globally
1. Run the following command to run the test suites:
    ```
    jest --detectOpenHandles --forceExit
    ```
    The *detectOpenHandles* option indicates if any async operations have not completed, and the *forceExit* appears to be needed quite often for Jest to not hang after a round of tests has completed (not sure what causes the hang - perhaps some async issue I haven't tracked down yet).

    To run a certain set of tests, run a command similar to this:
    ```
    jest --detectOpenHandles --forceExit --testNamePattern "View Card Set Endpoint"
    ```
    The testNamePattern is a *regex* that defines a pattern of test names to run. In this case, this command will run both the Base Set and Insert Set test suite because they both start with this string.

**Note**: Automated tests use the .env file for environment configuration

## Endpoints: Test
|Name|HTTP|Request Format|Desription and Comments|
|----|----|----------|-----------------------|
Test Controller Test|GET|/v1/test/|A "test" endpoint that can be used for monitoring and confirming that the API resolves correctly|

## Endpoints: Cardsets

|Name|HTTP|Request Format|Desription and Comments|
|----|----|----------|-----------------------|
Cardsets Controller Test|GET|/v1/cardsets/test|A "test" endpoint that can be used for monitoring and confirming that the cardsets controller and API endpoint group resolves correctly|
Cardsets Model Test|GET|/v1/cardsets/test/{sport}/seasons|A "test" endpoint that can be used for monitoring and confirming that the cardsets model and API endpoint group resolves correctly. Passing in 'hockey' as the sport returns data whereas any other value will return an 'error' response|
View Seasons|GET|/v1/cardsets/{sport}/seasons|Returns a list of all seasons for which card sets exists within the database for the specified sport. Used primarily to populate a dropdown in the website
View Base Set Names|GET|/v1/cardsets/{sport}/{season}/basesets|Returns a list of all base set names for card sets in the database for the specified sport and season. Used primarily to populate a dropdown in the website
View Insert Set Names|GET|/v1/cardsets/{sport}/{season}/{basesetname}/insertsets|Returns a list of all insert sets in a given base set, season, and sport. Used primarily to populate a drop down in the website
View Card Set Details (Base Set)|GET|/v1/cardsets/details/{sport}/{season}/{basesetname}|Returns details of a base card set given the desired sport, season, and base set name. Used to populate the card set details page/pane. Does not include data from related tables such as Manufacturer.
View Card Set Details (Insert Set)|GET|/v1/cardsets/details/{sport}/{season}/{basesetname}/{insertsetname}|Returns details of an insert set given the desired sport, season, base set name, and insert set name. Used to populate the card set details page/pane. Does not include data from related tables such as Manufacturer.

**Note**: All dynamic elements are in {curly braces}, and should be replaced with the actual values you are looking for and not their IDs.

## Currently Known Bugs and Limitations
1. exception handling and error responses need a little standardization and testing
1. asynchronous operations appear to be a bit buggy, especially when it comes to the automated tests

## Support
### "Error: listen EADDRINUSE: address already in use :::8080"

This means that there is a node process on port 8080 still running in the background. You can kill all running node processes using the following command:

    `taskkill /F /IM node.exe`

### "Failed to connect to {ServerName}:{Port} - Could not connect (sequence)"

There may be some configuration settings that aren't set up. Ensure that your SQL Server instance in SQL Server Connection Manager has TCP/IP Protocol enabled

## History

### v1.4
- NPM package updates via dependabot
- fixed issues with asynchronous requests
- addressed potential SQL injection attacks
- refactored API endpoints to use standard JSON response objects
- consolidate SQL connection logic

### v1.3
- enhanced readme documentation

### v1.2
- updated all endpoints (except test endpoints) to require "sport" as an input so that cards and card sets are now associated to a sport
- updated responses of all endpoints (except test endpoints) to include an "inputs" object containing all input key-value pairs (just the ones we are expecting)
- updated the JSON response object names such as "insertsets" to be consistent as all lowercase names
- slight improvements to unit testing

### v1.1
- cardsets - view base set details
- cardsets - view insert set details

### v1.0
- basic site creation
- test endpoint
- cardsets - test endpoint
- cardsets - view seasons endpoint
- cardsets - view base sets endpoint
- cardsets - view insert sets endpoint
- a few automated tests for all endpoints
- documentation
- Postman collection and test requests for each endpoint