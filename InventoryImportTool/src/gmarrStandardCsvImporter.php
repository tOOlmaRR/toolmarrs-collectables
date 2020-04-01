<?php
namespace GeoTradingCards\InventoryImportUtility;

use GeoTradingCards\InventoryImportUtility\classes\CardSet;
use GeoTradingCards\InventoryImportUtility\classes\Manufacturer;
use GeoTradingCards\InventoryImportUtility\classes\Card;
use GeoTradingCards\InventoryImportUtility\classes\SingleCard;
use GeoTradingCards\InventoryImportUtility\classes\CardAttribute;
use GeoTradingCards\InventoryImportUtility\classes\Team;
use GeoTradingCards\InventoryImportUtility\classes\PlayerPosition;
use GeoTradingCards\InventoryImportUtility\classes\CardValue;
use GeoTradingCards\InventoryImportUtility\classes\SingleCardGrading;
use GeoTradingCards\InventoryImportUtility\classes\GradingClass;

use GeoTradingCards\InventoryImportUtility\Helpers\StringHelpers;

/**
* CSV Inventory Importer
* A class used specificaly for importing CSV files. This could be extended as needed if I deal with different CSV formats
* @author    George U. Marr
*/    
class GmarrStandardCsvImporter extends CsvImporter implements iImporter
{
    public function parseFileToImport($fullFileContent) : bool
    {
        $fileResource;
        $newCardSet = null;
        try {
            // Start reading from the file
            $fileResource = fopen($fullFileContent, "r");
            $fileRowNumber = 1;

            // parse out the Card Set from the first section of the data file and build a CardSet object
            $newCardSet = $this->parseCardSetDataFromFile($fileResource, $fileRowNumber);
            
            // parse out all cards from the second section (grid) of the data file and build a collection of Card objects
            $newCards = null;
            if ($newCardSet != null) {
                $this->setStopParsing(false);
                $newCards = $this->parseCardsAndSinglesFromFile($fileResource, $fileRowNumber);
                foreach ($newCards as $newCard) {
                    var_dump($newCard);
                }
                
                // now add the collection of Cards to the CardSet object
                $newCardSet->setCards($newCards);
            }

            // close the file now... we're done with it
            fclose($fileResource);
            
            // Parse failed if an error mesage was populated
            if ($this->getParseError() != "") {
                return false;
            } else {
                $this->setParsedCardSet($newCardSet);
                return true;
            }
        } catch (\Exception $ex) {
            fclose($fileResource);
            $this->setParsedCardSet(null);
            $this->setParseError("Exception: " . $ex);
            return false;
        }
    } // end function



