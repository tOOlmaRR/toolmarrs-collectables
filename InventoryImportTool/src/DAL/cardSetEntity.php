<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\DAL\iEntity;
use GeoTradingCards\InventoryImportUtility\DAL\BaseEntity;
use GeoTradingCards\InventoryImportUtility\Classes\CardSet;
use GeoTradingCards\InventoryImportUtility\Classes\Manufacturer;
use GeoTradingCards\InventoryImportUtility\Helpers\DateTimeHelpers;

class CardSetEntity extends BaseEntity implements iEntity
{
    // private members
    private $baseSetName;
    private $insertSetName;
    private $fullName;
    private $season;
    private $size;
    private $rarity;
    private $gradingModifier;
    private $comments;
    private $lastBeckettUpdate;
    private $lastInventoryCheck;
    private $manufacturerID;
    
    
    
    // methods
    public function get($cardSet)
    {
        // set up the query
        $db = $this->getDB();
        $sql = "SELECT `ID`, `BaseSetName`, `InsertSetName`, `FullName`, `Season`, `Size`, `Rarity`, `GradingModifier`, `Comments`, `LastBeckettUpdate`, `LastInventoryCheck`, `Manufacturer_ID` FROM `CardSet` WHERE `BaseSetName` = :baseSetName AND `InsertSetName` = :insertSetName AND `Season` = :season LIMIT 1";
        $getStatement = $db->prepare($sql);
        
        // perform the select and retrieve the data
        $getStatement->execute(array(
            ":baseSetName" => $cardSet->getBaseSetName(),
            ":insertSetName" => $cardSet->getInsertSetName(),
            ":season" => $cardSet->getSeason()
        ));
        $row = $getStatement->fetch();
        $cardSetFromDatabase = null;
        if ($row != false) {
            // build a business object based on the returned data
            $cardSetFromDatabase = new CardSet;
            $cardSetFromDatabase->setID(intval($row["ID"]));
            $cardSetFromDatabase->setBaseSetName($row["BaseSetName"] != null ? $row["BaseSetName"] : '');
            $cardSetFromDatabase->setInsertSetName($row["InsertSetName"] != null ? $row["InsertSetName"] : '');
            $cardSetFromDatabase->setFullName($row["FullName"] != null ? $row["FullName"] : '');
            $cardSetFromDatabase->setSeason($row["Season"] != null ? $row["Season"] : '');
            
            $sizeInt = intval($row["Size"]);
            if ($sizeInt == 0) {
                $sizeInt = null;
            }
            $cardSetFromDatabase->setSize($sizeInt);
            $cardSetFromDatabase->setRarity($row["Rarity"] != null ? $row["Rarity"] : '');
            
            $gradingModifierFloat = floatval($row["GradingModifier"]);
            if ($gradingModifierFloat == 0) {
                $gradingModifierFloat = null;
            }
            $cardSetFromDatabase->setGradingModifier($gradingModifierFloat);
            $cardSetFromDatabase->setComments($row["Comments"] != null ? $row["Comments"] : '');
            $cardSetFromDatabase->setLastBeckettUpdate($row["LastBeckettUpdate"] != null ? $row["LastBeckettUpdate"] : '');
            $cardSetFromDatabase->setLastInventoryCheck($row["LastInventoryCheck"] != null ? $row["LastInventoryCheck"] : '');
            $cardSetFromDatabase->setManufacturer($cardSet->getManufacturer());
        }
        return $cardSetFromDatabase;
    }
    
    
    /**
    * Insert a given CardSet object into the database, if it doesn't already exist
    * In the absense of an ID, a CardSet is uniquely identified by it's BaseSetName, InsertSetName and Season
    * 
    * @param {CardSet} $cardSet
    * 
    * @return int
    */
    public function insert($cardSet)
    {
        $newID = null;
        
        // build up this entity object with the given business object
        $this->baseSetName = $cardSet->getBaseSetName();
        $this->insertSetName = $cardSet->getInsertSetName();
        $this->fullName = $cardSet->getFullName();
        $this->season = $cardSet->getSeason();
        $this->size = $cardSet->getSize();
        $this->rarity = $cardSet->getRarity();
        $this->gradingModifier = $cardSet->getGradingModifier();
        $this->comments = $cardSet->getComments();
        
        if (is_null($cardSet->getLastBeckettUpdate())) {
            $this->lastBeckettUpdate = null;
        } elseif (DateTimeHelpers::validateDateTime($this->lastBeckettUpdate, "l j, Y")) {
            $this->lastBeckettUpdate = $cardSet->getLastBeckettUpdate();
        } else {
            $this->lastBeckettUpdate = null;
        }
        $this->manufacturerID = $cardSet->getManufacturer()->getID();
        
        // set up the query
        $db = $this->getDB();
        $sql = "INSERT INTO `CardSet` (`BaseSetName`, `InsertSetName`, `FullName`, `Season`, `Size`, `Rarity`, `GradingModifier`, `Comments`, `LastBeckettUpdate`, `LastInventoryCheck`, `Manufacturer_ID`) VALUES (:baseSetName, :insertSetName, :fullName, :season, :size, :rarity, :gradingModifier, :comments, :lastBeckettUpdate, :lastInventoryCheck, :manufacturer_ID)";
        $insertStatement = $db->prepare($sql);
        
        // perform the insert
        $insertStatement->execute(array(
            ":baseSetName" => $this->baseSetName,
            ":insertSetName" => $this->insertSetName,
            ":fullName" => $this->fullName,
            ":season" => $this->season,
            ":size" => $this->size ?? null,
            ":rarity" => $this->rarity,
            ":gradingModifier" => $this->gradingModifier ?? null,
            ":comments" => $this->comments,
            ":lastBeckettUpdate" => $this->lastBeckettUpdate ?? null,
            ":lastInventoryCheck" => $this->lastInventoryCheck ?? null,
            ":manufacturer_ID" => $this->manufacturerID
        ));
        
        // capture and return the new rows autoincremented ID
        $newID = $db->lastInsertId();
        if ($newID == 0) {
            $newID = null;
        }
        return $newID;
    }
}