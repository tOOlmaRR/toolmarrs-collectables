<?php
namespace GeoTradingCards\InventoryImportUtility;

use GeoTradingCards\InventoryImportUtility\iImporter;
use GeoTradingCards\InventoryImportUtility\classes\CardSet;
use GeoTradingCards\InventoryImportUtility\classes\CardAttribute;
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
    
    
    
    // static methods
    public static function locateFilesToImport($importFolder) : array
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
    
    
    
    // public methods
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
            $host = "mysql:host=127.0.0.1;dbname=tsc2020-dev";
            $user = "usr_tsc2020_dev_importer";
            $password = "$=5SZEXjKbgF7#t%";
            $entityFactory = new EntityFactory($host, $user, $password);
            
            // MANUFACTURER
            $failedInsertion = "";
            if (!$this->insertManufacturer($cardSetToInsert, $entityFactory, $failedInsertion)) {
                $this->setParseError("Database insert failure: $failedInsertion");
                return false;
            }
            
            // CARDSET
            $failedInsertion = "";
            if (!$this->insertCardSet($cardSetToInsert, $entityFactory, $failedInsertion)) {
                $this->setParseError("Database insert failure: $failedInsertion");
                return false;
            }
                    
            // Now start working through the Cards within the CardSet
            $cardsToInsert = $cardSetToInsert->getCards();
            if (!is_null($cardsToInsert) && count($cardsToInsert) > 0) {
                foreach ($cardsToInsert as $cardToInsert) {
                    // CARDs
                    $cardToInsert->setCardSet($cardSetToInsert);
                    $cardEntity = $entityFactory->getEntity("card");
                    $existingCard = $cardEntity->get($cardToInsert);
                    if (is_null($existingCard)) {
                        $newCardID = $cardEntity->insert($cardToInsert);
                        if (!is_null($newCardID)) {
                            $cardToInsert->setID($newCardID);
                            $this->getParsedCardSet()->addCard($cardToInsert);
                        } else {
                            $this->setParseError("Database insert failure: Card");
                            return false;
                        }
                    } else {
                        $this->setParseError("Card already exists; Updates via import files are not supported");
                        return false;
                    }
                    
                    // CARD ATTRIBUTES
                    $failedInsertion = "";
                    if (!$this->insertAttributes($cardToInsert, $entityFactory, $failedInsertion)) {
                        $this->setParseError("Database insert failure: $failedInsertion");
                        return false;
                    }
                }
            }
        }
        return true;
    }
    
    
    
    // private methods
    private function insertManufacturer($cardSet, $entityFactory, &$failedInsertion)
    {
        if (is_null($cardSet)) {
            $failedInsertion = "Manufacturer (CardSet is not defined)";
            return false;
        }
        
        $manufacturer = $cardSet->getManufacturer();
        if (is_null($manufacturer)) {
            $failedInsertion = "Manufacturer (Manufacturer is not defined)";
            return false;
        }
        
        $manufacturerEntity = $entityFactory->getEntity("manufacturer");
        $existingManufacturer = $manufacturerEntity->get($manufacturer);
        
        if (is_null($existingManufacturer)) {
            try {
                $newManufacturerID = $manufacturerEntity->insert($manufacturer);
                $manufacturer->setID($newManufacturerID);
                $cardSet->setManufacturer($manufacturer);
            } catch (\PDOException $ex) {
                $failedInsertion = "Manufacturer - Exception: " . $ex;
                return false;
            }
        } else {
            // If the manufacturer already exists, update the object associated to the Card Set
            $cardSet->setManufacturer($existingManufacturer);
        }
        return true;
    }
    
    private function insertCardSet($cardSet, $entityFactory, &$failedInsertion) {
        if (is_null($cardSet)) {
            $failedInsertion = "Card Set (CardSet is not defined)";
            return false;
        }
        
        $cardSetEntity = $entityFactory->getEntity("cardset");
        $existingCardSet = $cardSetEntity->get($cardSet);
        if (!is_null($existingCardSet)) {
            $failedInsertion = "Card Set (CardSet already exists)";
            return false;
        }
        
        // if we have a CardSet and it doesn't already exist, proceed with the insertion
        try {
            $newCardSetID = $cardSetEntity->insert($cardSet);
            $cardSet->setID($newCardSetID);
            $this->setParsedCardSet($cardSet);
        } catch (\PDOException $ex) {
            $failedInsertion = "Card Set - Exception: " . $ex;
            return false;
        }
        return true;
    }
    
    private function insertAttributes($card, $entityFactory, &$failedInsertion)
    {
        $attributesToInsert = $card->getAttributes();
        if (!is_null($attributesToInsert) && count($attributesToInsert) > 0) {
            foreach ($attributesToInsert as $attributeToInsert) {
                $attributeEntity = $entityFactory->getEntity("attribute");
                $existingAttribute = $attributeEntity->get($attributeToInsert);
                if (is_null($existingAttribute)) {
                    // create and insert a new Attribute
                    $newAttributeID = $attributeEntity->insert($attributeToInsert);
                    if (is_null($newAttributeID)) {
                        $failedInsertion = "Attribute";
                        return false;
                    }
                    $existingAttribute = new CardAttribute();
                    $existingAttribute->setID($newAttributeID);
                }
                // associate it to the Card via CardHasAttributes
                $cardHasAttributeEntity = $entityFactory->getEntity("cardhasattribute");
                $cardHasAttributes = (object)['cardID' => $card->getID(),'attributeID' => $existingAttribute->getID()];
                try {
                    $cardHasAttributeEntity->insert($cardHasAttributes);
                } catch (\PDOException $ex) {
                    $failedInsertion = "Card Has Attributes - Exception: " . $ex;
                    return false;
                }
            }
        }
        return true;
    }
}