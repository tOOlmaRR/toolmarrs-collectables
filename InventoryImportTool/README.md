# Geo Trading Cards - Import Utility

## Summary:
A small PHP program that can be used to import existing inventory data into the database from "flat" text files. Currently only one format and layout is supported, based off of spreadsheets I've been building for years to track my inventory. The format and layout are very specific, and some updates may not be supported, but it will help with the process of importing existing inventory information into the database.

## Features:
1. More than one file can be processed at a time.
1. Processed files are moved into a separate folder, and (I think) any files that failed to process should be moved into a third folder.
1. Card Set Details - Can detect and load in basic card set details including manufacturer, season, base set name, insert set name, size, etc.
1. Cards - Detects and loads in basic data for cards including card number and description. Creates and links up data regarding it's value including low and high prices, and links up to a team and player position if provided. Will also parse out and link up a card to attributes if present in the RC column. If any of these do not exist (team, position, attributes), new values will be inserted, otherwise the card will be linked up the existing value. Cards are always linked to Hockey as the sport and NHL as the League.
2. Single Cards - For each card found in the data file, a single card will also be created and associated to the card, including its provided ID, rarity, cost and sell price. Also, the grading class of the card will be linked up (and created if not present).
3. Subsets - subsets will also be created or linked up as needed to both the card and the cardset.
4. Statistics - last inventory check will be added to the card set. Last appraisal and source will be added to the card value associated to the card.

## Limitations and Gotcha's
1. The program was designed for one-time imports for card sets, so in order to import updates to an existing card set, you will need to keep a few things in mind:
    1. Card Set details cannot be updated
    1. If the card set does not match exactly (ie. the season, the base set name and the insert set name), you will end up with a duplicate in the database.
    1. Individual cards and associated data like high and low values will not be updated.
    1. Statistics will also not be updated.
    1. A good way to import new cards/singles to an existing set is to create a "delta" file/spreadsheet that contains only the new cards and singles and process/import that.

## Instructions for Use
1. The first time you set this up, if you do not have the *vendor* folder in the source code, you will need to use Composer to pull down the source code for the packages defined in the composer.json and composer.lock files. A version of Composer (composer.phar) is provided in the source code, and running a command using that file should work. You will, however, require PHP to be installed on your machine.

    ```php composer.phar install```

1. Once your Composer packages have been loaded and you have a vendor folder, you should create/provide the data file(s) you wish to import in the configured folder. For more details see the sections on data file layout and configuration sections below.
2. The *import.php* file is the application entry point. When your data files are all set up to process, run that at the command line:

    ``` php import.php ```

3. Messages and errors are displayed directly in the console.


## Data File Layout
A sample of the data file layout is included in the Git repository and can ve found in the data folder. A few highlights:
1. Card Set Details
    1. Must be in rows 3-10.
    1. The labels in column 1 must exactly match what is expected and the values must be in the second column.
    1. The value for size must be an integer value if it is not empty.
    1. The value for the grading modifier must be a number and is set to 1.0 if it is empty.
1. Cards and Singles
    1. Rows 11 and 12 are ignored and processing begins on row 13.
    1. Empty rows are ignored.
    1. Rows are processed one at a time until either the end of the file is reached, or the statistics section is found, determined by a value of "Statistics" in the first column (exact match).
    1. Each column is handled differently depending on what the column is for.
    1. If a card has already been created for the card number, the card will not be created again - the program will just create the single card and assoociate that to the existing card.
    1. Single cards must have unique IDs provided; an error will occur otherwise and the row will be skipped.
    1. Low Value, High Value, Cost, and Sell values must be numeric values but dollar signs are stripped off if present.
    1. Grading modifier must be a numeric value and is set to 1.0 if it is empty.    
1. Statistics
    1. Labels must be in column 1 and they must exactly match what is expected, but can technically be in any oder.
    1. The values should be in column 4, but technically should load if they are another column as well.
    1. Rows with labels that the program does not look for are skipped.
    1. Processing ends when it finds an empty row or when the end of the file is reached.
    1. Details:
        1. *Last Value Update* - when the cards in a card set were last appraised. Value must be in the correct format (eg. January 31, 2022), otherwise it will be inserted as a NULL value. This will be loaded into the cardvalue table for each card that has been parsed from the file. 
        1. *Last Inventory Check* - when the inventory of the card set was last confirmed. Value must be in the correct format (eg. January 31, 2022), otherwise it will be inserted as a NULL value. This will get loaded into a column in the cardset table.
        1. *Pricing Source* - the source used for the most recent appraisal. This will be loaded into the cardvalue table for each card that has been parsed from the file.
        1. *Beckett.com Last Update* - when Beckett.com was last updated with the inventory of this card set. Value must be in the correct format (eg. January 31, 2022), otherwise it will be inserted as a NULL value. This will get loaded into a column in the cardset table.

## Configuration and Environments
There are multiple configuration files defined for this application, including separate environment-specific configuration files for "*development*" and "*production*". They are written in the YAML language/syntax and requires the appropriate composer package.

Environment is specified early on in the import.php file (the application entry point).

### Config File Details:
1. *config-shared.yml* - general configuration settings such as paths for the data file and some details and where to find the data within the file, the latter of which may not be used at this point.
1. *inventory-header.yml* - defines the specific labels that the program should look for, although it doesn't appear to be used at this point.
1. *config-{environment}* - environment-specific confiiguration files which contain database connections and credentials, and the names of the stored procedures to use. There is also a setting that enables/disables the use of stored procedures. In the data layer there are hardcoded queries that are used if this setting is disabled, but it is older code that is specific to MySQL rather than MS SQL.

## History

### v1.1
- created some README documentation.

### v1.0
- The state of the import utility when I completed development and started using it to import my collection into the database.