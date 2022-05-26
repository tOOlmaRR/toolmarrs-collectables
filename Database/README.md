[BACK](../README.md)

# Geo Trading Cards - Database

## Summary
The database stores all inventory and related sets, insert sets, cards, singles, and so on in a fairly complex and normalized database. The database was originally built in MySQL and was rebuilt and enhanced in MSSQL. There are some common scripts included within the Git repository to help find and maintain inventory and a history of changes made to the schema. There are some scripts for both database technologies, but anything related to MySQL may be a bit out of date at this point.

## Schema Details - MS SQL

### Environments

| Environment | Database Name        |
| ----------- | -------------------- |
| Production  | GeosTradingCards     |
| Development | GeosTradingCards-DEV |

**Note**: The schema should be exactly the same, including users

### Tables
| Table Name | Description |
| ---------- | ----------- |
| attributes | Common attributes given to a card, such as RC (rookie card) or SP (short print). Has a many-to-many relationship with the *card* table via the *card_has_attributes* look-up table.
| card | A key table that contains detail information for each unique card. Note that multiple copies of a card are tracked in the *singlecard* table, including cards that are serial-numbered. A card is related to many other tables, including *cardset*, *subset*, *team*, *playerposition*, and *sport*.
| card_has_attributes | A look-up table relating the *attributes* and *card* tables. The primary key of this table is a composite key of the only two columns and there is no autoincrement/identity ID column.
| cardset |Another key table in the schema which contains detail information for a card set. Note that this includes insert ("chase") and parallel sets as well, and any set that is found within another set should have identical values for the BaseSetName column; so for example, O-Pee-Chee could be the base set (because you purchase a pack or box of O-Pee-Chee), but the 1978-79 Retro parallel set and the Season Highlights insert set would have separate records in this table, all with O-Pee-Chee as the BaseSetName. A cardset is related to the *sport* and *manufacturer* tables.
| cardvalue | Contains details of the value of a card, including when it was last appraised and what the source of that appraisal was. This table is related to the *card* table.
| Error | A utility table used to log any errors that are encountered by any of the GeoTradingCards applications
| Exceptions | Another utility table used to log any exceptions that are caught and handled by any of the GeoTradingCards applications.
| GoogleDocsPages | A table that contains link to inventory documents in Google Docs/Drive (ie. the old way of tracking inventory) to their sets and seasons. This will likely be be deprecated in the future.
| gradingclass | A look-up table containing the abbreviations and descriptions of the different classifications used to grade a card (examples: NRMT, MINT).
| league | A look-up table to track sports leagues such as NHL. This table is related to the *sport* table.
| manufacturer | The manufacturer of a card set.
| playerposition | Indicates the position a player plays in. If a card is for a specific player, and this value is known, the card will be related to the appropriate record in this table. Many records in the *card* table will not be related to a record in this table.
| singlecard | Another key table in the schema. A record in this table represents a specific copy of a card. The only time that a card should not be related to a record in this table is if a copy of that card is no longer owned, and currently, if a card is no longer owned because it has been purchased or traded away, there is still a record of that single card with a value other than 'Available" in the *status* column as a historical entry. This table is related to the *card* table.
| singlecardgrading | Contains detail information on the grading of a specific copy/instance of a card. While I currently don't grade cards in much detail, the framework has been laid to provide analysis of specfic aspects of a card. Currently, this table simply relates the single card to a standard grading class via the *gradingclass* table. This table is also related to the *singlecard* table.
| sport | A look-up table for the sport to which a card set belongs. There are some instances where a card set spans multiple sports. For these, there will be a record for "Multi-Sport".
| subset | A subset is a "set within a set", or smaller "sets" within a base set. For example, the 1990-91 Score Hockey card set contains a number of subsets within its base set such as Hot Prospects. This table contains the detail information for these "sets within sets". This table is related to the *cardset* table.
| team | Details of a sports team to which a card may be related. There are some cases where a card is not related to a team (for example, checklist cards). This table is related to the *league* table.

