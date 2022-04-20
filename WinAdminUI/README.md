# Geo Trading Cards - Windows Admin Tool

## Summary
This is a Windows Forms application that will be used to manage the data in the database. At some point early in development, I'd like to connect this tool to the API I'm building to centralize all interactions with the database

## Installation Instructions
1. Just run the setup.exe executable file
2. Program should appear in your 'start menu' under the "tOOlmaRR's Colectables" group

## Publishing Instructions
1. Publish via Visual Studio - settings shouldn't need tweaking (should publish into a /publish folder)
2. Copy all files to "//MARR2/Users/georg/OneDrive/Documents/tOOlmaRRs%2520Collectables/WinAdminUI/Latest/"
3. Copy all files to "C:\Users\georg\OneDrive\Documents\tOOlmaRRs Collectables\WinAdminUI\History" and ZIP them into a file like 'tScWinAdmin_v#.#.#.#'
4. Run the currently installed application
5. Update to the new version and test the latest program changes

## Page-Specific Documentation

### CardSets Admin
- For now, it's just a gridview bound directly to the cardsets table with the ability to insert new cardsets and update existing ones. There's no error handling, so exceptions thrown by SQL Server just cause the operation to fail not-so-gracefully. Also, there is no link to any related tables like CardValue or Attributes, and the manufacturer column only displays the FK ID.

## History

### v1.0.0.0
- card set admin page
	- data grid view to display all cardsets.
	- save botton which allows all changes in the grid to be saved.
	- undo button that undoes all undo changes made in teh grid since last save operation.
- documentation
- publish settings