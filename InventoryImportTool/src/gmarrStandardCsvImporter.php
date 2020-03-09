<?php
namespace GeoTradingCards\InventoryImportUtility;

use GeoTradingCards\InventoryImportUtility\Helpers\StringHelpers;
use GeoTradingCards\InventoryImportUtility\classes\CardSet;
use GeoTradingCards\InventoryImportUtility\classes\Manufacturer;

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
            $currentFileSection = "cardset";
            $currentRow = fgetcsv($fileResource, 0, $this->getFileDelimiter());
            $rowNumber = 1;
            while (!$this->getStopParsing() && $currentRow !== false) {
                if ($currentFileSection = "cardset") {
                    switch ($rowNumber) {
                        /* Case 1: Parse out the custom Set title
                        Expectations:
                        - The first cell in the first line should be the full name of the card set
                        */
                        case 1: // full set name
                            $fullSetName = $currentRow[0];
                            $fullSetName = trim($fullSetName);
                            if ($fullSetName == "") {
                                $this->setParseError("Full set name not found in row $rowNumber");
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
                                    $this->setParseError("Season value not found in row $rowNumber column 3");
                                } else {
                                    $newCardSet->setSeason($season);
                                }
                            } else {
                                $this->setParseError("'Season:' row label not found in row $rowNumber");
                            }
                            break;
                        
                        case 4: // manufacturer
                            $label = $currentRow[0];
                            $label = trim(strtolower($label));
                            if (StringHelpers::startsWith($label, "manufacturer")) {
                                $manufacturerName = $currentRow[3];
                                $manufacturerName = trim($manufacturerName);
                                if ($manufacturerName == "") {
                                    $this->setParseError("Manufacturer Name not found in row $rowNumber column 3");
                                } else {
                                    $cardSetManufacturer = new Manufacturer();
                                    $cardSetManufacturer->setName($manufacturerName);
                                    $newCardSet->setManufacturer($cardSetManufacturer);
                                }
                            } else {
                                $this->setParseError("'Manufacturer:' row label not found in row $rowNumber" );
                            }
                            break;
                        
                        case 5: // base set
                            $label = $currentRow[0];
                            $label = trim(strtolower($label));
                            if (StringHelpers::startsWith($label, "set")) {
                                $baseSetName = $currentRow[3];
                                $baseSetName = trim($baseSetName);
                                if ($baseSetName == "") {
                                    $this->setParseError("Base Set Name not found in row $rowNumber column 3");
                                } else {
                                    $newCardSet->setBaseSetName($baseSetName);
                                }
                            } else {
                                $this->setParseError("'Set:' row label not found in row $rowNumber" );
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
                                $this->setParseError("'Insert Set:' row label not found in row $rowNumber" );
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
                                $this->setParseError("'Size:' row label not found in row $rowNumber" );
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
                                $this->setParseError("'Rarity:' row label not found in row $rowNumber" );
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
                                $this->setParseError("'Grading Modifier:' row label not found in row $rowNumber" );
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
                                $this->setParseError("'Comments:' row label not found in row $rowNumber" );
                            }
                            break;                        

                        case 12: // start of Card and Single Details Grid
                            $currentFileSection = "carddetails";
                            // don't break.... continue!'

                        default:
                            if ($currentFileSection == "cardset") {
                                break;
                            }                            
                    } //end switch
                }
                
                if ($currentFileSection == "carddetails") {
                    // TODO: Parse out the Set Contents (the only true CSV parsing here)
                }
                
                if ($currentFileSection == "setStats") {
                    // TODO: Parse out the Set Statistics
                }
                
                if ($currentFileSection == "setNotes") {
                    // TODO: Parse out the Set Notes or Metadata
                }
                
                if ($currentFileSection == "") {
                    // We're DONE!'
                    $this->setStopParsing(true);
                }
                
                // If there isn't a flag to stop parsing, get the next row
                if (!$this->getStopParsing()) {
                    $currentRow = fgetcsv($fileResource, 0, $this->getFileDelimiter());
                    $rowNumber++;
                }
            } // end while
            
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
    }    
}