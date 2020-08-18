<?php
namespace GeoTradingCards\InventoryImportUtility;

use GeoTradingCards\InventoryImportUtility\classes\CardSet;
use GeoTradingCards\InventoryImportUtility\classes\Manufacturer;
use GeoTradingCards\InventoryImportUtility\classes\Card;
use GeoTradingCards\InventoryImportUtility\classes\SingleCard;
use GeoTradingCards\InventoryImportUtility\classes\CardAttribute;
use GeoTradingCards\InventoryImportUtility\classes\Team;
use GeoTradingCards\InventoryImportUtility\classes\League;
use GeoTradingCards\InventoryImportUtility\classes\Sport;
use GeoTradingCards\InventoryImportUtility\classes\PlayerPosition;
use GeoTradingCards\InventoryImportUtility\classes\CardValue;
use GeoTradingCards\InventoryImportUtility\classes\SingleCardGrading;
use GeoTradingCards\InventoryImportUtility\classes\GradingClass;
use GeoTradingCards\InventoryImportUtility\classes\Subset;

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
            
            $newCards = null;
            if ($newCardSet != null) {
                // parse out all cards from the second section (grid) of the data file and build a collection of Card objects
                $this->setStopParsing(false);
                $newCards = $this->parseCardsAndSinglesFromFile($fileResource, $fileRowNumber);
                
                // now add the collection of Cards to the CardSet object
                $newCardSet->setCards($newCards);
                
                // parse out details from the "Statistics" section at the bottom of the file and add to existing data objects
                $this->parseStatsSection($fileResource, $newCardSet, $fileRowNumber);
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
        // get the next record
        $currentRow = $this->readNextCsvRecord($fileResource);
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
                $currentRow = $this->readNextCsvRecord($fileResource);
                $fileRowNumber++;
            }
        } // end while

        return $newCardSet;
    } // end function
    
    private function parseCardsAndSinglesFromFile($fileResource, &$fileRowNumber) : array
    {
        // read the first row in the cards grid
        $currentRow = $this->readNextCsvRecord($fileResource);
        $fileRowNumber++;
        
        // loop through rows in the data file one-at-a-time until:
        // 1) EOF is reached (or we receive a 'false' value when trying to read the file, which is generally only at the end of a File
        // 2) the first cell in the row has the value of "Statistics" (denotes the beginning of the last section of the file)
        // 3) the stopParsing flag has been explicitly set to true
        $newCards = Array();
        $rowNumber = 1;
        while (!$this->getStopParsing() && $currentRow !== false && $currentRow[0] !== "Statistics") {
            // skip empty rows
            if (count(array_filter($currentRow)) == 0) {
                break;
            }
            
            // begin building new Card objects
            $newCard = new Card();
            $newSingleCard = new SingleCard();

            // Handle each column separately
            for ($columnNumber = 0; $columnNumber < count($currentRow); $columnNumber++) {
                $cellValue = $currentRow[$columnNumber];
                $trimmedCellValue = trim($cellValue);
                switch ($columnNumber) {
                    // ID:  assign this value to the ID field in the new SingleCard object and associate it to the Card now that we have an ID (which we are indexing on)
                    case 0: // Card.SingleCards.ID
                        $singleCardID = $trimmedCellValue;
                        $newSingleCard->setID($singleCardID);
                        $newCard->addSingleCard($newSingleCard);
                        unset($singleCardID);
                        break;

                    // #: first check if we've already created a Card with this card number.
                    // If we have, look up that Card object in memory and use that instead of the new one we just created
                    // If we need the new Card object, assign this value to it's CardNumber field
                    case 1: // Card.CardNumber
                        $newCard->setCardNumber($trimmedCellValue);
                        if (!empty($trimmedCellValue) && array_key_exists($trimmedCellValue, $newCards)) {
                            // don't lose the SingleCard we already created in case 0 above
                            $singles = $newCard->getSingleCards();
                            $newCard = $newCards[$trimmedCellValue];
                            $newCard->addSingleCard($newSingleCard);
                        }
                        // associate the Card to the SingleCard
                        $newSingleCard->setCard($newCard);
                        unset($singles);
                        break;

                    // Description: just assign this to Card.Title after stripping whitespace
                    case 2: // Card.Title
                        $cardNumber = $newCard->getCardNumber();
                        // Special Case: card with no card number already exists (indexed by title)
                        if (empty($cardNumber) && array_key_exists($trimmedCellValue, $newCards)) {
                            // don't lose the SingleCard we already created in case 0 above
                            $singles = $newCard->getSingleCards();
                            $newCard = $newCards[$trimmedCellValue];
                            $newCard->addSingleCard($newSingleCard);
                            // associate the Card to the SingleCard
                            $newSingleCard->setCard($newCard);
                            unset($singles);
                        }
                        // Normal Case

                        else {
                            $newCard->setTitle($trimmedCellValue);
                            unset($trimmedCellValue);
                        }
                        break;
                    
                    // RC: build a CardAttribute object by hand and assign this value to it's Abbreviation field
                    // also supports a space-delimited list of attributes, not just the RC attribute (adds more CardAttributes to the Card)
                    // allow the DAL to determine if it needs to be inserted or not
                    case 3: // Card.Attributes
                        if (!empty($trimmedCellValue)) {
                            $attributeObjects = array();
                            $attributes = array();
                            if (!StringHelpers::contains($trimmedCellValue, " ")) {
                                $attributes[] = $trimmedCellValue;
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

                    // Team: build a Team object, assign this value to it's Name field, and associate the Team to the Card
                    // allow the DAL to determine if it needs to be inserted or not
                    case 4: // Card.Team.Name
                        if (!empty($trimmedCellValue)) {
                            $newTeam = new Team();
                            $newTeam->setName($trimmedCellValue);
                            
                            // TODO: Support Leagues other than the NHL, and cases where NHL may not be ID=1 in the database
                            $nhlLeague = new League();
                            $nhlLeague->setID(1);
                            $nhlLeague->setName('National Hockey League');
                            $nhlLeague->setAbbreviation('NHL');
                            $hockeySport = new Sport();
                            $hockeySport->setID(1);
                            $hockeySport->setName("Hockey");
                            $nhlLeague->setSport($hockeySport);
                            
                            $newTeam->setLeague($nhlLeague);
                            $newCard->setTeam($newTeam);
                        }
                        unset($newTeam);
                        break;

                    // Position: build a PlayerPosition object, assign this value to it's Abbreviation field, and associate the PlayerPosition to the Card
                    // allow the DAL to determine if it needs to be inserted or not
                    case 5: // Card.PlayerPosition.Abbreviation
                        if (!empty($trimmedCellValue)) {
                            $newPosition = new PlayerPosition();
                            $newPosition->setAbbreviation($trimmedCellValue);
                            $newCard->setPlayerPosition($newPosition);
                        }
                        unset($newPosition);
                        break;
                    // LOW: build a CardValue object, strip the $ from this value, convert it to a float, assign this value to the LowValue field in this new object,
                    // and associate this new CardValue object to the Card object
                    case 6: // Card.CardValue.LowValue
                        $lowValueAsStringFromFile = ltrim($trimmedCellValue, "$");
                        $newCardValue = new CardValue();
                        $newCardValue->setCard($newCard);
                        if (empty($lowValueAsStringFromFile)) {
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
                    
                    // HIGH: strip the $ from this value, convert it to a float, and assign this value to the HighValue property in the Card's CardValue object
                    case 7: // Card.CardValue.HighValue
                        $highValueAsStringFromFile = ltrim($trimmedCellValue, "$");
                        if (empty($highValueAsStringFromFile)) {
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
                    
                    // SELL: strip the $ from this value, convert it to a float, and assign this value to the SellPrice field in the SingleCard object
                    case 8: // Card.SingleCard.SellPrice
                        $sellValueStringFromFile = ltrim($trimmedCellValue, "$");
                        if (empty($sellValueStringFromFile)) {
                            $newSingleCard->setSellPrice(null);
                        } elseif (is_numeric($sellValueStringFromFile)) {
                            $sellPrice = floatval($sellValueStringFromFile);
                            $newSingleCard->setSellPrice($sellPrice);
                        } else {
                            $this->setParseError("Sell value of this single card is not a numeric value");
                            $newSingleCard->setSellPrice(null);
                        }
                        unset($sellValueStringFromFile, $sellPrice);
                        break;

                    // Condition: build a SingleCardGrading object and a GradingClass object, assign this value to the Abbreviation field in the GradingClass object,
                    // and link these new objects up with the Card in a chain (Card -> SingleCardGrading -> GradingClass)
                    // allow the DAL to determine if it needs to be inserted or not
                    case 9: // Card.SingleCard.SingleCardGrading.GradingClass.Abbreviation
                        $conditionAbbreviation = strtoupper($trimmedCellValue);
                        if (!empty($conditionAbbreviation)) {
                            $newSingleGrading = new SingleCardGrading();
                            $newGradingClass = new GradingClass();
                            $newGradingClass->setAbbreviation($conditionAbbreviation);
                            $newSingleGrading->setGradingClass($newGradingClass);
                            $newSingleGrading->setSingleCard($newSingleCard);
                            $newSingleCard->setSingleCardGrading($newSingleGrading);
                        }
                        unset($newSingleGrading, $newGradingClass);
                        break;

                    // Subset: build a new Subset object, assign this value to it's Name field, and associate the Subset to the Card object
                    // deal with associating Subsets to CardSets later
                    // allow the DAL to determine if it needs to be inserted or not
                    case 10: // Card.Subset.Name
                        if (!empty($trimmedCellValue)) {
                            $newSubset = new Subset();
                            $newSubset->setName($trimmedCellValue);
                            $newSubset->setGradingModifier(1.0);
                            $newCard->setSubset($newSubset);
                        }
                        unset($newSubset);
                        break;

                    // Rarity: assign this value to the Rarity field in the SingleCard object
                    // this is part of SingleCard instead of Card to allow for serial #ed cards
                    case 11: // Card.SingleCard.Rarity
                        $newSingleCard->setRarity($trimmedCellValue);
                        break;
                    
                    // Grading: attempt to convert this value to a float. If we can, assign it to the OverallGrade field in the SingleCard's SingleCardGrading object
                    // if it can't, but there IS a value here, assign it to the Comments field in the Card's SingleCard object and explicitly indicate what this value is
                    case 12: // Card.SingleCard.SingleCardGrading.OverallGrade ~OR~ Card.SingleCard.Comments
                        if (!empty($trimmedCellValue)) {
                            if (is_numeric($trimmedCellValue)) {
                                $grade = floatval($trimmedCellValue);
                                $singleCardGrading = $newSingleCard->getSingleCardGrading();
                                $singleCardGrading->setOverallGrade($grade);
                            } else {
                                $gradingComments = "Grading Value: " . $trimmedCellValue;
                                $newSingleCard->setComments($gradingComments);    
                            }
                        }
                        unset($grade, $singleCardGrading, $gradingComments);
                        break;

                    // Cost: strip the $ from this value, convert it to a float, and assign this value to the Cost field in the Card's SingleCard object
                    case 13: // Card.SingleCard.Cost
                        $costStringFromFile = ltrim($trimmedCellValue, "$");
                        if (empty($costStringFromFile)) {
                            $newSingleCard->setCost(null);
                        } elseif (is_numeric($costStringFromFile)) {
                            $cost = floatval($costStringFromFile);
                            $newSingleCard->setCost($cost);
                        } else {
                            $this->setParseError("Cost of this single card is not a numeric value");
                            $newSingleCard->setCost(null);
                        }
                        unset($costStringFromFile, $cost);
                        break;

                    // Status: assign this value to the Status property in the Card's SingleCard object and replace bigger dashes with smaller ones
                    case 14: // Card.SingleCard.Status
                        $singleCardStatusFromFile = $trimmedCellValue;
                        $singleCardStatusFromFile = str_replace("–", "-", $singleCardStatusFromFile);
                        $newSingleCard->setStatus($singleCardStatusFromFile);
                        break;

                    // Sold: strip the $ from this value, convert it to a float, and assign this value to the PriceSoldFor field in the Card's SingleCard object
                    case 15: // Card.SingleCard.PriceSoldFor
                        $soldStringFromFile = ltrim($trimmedCellValue, "$");
                        if (empty($soldStringFromFile)) {
                            $newSingleCard->setPriceSoldFor(null);
                        } elseif (is_numeric($soldStringFromFile)) {
                            $sold = floatval($soldStringFromFile);
                            $newSingleCard->setPriceSoldFor($sold);
                        } else {
                            $this->setParseError("'Price Sold For' of this single card is not a numeric value");
                            $newSingleCard->setPriceSoldFor(null);
                        }
                        unset($soldStringFromFile, $sold);
                        break;

                    // Comments: assign this value to the Comments field in the Card's SingleCard object
                    // if there's already a value there, append this value and include a explicit delimiter
                    case 16: // Card.SingleCard.Comments
                        $existingComments = $newSingleCard->getComments();
                        if (!empty($existingComments)) {
                            $newSingleCard->setComments($existingComments . "; Comments: " . $trimmedCellValue);
                        } else {
                            $newSingleCard->setComments($trimmedCellValue);
                        }
                        break;

                    default:
                        // TODO: later, once I've implemented handlers for all columns, we might want to raise an error if this occurs
                        break;
                } // end switch
            } // end for
            
            // set other fields that we do not parse from the data file
            $newCard->setGradingModifier(1.0);
            $newCard->setComments("");
            
            // add this new Card to the collection - include special case for cards with no card number (use title as the key)
            $cardNumber = $newCard->getCardNumber();
            if (empty($cardNumber)) {
                $newCardsKey = $newCard->getTitle();
            } else {
                $newCardsKey = $cardNumber;
            }
            $newCards[$newCardsKey] = $newCard;

            // FOR TESTING ONLY
            /*if ($rowNumber == 1) {
                break;
            }*/
            // move on to the next row
            $currentRow = $this->readNextCsvRecord($fileResource);
            $fileRowNumber++;
            $rowNumber++;
        } // end while
        return $newCards;
    } // end function

    private function parseStatsSection($fileResource, $cardSet, &$fileRowNumber)
    {
        $lastValueUpdate = null;
        $pricingSource = null;
        do {
            // read the first row in the stats section
            $currentRow = $this->readNextCsvRecord($fileResource);
            $fileRowNumber++;
            
            // skip empty rows, or if it looks like we're at the end of the file
            if ($currentRow == "" || count(array_filter($currentRow)) == 0) {
                continue;
            }
            
            $label = $currentRow[0];
            $label = trim($label);
            
            // Card.CardValue.LastAppraisal
            if (strcasecmp($label, "Last Value Update") === 0) {
                $lastValueUpdate = $this->parseStatValue($currentRow, 3);
            }

            // CardSet.LastInventoryCheck            
            elseif (strcasecmp($label, "Last Inventory Check") === 0) {
                $lastInventoryCheck = $this->parseStatValue($currentRow, 3);
                $cardSet->setLastInventoryCheck(trim($lastInventoryCheck));
            }

            // Card.CardValue.LastAppraisalSource
            elseif (strcasecmp($label, "Pricing Source") === 0) {
                $pricingSource = $this->parseStatValue($currentRow, 3);
            }

            // CardsSet.LastBeckettUpdate
            elseif (strcasecmp($label, "Beckett.com Last Update") === 0) {
                $beckettLastUpdate = $this->parseStatValue($currentRow, 3);
                $cardSet->setLastBeckettUpdate(trim($lastInventoryCheck));
            }

            // Ignore other rows
            else {
                continue;
            }
        } while (!$this->getStopParsing() && $currentRow !== false && $currentRow != "");
        
        // if there are no values to update in Cards, skip this
        if (is_null($lastValueUpdate) && is_null($pricingSource)) {
            return;
        }
        
        // if there are no cards, throw an error
        $cards = $cardSet->getCards();
        if (is_null($cards) || count($cards) === 0) {
            $this->setParseError("No cards found in the current CardSet");
            return;
        }
        
        // Update all Cards with the data parsed above
        foreach ($cards as $card) {
            $cardValue = $card->getCardValue();
            
            // If this Card has no CardValue object, skip it
            if (is_null($cardValue)) {
                continue;
            }
            
            // set the appropriate values in the CardValue object
            $cardValue->setLastAppraisal(trim($lastValueUpdate));
            $cardValue->setLastAppraisalSource(trim($pricingSource));
        }
    }
    
    private function parseStatValue($currentRow, $expectedColumn) : string {
        // first, look at the expected column for the value
        if (isset($currentRow[$expectedColumn]) && $currentRow[$expectedColumn] != "") {
            return trim($currentRow[$expectedColumn]);
        }
        // if there's nothing where we expect it to be, look at all other columns and stop once we find something
        else {
            for ($i = 1; $i <= count($currentRow); $i++) {
                if ($currentRow[$i] != "") {
                    return trim($currentRow[$i]);
                }
            }
        }
        // if we never found a value, set it to empty (since we at least found the key)
        return "";
    }
}