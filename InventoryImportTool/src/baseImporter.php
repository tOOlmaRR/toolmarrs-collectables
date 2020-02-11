<?php
namespace GeoTradingCards\InventoryImportUtility;

/**
* Base Inventory Importer
* A base class for performing imports. This should be extended as needed if I deal with different file formats
* @author    George U. Marr
*/    
class BaseImporter implements iImporter
{
    public function locateFilesToImport($importFolder)
    {
        $itemsToRemove = array('.', '..');
        $files = scandir($importFolder);
        
        // remove the "." and ".." folders
        foreach ($itemsToRemove as $itemToRemove) {
            $index = array_search($itemToRemove, $files);
            if ($index !== false) {
                unset($files[$index]);
            }
        }
        
        // return the final list of files to process
        return $files;
    }
    
    public function validateFile($fullFilePath, &$fileContent, &$rejectionReason)
    {
        $fileContent = file_get_contents($fullFilePath);
        $fileContent = false;
        if ($fileContent === false) {
            $rejectionReason = "Could not read the data file";
            return false;
        } else if (trim($fileContent) == "") {
            $rejectionReason = "Data file is empty";
            return false;
        } else {
            return true;
        }
    }
    
    public function parseFile($fullFileContent)
    {
        throw new Exception("Function has not been implemented");
    }
    
    public function buildDatabaseObjects($inventoryObjects)
    {
        throw new Exception("Function has not been implemented");
    }
    
    public function insertDatabaseObjects($databaseObjects)
    {
        throw new Exception("Function has not been implemented");
    }
}