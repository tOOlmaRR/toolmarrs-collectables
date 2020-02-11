<?php
namespace GeoTradingCards\InventoryImportUtility;

/**
* CSV Inventory Importer
* A class used specificaly for importing CSV files. This could be extended as needed if I deal with different CSV formats
* @author    George U. Marr
*/    
class CsvImporter extends baseImporter implements iImporter
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
        
        // only process files with a .csv extension
        foreach ($files as $key => $file) {
            $file = strtolower($file);
            if (strpos($file, ".csv") === false) {
                unset($files[$key]);
            }
        }
        
        // return the final list of files to process
        return $files;
    }
}
