[BACK](../README.md)

# Geo Trading Cards - Website

## Summary:
The "public" website for Geo Trading Cards, including an old management section previously used to manage the Google Docs/Sheets that contain some of the inventory.

## Inventory Pages
This is really the only area of the website that is dynamic. The "Browse Our Inventory" area is a web form that allows the visitor to select a card set to view based on the season and the card set name. The Card Set dropdown is populated dynamically based on the selection made in the season dropdown. The entire form is powered by the *GoogleDocsPages* table in the database, for now.

When you submit your selections from the web form, you will be redirected to the Inventory Listing page. This page receives the values submitted from the web form, looks up the URL to the related Google Doc via the *GoogleDocsPages* table in the database and then renders that page within an 'IFRAME' on the page. In the future, this page will retrieve and display inventory data directly from the database via calls to the API.

## History

### v1.3
- refactored existing README documentation to link together separate documents from each component of Geo Trading Cards, and wrote some additional documentation.

### v1.2
- The condition of the website when I ceased official buisness activities around the 2014-2015 timeframe.