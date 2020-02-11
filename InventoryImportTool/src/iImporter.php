<?php
namespace GeoTradingCards\InventoryImportUtility;

Interface iImporter
{
    /*
        Given a file path, look for files, and return, a list of files to import
        @param string $importFolder The full file-system path to scan looking for files to process
        @return array A list of files that can be processed
    */
    public function locateFilesToImport($importFolder);
    
    /*
        Given a file with full path, perform some basic validation checks on it to ensure that it can be processed.
        @param string $fullFilePath The full file-system path and name of file to validate
        @param string $fileContent The full content of the file
        @param string $rejectionReason The reason why the date file was judged to be invalid
        @return boolean [true} if the file appears to be valid, {false} if it's deemed invalid
    */ 
    public function validateFile($fullFilePath, &$fileContent, &$rejectionReason);
    
    /*
        Given the full content of a file, parse out the data we would like to insert into the database
        @param string $fullFileContent The full content of the file
        @return boolean [true} if the file appears to be valid, {false} if it's deemed invalid
    */ 
    public function parseFile($fullFileContent);
    
    public function buildDatabaseObjects($inventoryObjects);
    
    public function insertDatabaseObjects($databaseObjects);
}
?>