<?php
/**
* Card Inventory Import Tool
* This tool is designed to import card inventory from flat files into the GeoTradingCards database.
* @author    George U. Marr
*/

declare(strict_types = 1);
ini_set("display_errors", "1");
ini_set("display_startup_errors", "1");
error_reporting(-1);

require "vendor/autoload.php";

use GeoTradingCards\InventoryImportUtility\classes\Card;
use GeoTradingCards\InventoryImportUtility\classes\CardAttribute;
use GeoTradingCards\InventoryImportUtility\classes\CardSet;
use GeoTradingCards\InventoryImportUtility\classes\CardValue;
use GeoTradingCards\InventoryImportUtility\classes\GradingClass;
use GeoTradingCards\InventoryImportUtility\classes\League;
use GeoTradingCards\InventoryImportUtility\classes\Manufacturer;
use GeoTradingCards\InventoryImportUtility\classes\PlayerPosition;
use GeoTradingCards\InventoryImportUtility\classes\SingleCard;
use GeoTradingCards\InventoryImportUtility\classes\SingleCardGrading;
use GeoTradingCards\InventoryImportUtility\classes\Sport;
use GeoTradingCards\InventoryImportUtility\classes\Subset;
use GeoTradingCards\InventoryImportUtility\classes\Team;
use GeoTradingCards\InventoryImportUtility\GmarrStandardCsvImporter;
use Goodby\CSV\Import\Standard\Lexer;
use Goodby\CSV\Import\Standard\Interpreter;
use Goodby\CSV\Import\Standard\LexerConfig;
use Noodlehaus\Config as Config;

$environment = "development";
$configPath = __DIR__ . "\\config\\";

// Bootstapping, Configuration, and Setup
try {
    echo "Configuring the $environment environment... ";

    // Load configuration files
    $configFiles = array(
        $configPath . "config-shared.yml",
        $configPath . "inventory-header.yml",
        $configPath . "config-" . $environment . ".yml"
    );
    if (count($configFiles) > 0) {
        $config = new Config($configFiles);        
    }
    
    echo "$environment environment has been configured." . PHP_EOL;
} catch (Exception $ex) {
    trigger_error(
        "Inventory Import - Exception - Bootstrap - " . $ex->getMessage()
            . " - in File:  " . $ex->getFile()
            . " on Line " . $ex->getLine(),
        E_USER_ERROR
    );
    exit();
}

// Main Program
try {
    // Get list of files to import
    $localImportPath = __DIR__ . $config['data-files']['inventory']['importPath'];
    echo "Looking for files to process and import in $localImportPath ..." . PHP_EOL;
    $filesToProcess = GmarrStandardCsvImporter::locateFilesToImport($localImportPath);
    $fileCount = count($filesToProcess);
    echo "Found and returning a list of $fileCount files to process" . PHP_EOL;
    
    // Loop through each file
    foreach ($filesToProcess as $file) {
        $fileFullPath = $localImportPath . $file;
        echo PHP_EOL . "Beginning to process the following file: $fileFullPath" . PHP_EOL;
        
        // Instantiate objects
        $importer = new GmarrStandardCsvImporter($config);
        
        // read and validate the file
        $rejectionReason = "";
        $fileLooksValid = $importer->validateFile($fileFullPath, $rejectionReason);
        
        // if the file looks invalid, move it to the rejected folder, output the reason and move on
        if (!$fileLooksValid) {
            echo "*** This file has been rejected with the following reason: $rejectionReason" . PHP_EOL;
            $rejectedFileFullPath = __DIR__ . $config['data-files']['inventory']['rejectedPath'] . $file;
            echo "Moving $fileFullPath to $rejectedFileFullPath" . PHP_EOL;
            if (!rename($fileFullPath, $rejectedFileFullPath)) {
                echo "*** Failed to move rejected file out of the import folder!" . PHP_EOL;
            }
            continue;
        } else {
            echo "Data file appears to be valid... let's parse some data from it!" . PHP_EOL;
            $successFullyParsed = $importer->parseFileToImport($fileFullPath);
            if ($successFullyParsed) {
                echo "Success! The data file was parsed without issues." . PHP_EOL;
                echo "Let's insert this data into the database." . PHP_EOL;
                
                // Insert the data into the database
                $success = $importer->insertObjects();
                if (!$success) {
                    echo "Failure! An issue occured during database insertions: " . PHP_EOL;
                    if ($importer->getParseError() != "") {
                        echo $importer->getParseError();
                    }
                } else {
                    echo "Success! Data has been successfully inserted into the database" . PHP_EOL;
                    $processedFileFullPath = __DIR__ . $config['data-files']['inventory']['processedPath'] . $file;
                    echo "Moving $fileFullPath to $processedFileFullPath" . PHP_EOL;
                    if (!rename($fileFullPath, $processedFileFullPath)) {
                        echo "*** Failed to move processed file out of the import folder!" . PHP_EOL;
                    }
                }
            } else {
                echo "Failure! An issue was encountered during parsing: ." . $importer->getParseError() . PHP_EOL;
            }
        }
    }
    echo "All data files have been processed" . PHP_EOL;
    
} catch (Exception $ex) {
    trigger_error(
        "Inventory Import - Exception - Main Program - " . $ex->getMessage()
            . " - in File:  " . $ex->getFile()
            . " on Line " . $ex->getLine(),
        E_USER_ERROR
    );
    exit();
}