## Stored Procedures:
| SPROC Name | Description |
| ---------- | ----------- |
| Attributes.Insert | Inserts a record into the *attributes* table given the details of the attribute. This SPROC returns the ID of the new record.
| Attributes.Select | Returns the details of an attribute from the *attributes* table given either its ID or its Abbreviation. Note that, while there should never be two attributes with the same abbreviation, there is nothing that prevents this from happening in the database, and so this SPROC could potentially return more than one result.
| Card.Insert | Inserts a record into the *card* table given the card's details, including foreign keys for values in related tables (not the values themselves). This SPROC returns the ID of the new record.
| Card.Select | Returns the details of a card from the *card* table, including foreign keys (not the associated values) based on either the card's ID or based on 3 values that should uniquely identify the card: *CardNumber*, *CardTitle*, and *CardSet_ID*. For the latter option, while there should never be more than one card that has the same values for all 3 fields, there is nothing in the database or in the SPROC to prevent it, and so this SPROC could potentially return more than one result.
| Card_Has_Attributes.Insert | Inserts a new record in the *card_has_attributes* table which maps up records in the *attribute* and *card* tables (many-to-many relationship). This SPROC only receives the two foreign keys as inputs (not the associated values). The primary key of this table is a composite key of these two columns and there is no autoincrement/identity ID column.
| CardSet.Insert | Inserts a new record into the *cardset* table given the card set's details, including foreign keys for values in related tables (not the values themselves). This SPROC returns the ID of the new record.
| CardSet.Select | Returns the details of a card set from the *cardset* table, including foreign keys (not the associated values) based on either the card set's ID or based on 4 values that should uniquely identify the card set: *BaseSetName*, *InsertSetName*, *Season*, and *Sport_ID*. For the latter option, while there should never be more than one card set that has the same values for all 4 fields, there is nothing in the database or in the SPROC to prevent it, and so this SPROC could potentially return more than one result.
| CardValue.Insert | Inserts a new record into the *cardvalue* table given the details, including foreign keys for values in related tables (not the values themselves). This SPROC returns the ID of the new record.
| GoogleDocs.SelectAll | Returns all details for all records in the *GoogleDocsPages* table.
| GoogleDocs.SelectRowByID | Returns a single record from the *GoogleDocsPages* table based on the provided ID.
| GradingClass.Insert | Inserts a new record into the *gradingclass* table given the details. This SPROC returns the ID of the new record.
| GradingClass.Select | Returns the details of a grading class from the *gradingclass* table given either its ID or its Abbreviation. Note that, while there should never be two grading classes with the same abbreviation, there is nothing that prevents this from happening in the database, and so this SPROC could potentially return more than one result.
| Manufacturer.Insert | Inserts a new record into the *manufacturer* table given the details. This SPROC returns the ID of the new record.
| Manufacturer.Select | Returns the details of a manufacturer from the *manufacturer* table given either its ID or its Name. Note that, while there should never be two manufacturer's with the same name, there is nothing that prevents this from happening in the database, and so this SPROC could potentially return more than one result.
| PlayerPosition.Insert | Inserts a new record into the *playerposition* table given the details. This SPROC returns the ID of the new record.
| PlayerPosition.Select | Returns the details of a player position from the *playerposition* table given either its ID or its Abbreviation. Note that, while there should never be two positions with the same abbreviation, there is nothing that prevents this from happening in the database, and so this SPROC could potentially return more than one result. Also note that retrieving by Abbreviation alone may not be reliable after expanding to more than one sport.
| SingleCard.Insert | Inserts a new record into the *singlecard* table given its details, including its custom-created ID (ie. IDs are not auto-generated), including foreign keys for values in related tables (not the values themselves).
| SingleCardGrading.Insert | Inserts a new record into the *singlecardgrading* table given the details, including foreign keys for values in related tables (not the values themselves). This SPROC returns the ID of the new record.
| Subset.Insert | Inserts a new record into the *subset* table given the details, including foreign keys for values in related tables (not the values themselves). This SPROC returns the ID of the new record.
| Subset.Select | Returns the details of a subset from the *subset* table, including foreign keys (not the associated values) based on either the subset's ID or based on 2 values that should uniquely identify the subset: *Name*, and *CardSet_ID*. For the latter option, while there should never be more than one subset that has the same values for both fields, there is nothing in the database or in the SPROC to prevent it, and so this SPROC could potentially return more than one result.
| Team.Insert | Inserts a new record into the *team* table given the team's details, including foreign keys for values in related tables (not the values themselves). This SPROC returns the ID of the new record.
| Team.Select | Returns the details of a team from the *team* table given either its ID or its Name. Note that, while there should never be two teams's with the same name, there is nothing that prevents this from happening in the database, and so this SPROC could potentially return more than one result. Also note that retrieving by Name alone may not be reliable after expanding to more than one sport.

**Note**: The naming convention of stored procedures, where possible, is {TABLE}.{OPERATION}, and this should be followed going forward.