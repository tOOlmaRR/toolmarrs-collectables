<?php
namespace GeoTradingCards\InventoryImportUtility;

/**
* CSV Inventory Importer
* A class used specificaly for importing CSV files. This could be extended as needed if I deal with different CSV formats
* @author    George U. Marr
*/    
class CsvImporter extends BaseImporter implements iImporter
{
    // constructor(s)
    public function __construct()
    {
        parent::__construct();
        $this->setFileDelimiter(",");
    }
    
    
    
    // methods
    protected function readNextCsvRecord($fileResource)
    {
        // get the next record
        $currentRowRaw = fgetcsv($fileResource, 0, $this->getFileDelimiter());
        // convert Encoding to UTF-8 from ANSI (Windows-1252)
        $currentRow = mb_convert_encoding($currentRowRaw, "UTF-8", "Windows-1252");
        // return the resulting array
        return $currentRow;
    }
    
    
    
    // static methods
    public static function locateFilesToImport($importFolder) : array
    {
        $itemsToRemove = array(".", "..");
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
