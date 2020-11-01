<?php
namespace GeoTradingCards\InventoryImportUtility;

use GeoTradingCards\InventoryImportUtility\iImporter;
use GeoTradingCards\InventoryImportUtility\classes\CardSet;
use GeoTradingCards\InventoryImportUtility\classes\CardAttribute;
use GeoTradingCards\InventoryImportUtility\DAL\EntityFactory;
use GeoTradingCards\InventoryImportUtility\DAL\ManufacturerEntity;
use GeoTradingCards\InventoryImportUtility\DAL\CardSetEntity;
use Noodlehaus\Config as Config;

/**
* Base Inventory Importer
* A base class for performing imports. This should be extended as needed if I deal with different file formats
* @author    George U. Marr
*/    
class BaseImporter implements iImporter
{
    // private members
    private $parserConfig;
    private $parsedCardSet;
    private $parseError = "";
    private $dataFileDelimiter;
    private $stopParsing;
    private $cardExistsinDB = false;
    


    // accessors
    public function getParserConfig() : Config
    {
        return $this->parserConfig;
    }

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
    protected function setParserConfig(Config $config) {
        $this->parserConfig = $config;
    }

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
    public function __construct($config)
    {
        $this->setStopParsing(false);
        $this->setParserConfig($config);
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
            $entityFactory = new EntityFactory($this->getParserConfig()['database']);
            $db = $entityFactory->getDatabaseConnection();
            $db->beginTransaction();
            
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
                    $this->cardExistsinDB = false;
                    $cardToInsert->setCardSet($cardSetToInsert);
                    
                    // TEAM
                    $failedInsertion = "";
                    if (!$this->insertTeam($cardToInsert, $entityFactory, $failedInsertion)) {
                        $this->setParseError("Database insert failure: $failedInsertion");
                        return false;
                    }
                    
                    // PLAYER POSITION
                    $failedInsertion = "";
                    if (!$this->insertPosition($cardToInsert, $entityFactory, $failedInsertion)) {
                        $this->setParseError("Database insert failure: $failedInsertion");
                        return false;
                    }
                    
                    // SUBSET
                    $failedInsertion = "";
                    if (!$this->insertSubset($cardSetToInsert, $cardToInsert, $entityFactory, $failedInsertion)) {
                        $this->setParseError("Database insert failure: $failedInsertion");
                        return false;
                    }
                    
                    // CARDs
                    $failedInsertion = "";
                    if (!$this->insertCard($cardToInsert, $entityFactory, $failedInsertion)) {
                        $this->setParseError("Database insert failure: $failedInsertion");
                        return false;
                    }
                    
                    // only insert card attributes and card value records if the current card doesn't already exist in the database
                    if (!$this->cardExistsinDB) {
                        // CARD ATTRIBUTES
                        $failedInsertion = "";
                        if (!$this->insertAttributes($cardToInsert, $entityFactory, $failedInsertion)) {
                            $this->setParseError("Database insert failure: $failedInsertion");
                            return false;
                        }
                        // CARD VALUE
                        $failedInsertion = "";
                        if (!$this->insertCardValue($cardToInsert, $entityFactory, $failedInsertion)) {
                            $this->setParseError("Database insert failure: $failedInsertion");
                            return false;
                        }
                    }
                    
                    // SINGLE CARDS
                    $singleCardsToinsert = $cardToInsert->getSingleCards();
                    if (!is_null($singleCardsToinsert) && count($singleCardsToinsert) > 0) {
                        foreach ($singleCardsToinsert as $singleCardToInsert) {
                            $failedInsertion = "";
                            if (!$this->insertSingle($singleCardToInsert, $entityFactory, $failedInsertion)) {
                                $this->setParseError("Database insert failure: $failedInsertion");
                                return false;
                            }
                            
                            // GRADING and GRADING CLASS
                            $failedInsertion = "";
                            if (!$this->insertGradingData($singleCardToInsert, $entityFactory, $failedInsertion)) {
                                $this->setParseError("Database insert failure: $failedInsertion");
                                return false;
                            }
                        }
                    }
                }
            }
            // if we got this far, and we have no errors, we should be good to commit the transaction!
            if (empty($this->getParseError())) {
                $db->commit();
                return true;
            } else {
                $db->rollback();
                return false;
            }
        }
        return true;        
    }
    
    
    
    // private methods
    private function insertManufacturer($cardSet, $entityFactory, &$failedInsertion)
    {
        // if there is no CardSet, we have a problem
        if (is_null($cardSet)) {
            $failedInsertion = "Manufacturer (CardSet is not defined)";
            return false;
        }
        
        // If there us no Manufacturer defined in the CardSet object, we have a problem - every CardSet must have a Manufacturer
        $manufacturer = $cardSet->getManufacturer();
        if (is_null($manufacturer)) {
            $failedInsertion = "Manufacturer (Manufacturer is not defined)";
            return false;
        }
        
        // If the Manufacturer already exists, retrieve it
        $manufacturerEntity = $entityFactory->getEntity("manufacturer");
        $existingManufacturer = $manufacturerEntity->get($manufacturer);
        
        // If the Manufacturer doesn't exist yet, insert it
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
            // If the Manufacturer already exists, update the object associated to the Card Set
            $cardSet->setManufacturer($existingManufacturer);
        }
        return true;
    }
    
    private function insertCardSet($cardSet, $entityFactory, &$failedInsertion) {
        // if there is no CardSet, we have a problem
        if (is_null($cardSet)) {
            $failedInsertion = "Card Set (CardSet is not defined)";
            return false;
        }

        // check if this card set already exists in the database
        $cardSetEntity = $entityFactory->getEntity("cardset");
        $existingCardSet = $cardSetEntity->get($cardSet);

        // If the CardSet already exists, grab it's ID and use that for proceeding inserts (note: card set details will not be updated)
        if (!is_null($existingCardSet)) {
            $cardSet->setID($existingCardSet->getID());
            $this->setParsedCardSet($cardSet);
        }
        // if the CardSet doesn't exist yet, insert it and ensure we keep it in memory
        else {
            try {
                $newCardSetID = $cardSetEntity->insert($cardSet);
                $cardSet->setID($newCardSetID);
                $this->setParsedCardSet($cardSet);
            } catch (\PDOException $ex) {
                $failedInsertion = "Card Set - Exception: " . $ex;
                return false;
            }
        }
        return true;
    }
    
    private function insertTeam($card, $entityFactory, &$failedInsertion)
    {
        // if no Card was provided, we have a problem
        if (is_null($card)) {
            $failedInsertion = "Team (Card is not defined)";
            return false;
        }
        
        // if no Team was provided, there is nothing to do
        $teamToInsert = $card->getTeam();
        if (is_null($teamToInsert)) {
            return true;
        }
        
        // If this Team exists, retrieve it
        $teamEntity = $entityFactory->getEntity("team");
        $existingTeam = $teamEntity->get($teamToInsert);

        // if the Team does not exist yet, insert it
        if (is_null($existingTeam)) {
            try {
                $newTeamID = $teamEntity->insert($teamToInsert);
                $teamToInsert->setID($newTeamID);
            } catch (\PDOException $ex) {
                $failedInsertion = "Team - Exception: " . $ex;
                return false;
            }
        } else {
            // If the Team already exists, update the object associated to the Card
            $card->setTeam($existingTeam);
        }
        return true;
    }
    
    private function insertPosition($card, $entityFactory, &$failedInsertion) {
        // if no Card was provided, we have a problem
        if (is_null($card)) {
            $failedInsertion = "Player Position (Card is not defined)";
            return false;
        }
        
        // if no PlayerPosition was provided, there is nothing to do
        $positionToInsert = $card->getPlayerPosition();
        if (is_null($positionToInsert)) {
            return true;
        }
        
        // If this PlayerPosition exists, retrieve it
        $positionEntity = $entityFactory->getEntity("position");
        $existingPosition = $positionEntity->get($positionToInsert);
        
        // if the PlayerPosition does not exist yet, insert it
        if (is_null($existingPosition)) {
            try {
                $newPositionID = $positionEntity->insert($positionToInsert);
                $positionToInsert->setID($newPositionID);
            } catch (\PDOException $ex) {
                $failedInsertion = "Position - Exception: " . $ex;
                return false;
            }
        } else {
            // If the PlayerPosition already exists, update the object associated to the Card
            $card->setPlayerPosition($existingPosition);
        }
        return true;
    }
    
    private function insertSubset($cardSet, $card, $entityFactory, &$failedInsertion) {
        // if no Cardset was provided, we have a problem
        if (is_null($cardSet)) {
            $failedInsertion = "Subset (Cardset is not defined)";
            return false;
        }
        
        // if no Card was provided, we have a problem
        if (is_null($card)) {
            $failedInsertion = "Subset (Card is not defined)";
            return false;
        }
        
        // if no Subset object was provided, there is nothing to do
        $subsetToInsert = $card->getSubset();
        if (is_null($subsetToInsert)) {
            return true;
        }

        // Now that we know there's a Subset, and the CardSet has been inserted already, associate this Subset to it's CardSet
        $subsetToInsert->setCardSet($cardSet);
        
        // If this Subset exists, retrieve it
        $subsetEntity = $entityFactory->getEntity("subset");
        $existingSubset = $subsetEntity->get($subsetToInsert);
        
        // if the Subset does not exist yet, insert it
        if (is_null($existingSubset)) {
            try {
                $newSubsetID = $subsetEntity->insert($subsetToInsert);
                $subsetToInsert->setID($newSubsetID);
            } catch (\PDOException $ex) {
                $failedInsertion = "Subset - Exception: " . $ex;
                return false;
            }
        } else {
            // If the Subset already exists, update the object associated to the Card
            $card->setSubset($existingSubset);
        }
        return true;
    }
    
    private function insertCard($card, $entityFactory, &$failedInsertion)
    {
        // if no Card was provided, we have a problem
        if (is_null($card)) {
            $failedInsertion = "Card (Card is not defined)";
            return false;
        }
        
        // Check to see if the Card already exists in the database
        $cardEntity = $entityFactory->getEntity("card");
        $existingCard = $cardEntity->get($card);
        
        // If this Card already exists, make a note of that, and use the Card found in the database (note: the existing card details will not be updated)
        if (!is_null($existingCard)) {
            $card->setID($existingCard->getID());
            $this->cardExistsinDB = true;
        }
        // if the Card doesn't exist yet, insert it and add it to the CardSet object
        else {
            try {
                $newCardID = $cardEntity->insert($card);
                $card->setID($newCardID);
                $this->getParsedCardSet()->addCard($card);
            } catch (\PDOException $ex) {
                $failedInsertion = "Card - Exception: " . $ex;
                return false;
            }
        }
        return true;
    }
    
    private function insertAttributes($card, $entityFactory, &$failedInsertion)
    {
        $attributesToInsert = $card->getAttributes();
        
        // if there are no Attributes, there's nothing to do
        if (is_null($attributesToInsert) || count($attributesToInsert) === 0) {
            return true;
        }
        
        foreach ($attributesToInsert as $attributeToInsert) {
            // If the Attribute already exists, retrieve it
            $attributeEntity = $entityFactory->getEntity("attribute");
            $existingAttribute = $attributeEntity->get($attributeToInsert);
            
            // If the Attribute doesn't exist yet, insert it
            if (is_null($existingAttribute)) {
                try {
                    $newAttributeID = $attributeEntity->insert($attributeToInsert);
                    $attributeToInsert->setID($newAttributeID);
                } catch (\PDOException $ex) {
                    $failedInsertion = "Attribute - Exception: " . $ex;
                    return false;
                }
            } else {
                // If the Attribute already exists, update the object associated to the Card
                $attributeToInsert = $existingAttribute;
            }
            
            // Now relate this Card to the Attribute in the database by inserting a 'CardHasAttributes' record
            $cardHasAttributeEntity = $entityFactory->getEntity("cardhasattribute");
            $cardHasAttributes = (object)['cardID' => $card->getID(),'attributeID' => $attributeToInsert->getID()];
            try {
                $cardHasAttributeEntity->insert($cardHasAttributes);
            } catch (\PDOException $ex) {
                $failedInsertion = "Card Has Attributes - Exception: " . $ex;
                return false;
            }
        }
        return true;
    }
    
    private function insertCardValue($card, $entityFactory, &$failedInsertion) {
        // if no Card was provided, we have a problem
        if (is_null($card)) {
            $failedInsertion = "Card Value (Card is not defined)";
            return false;
        }
        
        // If no CardValue object was provided, there is nothing to do
        $cardValueToInsert = $card->getCardValue();
        if (is_null($cardValueToInsert)) {
            return true;
        }
        
        // Insert the new CardValue object
        try {
            $cardValueEntity = $entityFactory->getEntity("cardvalue");
            $newCardValueID = $cardValueEntity->insert($cardValueToInsert);
            $cardValueToInsert->setID($newCardValueID);
        } catch (\PDOException $ex) {
            $failedInsertion = "Card Value - Exception: " . $ex;
            return false;
        }
        return true;
    }
    
    private function insertSingle($singleCard, $entityFactory, &$failedInsertion) {
        // if no SingleCard was provided, we have a problem
        if (is_null($singleCard)) {
            $failedInsertion = "Single Card (Single Card is not defined)";
            return false;
        }
        
        // Insert the new SingleCard record - they should never already exist
        $singleCardEntity = $entityFactory->getEntity("single");
        try {
            $singleCardEntity->insert($singleCard);
        } catch (\PDOException $ex) {
            $failedInsertion = "Single Card - Exception: " . $ex;
            return false;
        }
        return true;
    }
    
    private function insertGradingData($singleCard, $entityFactory, &$failedInsertion) {
        // if no SingleCard was provided, we have a problem
        if (is_null($singleCard)) {
            $failedInsertion = "Grading (Single Card is not defined)";
            return false;
        }
        
        // if there is no SingleCardGrading object, there's nothing to do
        $gradingToInsert = $singleCard->getSingleCardGrading();
        if (is_null($gradingToInsert)) {
            return true;
        }
        
        // If there is a GradingClass provided continue on to insert it if needed
        $gradingClassToInsert = $gradingToInsert->getGradingClass();
        if (!is_null($gradingClassToInsert)) {
            // If this GradingClass exists, retrieve it
            $gradingClassEntity = $entityFactory->getEntity("gradingclass");
            $existingGradingClass = $gradingClassEntity->get($gradingClassToInsert);
            
            // if the GradingClass does not exist yet, insert it
            if (is_null($existingGradingClass)) {
                try {
                    $newGradingClassID = $gradingClassEntity->insert($gradingClassToInsert);
                    $gradingClassToInsert->setID($newGradingClassID);
                } catch (\PDOException $ex) {
                    $failedInsertion = "Grading Class - Exception: " . $ex;
                    return false;
                }
            } else {
                // If the GradingClass already exists, update the Grading object
                $gradingToInsert->setGradingClass($existingGradingClass);
            }
        }
        
        // Now insert the new SingleCardGrading record for the SingleCard
        $gradingEntity = $entityFactory->getEntity("grading");
        try {
            $newGradingID = $gradingEntity->insert($gradingToInsert);
            $gradingToInsert->setID($newGradingID);
            $singleCard->setSingleCardGrading($gradingToInsert);
        } catch (\PDOException $ex) {
            $failedInsertion = "Single Card Grading - Exception: " . $ex;
            return false;
        }
        return true;
    }
}