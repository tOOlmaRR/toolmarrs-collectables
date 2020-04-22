<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\classes\Subset;
use GeoTradingCards\InventoryImportUtility\DAL\iEntity;
use GeoTradingCards\InventoryImportUtility\DAL\BaseEntity;

class SubsetEntity extends BaseEntity implements iEntity
{
    // private members
    private $ID;
    private $name;
    private $size;
    private $gradingModifier;
    private $cardSet_ID;
    
    // methods
    public function get($subset)
    {
        // set up the query
        $db = $this->getDB();
        $sqlParameters = array();
        
        // if we have an ID, query based on that alone
        if (!empty($subset->getID())) {
            $sql = "SELECT `ID`, `Name`, `Size`, `GradingModifier`, `CardSet_ID` FROM `subset` WHERE `ID` = :ID";
            $sqlParameters[":ID"] = $subset->getID();
        }
        
        // if we don't have an ID, use the Name of the Subset
        else {
            $sql = "SELECT `ID`, `Name`, `Size`, `GradingModifier`, `CardSet_ID` FROM `subset` WHERE `Name` = :name";
            $sqlParameters[":name"] = $subset->getName();
        }
        $getStatement = $db->prepare($sql);
        
        // perform the select and retrieve the data
        $getStatement->execute($sqlParameters);
        $row = $getStatement->fetch();
        $subsetFromDatabase = null;
        if ($row != false) {
            // build a business object based on the returned data
            $subsetFromDatabase = new Subset;
            $subsetFromDatabase->setID($row["ID"]);
            $subsetFromDatabase->setName($row["Name"]);
            
            $sizeInt = intval($row["Size"]);
            if ($sizeInt == 0) {
                $sizeInt = null;
            }
            $subsetFromDatabase->setSize($sizeInt);
            
            $gradingModifierFloat = floatval($row["GradingModifier"]);
            if ($gradingModifierFloat == 0) {
                $gradingModifierFloat = null;
            }
            $subsetFromDatabase->setGradingModifier($gradingModifierFloat);
        }
        return $subsetFromDatabase;
    }
    
    public function insert($subset)
    {
        $newID = null;
        
        // build up this entity object with the given business object
        $this->ID = $subset->getID();
        $this->name = $subset->getName();
        $this->size = $subset->getSize();
        $this->gradingModifier = $subset->getGradingModifier();
        $this->cardSet_ID = $subset->getCardSet()->getID();
        
        // set up the query
        $db = $this->getDB();
        $sql = "INSERT INTO `subset` (`Name`, `Size`, `GradingModifier`, `CardSet_ID`) VALUES (:name, :size, :gradingModifier, :cardSetID)";
        $insertStatement = $db->prepare($sql);
        
        // perform the insert
        $insertStatement->execute(array(
            ":name" => $this->name,
            ":size" => $this->size,
            ":gradingModifier" => $this->gradingModifier,
            ":cardSetID" => $this->cardSet_ID,
        ));
        
        // capture and return the new rows autoincremented ID
        $newID = $db->lastInsertId();
        if ($newID == 0) {
            $newID = null;
        }
        
        return $newID;
    }
}