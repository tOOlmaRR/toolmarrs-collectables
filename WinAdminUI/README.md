# tOOlmaRR's Collectables - Windows Admin Tool
## Summary
This is a Windows Forms application that will be used to manage the data in the database. At some point early in development, I'd like to connect this tool to the API I'm building to centralize all interactions with the database

## Setup Instructions
1. Just run the executable file

## Page-Specific Documentation

### CardSets Admin
- For now, it's just a gridview bound directly to the cardsets table with the ability to insert new cardsets and update existing ones. There's no error handling, so exceptions thrown by Sql Server just cause the operation to fail not-so-gracefully. Also, there is no link to any related tables like CardValue or Attributes, and the manufacturer column only displays the FK ID.

## History
### v1.0.0.0
- card set admin page
	- data grid view to display all cardsets.
	- save botton which allows all changes in the grid to be saved.
	- undo button that undoes all undo changes made in teh grid since last save operation.
- documentation
- publish settings