    private function parseCardSetDataFromFile($fileResource, &$fileRowNumber) : CardSet
    {
        //$currentFileSection = "cardset";
        $currentRow = fgetcsv($fileResource, 0, $this->getFileDelimiter());
        $newCardSet = null;
        while (!$this->getStopParsing() && $currentRow !== false) {
            switch ($fileRowNumber) {
                /* Case 1: Parse out the custom Set title
                Expectations:
                - The first cell in the first line should be the full name of the card set
                */
                case 1: // full set name
                    $fullSetName = $currentRow[0];
                    $fullSetName = trim($fullSetName);
                    if ($fullSetName == "") {
                        $this->setParseError("Full set name not found in row $fileRowNumber");
                    } else {
                        $newCardSet = new CardSet();
                        $newCardSet->setFullName($fullSetName);
                    }
                    break;

                /* Cases 3-10: Parse out the Set Details
                Expectations:
                - The row immediately after the full set name is empty
                - The following rows should contain the detail label in the fist column, and then the value in the 4th column
                - The column labels should be "Season:", "Manufacturer", "Set", "Insert Set", "Size", "Rarity", "Grading Modifier", "Comments"
                - At minimum, we should have values for Season, Manufacturer and "Set". The remainder may be empty.
                */
                case 3: // season
                    $label = $currentRow[0];
                    $label = trim(strtolower($label));
                    if (StringHelpers::startsWith($label, "season")) {
                        $season = $currentRow[3];
                        $season = trim($season);
                        if ($season == "") {
                            $this->setParseError("Season value not found in row $fileRowNumber column 3");
                        } else {
                            $newCardSet->setSeason($season);
                        }
                    } else {
                        $this->setParseError("'Season:' row label not found in row $fileRowNumber");
                    }
                    break;

                case 4: // manufacturer
                    $label = $currentRow[0];
                    $label = trim(strtolower($label));
                    if (StringHelpers::startsWith($label, "manufacturer")) {
                        $manufacturerName = $currentRow[3];
                        $manufacturerName = trim($manufacturerName);
                        if ($manufacturerName == "") {
                            $this->setParseError("Manufacturer Name not found in row $fileRowNumber column 3");
                        } else {
                            $cardSetManufacturer = new Manufacturer();
                            $cardSetManufacturer->setName($manufacturerName);
                            $newCardSet->setManufacturer($cardSetManufacturer);
                        }
                    } else {
                        $this->setParseError("'Manufacturer:' row label not found in row $fileRowNumber" );
                    }
                    break;

                case 5: // base set
                    $label = $currentRow[0];
                    $label = trim(strtolower($label));
                    if (StringHelpers::startsWith($label, "set")) {
                        $baseSetName = $currentRow[3];
                        $baseSetName = trim($baseSetName);
                        if ($baseSetName == "") {
                            $this->setParseError("Base Set Name not found in row $fileRowNumber column 3");
                        } else {
                            $newCardSet->setBaseSetName($baseSetName);
                        }
                    } else {
                        $this->setParseError("'Set:' row label not found in row $fileRowNumber" );
                    }
                    break;

                case 6: // insert set
                    $label = $currentRow[0];
                    $label = trim(strtolower($label));
                    if (StringHelpers::startsWith($label, "insert set")) {
                        $insertSetName = $currentRow[3];
                        $insertSetName = trim($insertSetName);
                        $newCardSet->setInsertSetName($insertSetName);
                    } else {
                        $this->setParseError("'Insert Set:' row label not found in row $fileRowNumber" );
                    }
                    break;

                case 7: // size
                    $label = $currentRow[0];
                    $label = trim(strtolower($label));
                    if (StringHelpers::startsWith($label, "size")) {
                        $setSize = $currentRow[3];
                        $setSize = trim($setSize);
                        if ($setSize == "") {
                            $newCardSet->setSize(null);
                        } elseif (is_numeric($setSize)) {
                            $setSize = intval($setSize);
                            $newCardSet->setSize($setSize);
                        } else {
                            $this->setParseError("Size of card set is not an integer value");
                        }
                    } else {
                        $this->setParseError("'Size:' row label not found in row $fileRowNumber" );
                    }
                    break;

                case 8: // rarity
                    $label = $currentRow[0];
                    $label = trim(strtolower($label));
                    if (StringHelpers::startsWith($label, "rarity")) {
                        $rarity = $currentRow[3];
                        $rarity = trim($rarity);
                        $newCardSet->setRarity($rarity);
                    } else {
                        $this->setParseError("'Rarity:' row label not found in row $fileRowNumber" );
                    }
                    break;

                case 9: // grading modifier
                    $label = $currentRow[0];
                    $label = trim(strtolower($label));
                    if (StringHelpers::startsWith($label, "grading modifier")) {
                        $gradingMod = $currentRow[3];
                        $gradingMod = trim($gradingMod);
                        if ($gradingMod == "") {
                            $newCardSet->setGradingModifier(1.0);
                        } elseif (is_numeric($gradingMod)) {
                            $gradingMod = floatval($gradingMod);
                            $newCardSet->setGradingModifier($gradingMod);
                        } else {
                            $this->setParseError("Grading Modifier for the card set is not a numeric value");
                        }
                    } else {
                        $this->setParseError("'Grading Modifier:' row label not found in row $fileRowNumber" );
                    }
                    break;

                case 10: // comment
                    $label = $currentRow[0];
                    $label = trim(strtolower($label));
                    if (StringHelpers::startsWith($label, "comment")) {
                        $comments = $currentRow[3];
                        $comments = trim($comments);
                        $newCardSet->setComments($comments);
                    } else {
                        $this->setParseError("'Comments:' row label not found in row $fileRowNumber" );
                    }
                    break;

                case 12: // start of Card and Single Details Grid
                    //$currentFileSection = "carddetails";
                    $this->setStopParsing(true);
                    // don't break.... continue!'

                default:
                    break;
            } //end switch
            
            // If there isn't a flag to stop parsing, get the next row
            if (!$this->getStopParsing()) {
                $currentRow = fgetcsv($fileResource, 0, $this->getFileDelimiter());
                $fileRowNumber++;
            }
        } // end while

        return $newCardSet;
    } // end function
    
