# Geo Trading Cards

## Summary:
This is a repository for all code related to Geo Trading Cards and Collectables. The major applications and/or components are listed below, and each has its own documentation. Click on a section header below to view more spefic documentation.

## [Website](/GeosTradingCards/README.md):
The "public" website for Geo Trading Cards, including an old management section previously used to manage the Google Docs/Sheets that contain some of the inventory.

## [Database](/Database/README.md):
The database stores all inventory and related sets, insert sets, cards, singles, and so on in a fairly complex and normalized database. The database was originally built in MySQL and was rebuilt and enhanced in MSSQL. There are some common scripts included within the Git repository to help find and maintain inventory and a history of changes made to the schema. There are some scripts for both database technologies, but anything related to MySQL may be a bit out of date at this point.

## [Import Utility](/InventoryImportTool/README.md):
A small PHP program that can be used to import existing inventory data into the database from "flat" text files. Currently only one format and layout is supported, based off of spreadsheets I've been building for years to track my inventory. The format and layout are very specific, and some updates may not be supported, but it will help with the process of importing existing inventory information into the database.

## [WinAdminUI](/WinAdminUI/README.md):
A Windows Forms application used to manage the inventory. This application is in its infancy and cannot do much just yet, but it will grow, and it will use the tSc API (below) to perform CRUD operations on the inventory data and will grow into a fully-fledged collection management tool.

## [tSc API](/API/README.md):
A node.js API used to manage inventory data. This is also in its infancy, but will become the backbone of both the website and the WinAdminUI.