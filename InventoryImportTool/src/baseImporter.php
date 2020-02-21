<?php
namespace GeoTradingCards\InventoryImportUtility;

use GeoTradingCards\InventoryImportUtility\iImporter;
use GeoTradingCards\InventoryImportUtility\classes\CardSet;
use GeoTradingCards\InventoryImportUtility\DAL\EntityFactory;
use GeoTradingCards\InventoryImportUtility\DAL\ManufacturerEntity;
use GeoTradingCards\InventoryImportUtility\DAL\CardSetEntity;

/**
* Base Inventory Importer
* A base class for performing imports. This should be extended as needed if I deal with different file formats
* @author    George U. Marr
*/    
class BaseImporter implements iImporter
{
    // private members
    private $parsedCardSet;
    private $parseError = "";
    private $dataFileDelimiter;
    private $stopParsing;


    // accessors
    public function getParsedCardSet() : ?CardSet
    {
        return $this->parsedCardSet ?? null;
    }
    
    public function getParseError() : string
    {
        return $this->parseError;
    }
    
    public function getFileDelimiter() : string
    {
        return $this->dataFileDelimiter;
    }
    
    protected function getStopParsing() : bool
    {
        return $this->stopParsing;
    }
    
    

    // setters
    protected function setParsedCardSet(CardSet $cardSet)
    {
        $this->parsedCardSet = $cardSet;
    }
    
    protected function setParseError(string $errorMessage)
    {
        $this->parseError = $errorMessage;
        $this->stopParsing = true;
    }
    
    protected function setFileDelimiter(string $delimiter)
    {
        $this->dataFileDelimiter = $delimiter;
    }
    
    protected function setStopParsing(bool $stop)
    {
        $this->stopParsing = $stop;
    }
    
    
    
    // constructor(s)
    public function __construct()
    {
        $this->setStopParsing(false);
    }
    
    
    
    // methods    
    public function locateFilesToImport($importFolder) : array
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
    
    public function validateFile($fullFilePath, &$rejectionReason) : bool
    {
        $fileContent = file_get_contents($fullFilePath);
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
    
    public function parseFileToImport($fullFileContent) : bool
    {
        throw new \Exception("Function has not been implemented");
    }
    
    public function insertObjects() : bool
    {
        $cardSetToInsert = $this->getParsedCardSet();

        if ($cardSetToInsert != null) {
            //TODO: Get the DB connection details from configuration
            $host = "mysql:host=localhost;dbname=tsc2020-dev";
            $user = "root";
            $password = "";
            $entityFactory = new EntityFactory($host, $user, $password);
            $manufacturer = $cardSetToInsert->getManufacturer();
            
            // MANUFACTURER
            if ($manufacturer != null) {
                // If the manufaturer doesn't already exist, insert it
                //$manufacturerEntity = new ManufacturerEntity();
                $manufacturerEntity = $entityFactory->getEntity("manufacturer");
                $existingManufacturer = $manufacturerEntity->get($manufacturer);
                if (is_null($existingManufacturer)) {
                    $newManufacturerID = $manufacturerEntity->insert($manufacturer);
                    if ($newManufacturerID !== false) {
                        $manufacturer->setID($newManufacturerID);
                        $cardSetToInsert->setManufacturer($manufacturer);
                    } else {
                        $this->setParseError("Database insert failure: Manufacturer");
                        return false;
                    }
                } else {
                    // If the manufacturer already exists, update the object associated to the Card Set
                    $cardSetToInsert->setManufacturer($existingManufacturer->getID());
                }
            } else {
                $this->getParseError("Manufacturer must be defined");
                return false;
            }
            
            // CARDSET
            //$cardSetEntity = new CardSetEntity();
            $cardSetEntity = $entityFactory->getEntity("cardset");
            $existingCardSet = $cardSetEntity->get($cardSetToInsert);
            
            // If the CardSet doesn't already exist, insert it
            if (is_null($existingCardSet)) {
                $newCardSetID = $cardSetEntity->insert($cardSetToInsert);
                if ($newCardSetID !== false) {
                    $cardSetToInsert->setID($newCardSetID);
                    $this->setParsedCardSet($cardSetToInsert);
                } else {
                    $this->setParseError("Database insert failure: Card Set");
                    return false;
                }
            } else {
                // Card Set already exists; cancel file processing
                $this->setParseError("Card Set already exists; Updates via import files are not supported");
                return false;
            }
        } else {
            $this->setParseError("Card Set must be defined");
        }
        
        //TODO: Cards
        
        return true;
    }
}