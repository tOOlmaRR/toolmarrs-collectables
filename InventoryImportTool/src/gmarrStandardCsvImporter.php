<?php
namespace GeoTradingCards\InventoryImportUtility;

/**
* CSV Inventory Importer
* A class used specificaly for importing CSV files. This could be extended as needed if I deal with different CSV formats
* @author    George U. Marr
*/    
class GmarrStandardCsvImporter extends csvImporter implements iImporter
{
    public function parseFile($fullFileContent)
    {
        // TODO: Parse out the custom Set title
        
        // TODO: Parse out the Set Details
        
        // TODO: Parse out the Set Contents (the only true CSV parsing here)
        
        // TODO: Parse out the Set Statistics
        
        // TODO: Parse out the Set Notes or Metadata
        
        return true;
    }
}