    private function parseCardsAndSinglesFromFile($fileResource, &$fileRowNumber) : array
    {
        // read the first row in the cards grid
        $currentRow = fgetcsv($fileResource, 0, $this->getFileDelimiter());
        
        // loop through rows in the data file one-at-a-time until:
        // 1) EOF is reached (or we receive a 'false' value when trying to read the file, which is generally only at the end of a File
        // 2) the first cell in the row has the value of "Statistics" (denotes the beginning of the last section of the file)
        // 3) the stopParsing flag has been explicitly set to true
        $newCards = Array();
        $rowNumber = 1;
        while (!$this->getStopParsing() && $currentRow !== false && $currentRow[0] !== "Statistics") {
            // begin building a new Card object
            $newCard = new Card();
            $singleCardID = null; // remember this while parsing through the current row
            // customize how to handle each column
            for ($columnNumber = 0; $columnNumber < count($currentRow); $columnNumber++) {
                $cellValue = $currentRow[$columnNumber];
                $trimmedCellValue = trim($cellValue);
                switch ($columnNumber) {
                    // For ID, we'll want to create a new SingleCard object and assign it to SingleCard.ID
                    case 0: // Card.SingleCards.ID
                        $singleCardID = $trimmedCellValue;
                        $newSingleCard = new SingleCard();
                        $newSingleCard->setID($singleCardID);
                        $newCard->addSingleCard($newSingleCard);
                        unset($newSingleCard);
                        break;

                    // For #, if Card.cardNumber already exists in the newCards array, don't create a new Card - pull the ID of the existing one.
                    case 1: // Card.CardNumber
                        $newCard->setCardNumber($trimmedCellValue);
                        
                        // check to see if this card has already been created and added to newcards array - if it has, retrieve and use it instead of the new one we're building
                        if (!empty($trimmedCellValue) && array_key_exists($trimmedCellValue, $newCards)) {
                            // don't lose the single we already created in case 0 above
                            $singles = $newCard->getSingleCards();
                            $newCard = $newCards[$trimmedCellValue];
                            $newCard->addSingleCard($singles[$singleCardID]);
                        }
                        unset($singles);
                        break;
                        

                    case 2: // Card.Title
                        // For Description, we just put this into Card.title after stripping whitespace
                        $newCard->setTitle($trimmedCellValue);
                        unset($trimmedCellValue);
                        break;
                    
                    case 3: // Card.Attributes
                        // For RC, instead of pulling from the database, we'll build the object by hand and have the DAL determine if it needs to be inserted or not
                        if (!empty($trimmedCellValue)) {
                            $attributeObjects = array();
                            $attributes = array();
                            if (!StringHelpers::contains($trimmedCellValue, " ")) {
                                $attributes[] = "RC";
                            } else {
                                $attributes = explode(" ", $trimmedCellValue);
                            }
                            
                            foreach ($attributes as $attribute) {
                                $attribute = strtoupper($attribute);
                                $newCardAttribute = new CardAttribute();
                                $newCardAttribute->setAbbreviation($attribute);
                                if ($attribute === "RC") {
                                    $newCardAttribute->setFullName("Rookie Card");
                                    $newCardAttribute->setComments("This card has been determined to be a rookie card through card appraisal sources such as Beckett");
                                }
                                $attributeObjects[] = $newCardAttribute;
                            }
                            $newCard->setAttributes($attributeObjects);
                        }
                        unset($attributeObjects, $attributes, $attribute, $newCardAttribute);
                        break;
                        
                    case 4: // Card.TeamID
                        // For Team, we'll just build and associate the Team and then have the DAL determine if it needs to be inserted or not
                        if (!empty($trimmedCellValue)) {
                            $newTeam = new Team();
                            $newTeam->setName($trimmedCellValue);
                            $newCard->setTeam($newTeam);
                        }
                        unset($newTeam);
                        break;
                        
                    case 5: // Card.PositionID
                        // For Position, we'll just build and associate the PlayerPosition and then have the DAL determine if it needs to be inserted or not
                        if (!empty($trimmedCellValue)) {
                            $newPosition = new PlayerPosition();
                            $newPosition->setAbbreviation($trimmedCellValue);
                            $newCard->setPlayerPosition($newPosition);
                        }
                        unset($newPosition);
                        break;
                        
                    case 6: // Card.CardValue.LowValue
                        // For LOW, we'll need to create a new CardValue object, convert the value to a plain old float value (strip the $), set CardValue.lowValue to this value, and associate this object to the Card object
                        $lowValueAsStringFromFile = ltrim($trimmedCellValue, "$");
                        $newCardValue = new CardValue();
                        if ($lowValueAsStringFromFile == "") {
                            $newCardValue->setLowValue(null);
                        } elseif (is_numeric($lowValueAsStringFromFile)) {
                            $lowValue = floatval($lowValueAsStringFromFile);
                            $newCardValue->setLowValue($lowValue);
                        } else {
                            $this->setParseError("Low value of this card is not a numeric value");
                            $newCardValue->setLowValue(null);
                        }
                        $newCard->setCardValue($newCardValue);
                        unset($lowValueAsStringFromFile, $newCardValue, $lowValue);
                        break;
                        
                    case 7: // Card.CardValue.HighValue
                        // For HIGH, convert the value to a float value (strip the $) and set the associated CardValue.highValue to this value
                        $highValueAsStringFromFile = ltrim($trimmedCellValue, "$");
                        if ($highValueAsStringFromFile == "") {
                            $newCard->getCardValue()->setHighValue(null);
                        } elseif (is_numeric($highValueAsStringFromFile)) {
                            $highValue = floatval($highValueAsStringFromFile);
                            $newCard->getCardValue()->setHighValue($highValue);
                        } else {
                            $this->setParseError("High value of this card is not a numeric value");
                            $newCard->getCardValue()->setHighValue(null);
                        }
                        unset($highValueAsStringFromFile, $highValue);
                        break;

                    case 8: //Card.SingleCard.SellPrice
                        // For SELL, convert the value to a float value (strip the $), find the single card (based on ID), and set the associated SingleCard.sellPrice to this value.
                        $sellValueStringFromFile = ltrim($trimmedCellValue, "$");
                        $singles = $newCard->getSingleCards();
                        
                        if ($sellValueStringFromFile == "") {
                            $singles[$singleCardID]->setSellPrice(null);
                        } elseif (is_numeric($sellValueStringFromFile)) {
                            $sellPrice = floatval($sellValueStringFromFile);
                            $singles[$singleCardID]->setSellPrice($sellPrice);
                        } else {
                            $this->setParseError("Sell value of this single card is not a numeric value");
                            $singles[$singleCardID]->setSellPrice(null);
                        }
                        unset($sellValueStringFromFile, $singles, $sellPrice);
                        break;
                        
                    case 9: // Card.SingleCard.SingleCardGrading.GradingClass.Abbreviation
                        // For Condition, create a SingleCardGrading object and a GradingClass object, find the single card (based on ID), assign the parsed value to GradingClass.Abbreviation and link up the two objects to the SingleCard. Let the DAL determine if it needs to be inserted or not.
                        $singles = $newCard->getSingleCards();
                        $conditionAbbreviation = strtoupper($trimmedCellValue);
                        if ($conditionAbbreviation !== "") {
                            $singleCardGrading = new SingleCardGrading();
                            $gradingClass = new GradingClass();
                            $gradingClass->setAbbreviation($conditionAbbreviation);
                            $singleCardGrading->setGradingClass($gradingClass);
                            $singles[$singleCardID]->setSingleCardGrading($singleCardGrading);
                        }
                        unset($singles, $singleCardGrading, $gradingClass);
                        
                        // For Subset, if it's already associated to the CardSet, use that object and associated this card to that Subset; if it's not, create a new Subset object, set it's Subset.Name to this value, and associate it to both the Card object and the CardSet object
                        // For Rarity, we just put this into associated SingleCard.rarity field after stripping whitespace
                        // For Grading, if there just happens to be a value (they should all be empty), set the associated SingleCardGrading.Description field with it's value for now (if there's a value already, append)
                        // For Cost, convert the value to a plain old float value (strip the $) and set the associated SingleCard.cost to this value.
                        // For Status, we just put this into associated SingleCard.status field after stripping whitespace
                        // For Sold, if there just happens to be a value (they should all be empty), convert the value to a plain old float value (strip the $) and set the associated  SingleCard.PriceSoldFor field with it's value
                        // For Comments, we just put this into associated SingleCard.Description field after stripping whitespace (if there's a value already, append)
                    default:
                        // TODO: later, once I've implemented handlers for all columns, we might want to raise an error if this occurs
                        break;
                } // end switch
            } // end for
            $newCards[$newCard->getCardNumber()] = $newCard;
            // FOR TESTING ONLY
            /*if ($rowNumber == 1) {
                break;
            }*/
            $currentRow = fgetcsv($fileResource, 0, $this->getFileDelimiter());
            $rowNumber++;
        } // end while
        return $newCards;
    } // end function

}