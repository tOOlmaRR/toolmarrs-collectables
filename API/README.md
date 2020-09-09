# tOOlmaRR's Collectables - API
## Summary
This is a application program interface (API) that will be used by the website, the import tool, and the admin tool, to interface with the database (CRUD).

## Endpoints
### Test
```
GET: /v1/test/
```
- Just a "test" endpoint that can be used for monitoring and confirming that the API resolves correctly

### View Card Set Seasons
```
GET: /v1/{sportID}/cardset/seasons
```
- Returns a list of all seasons for which card sets exists within the database
- Used primarily to populate a dropdown in the website

### View Base Set Listing
```
GET: /v1/{sportID}/cardset/{season}/base_sets
```
- Returns a list of all base set names for card sets in the database for the given sport
- Used primarily to populate a dropdown in the website

### View Insert Set Listing
```
GET: /v1/{sportID}/cardset/{base_set}/insert_sets
```
- Returns a list of all insert sets with the given base set name
- Used primarily to populate a drop down in the website
- Also includes ("base set") by default

## Currently Known Bugs and Limitations

## History
### v0.1
- basic site creation