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
        if ($this->getUseSPROCs()) {
            $sproc = $this->getSPROCs()["select"]["subset"];
            $sql = "EXEC [$sproc] @ID=:id, @name=:name, @cardSet_ID=:cardSetID";
            $sqlParams = [":id" => $subset->getID(),
                ":name" => $subset->getName(),
                ":cardSetID" => $subset->getCardSet()->getID()
            ];
        } else {
            // if we have an ID, query based on that alone
            if (!empty($subset->getID())) {
                $sql = "SELECT `ID`, `Name`, `Size`, `GradingModifier`, `CardSet_ID` FROM `subset` WHERE `ID` = :id";
                $sqlParams[":id"] = $subset->getID();
            }
            
            // if we don't have an ID, use the Name of the Subset
            // TODO: This is not sufficient to uniquely identify a SubSet - we need CardSet_ID as well...
            else {
                $sql = "SELECT `ID`, `Name`, `Size`, `GradingModifier`, `CardSet_ID` FROM `subset` WHERE `Name` = :name";
                $sqlParams[":name"] = $subset->getName();
            }
        }
        $getStatement = $db->prepare($sql);
        
        // perform the select and retrieve the data
        $getStatement->execute($sqlParams);
        $row = $getStatement->fetch();

        // build/return a business object based on the returned data
        $subsetFromDatabase = null;
        if ($row != false) {
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
        if ($this->getUseSPROCs()) {
            $sproc = $this->getSPROCs()["insert"]["subset"];
            $sql = "EXEC [$sproc] :id, :name, :size, :gradingModifier, :cardSetID";
            $insertStatement = $db->prepare($sql);
            $insertStatement->bindParam(":id", $newID, \PDO::PARAM_INT, 4);
        } else {
            $sql = "INSERT INTO `subset` (`Name`, `Size`, `GradingModifier`, `CardSet_ID`) VALUES (:name, :size, :gradingModifier, :cardSetID)";
            $insertStatement = $db->prepare($sql);
        }
        $insertStatement->bindParam(":name", $this->name);
        $insertStatement->bindParam(":size", $this->size);
        $insertStatement->bindParam(":gradingModifier", $this->gradingModifier);
        $insertStatement->bindParam(":cardSetID", $this->cardSet_ID);
        
        // perform the insert
        $insertStatement->execute();
        
        // capture and return the new rows autoincremented ID
        if (!$this->getUseSPROCs()) {
            $newID = $db->lastInsertId();
        }
        if ($newID == 0) {
            $newID = null;
        }
        
        return $newID;
    }
}