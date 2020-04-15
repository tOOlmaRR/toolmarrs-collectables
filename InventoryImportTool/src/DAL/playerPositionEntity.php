<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\classes\PlayerPosition;
use GeoTradingCards\InventoryImportUtility\DAL\iEntity;
use GeoTradingCards\InventoryImportUtility\DAL\BaseEntity;

class PlayerPositionEntity extends BaseEntity implements iEntity
{
    // private members
    private $ID;
    private $abbreviation;
    private $name;



    // methods
    public function get($position)
    {
        // set up the query
        $db = $this->getDB();
        $sqlParameters = array();
        
        // if we have an ID, query based on that alone
        if (!empty($position->getID())) {
            $sql = "SELECT `ID`, `Abbreviation`, `Name` FROM `playerposition` WHERE `ID` = :ID";
            $sqlParameters[":ID"] = $position->getID();
        }
        
        // if we don't have an ID, use the Abbreviation of the PlayerPosition
        else {
            $sql = "SELECT`ID`, `Abbreviation`, `Name` FROM `playerposition` WHERE `Abbreviation` = :abbreviation";
            $sqlParameters[":abbreviation"] = $position->getAbbreviation();
        }
        $getStatement = $db->prepare($sql);
        
        // perform the select and retrieve the data
        $getStatement->execute($sqlParameters);
        $row = $getStatement->fetch();
        $positionFromDatabase = null;
        if ($row != false) {
            // build a business object based on the returned data
            $positionFromDatabase = new PlayerPosition();
            $positionFromDatabase->setID($row["ID"]);
            $positionFromDatabase->setAbbreviation($row["Abbreviation"]);
            $positionFromDatabase->setName($row["Name"]);
        }
        return $positionFromDatabase;
    }
    
    public function insert($objectToInsert)
    {
        $newID = null;

        // build up this entity object with the given business object
        $this->ID = $objectToInsert->getID();
        $this->abbreviation = $objectToInsert->getAbbreviation();
        $this->name = $objectToInsert->getName();

        
        // set up the query
        $db = $this->getDB();
        $sql = "INSERT INTO `playerposition` (`Abbreviation`, `Name`) VALUES (:abbreviation, :name)";
        $insertStatement = $db->prepare($sql);
        
        // perform the insert
        $insertStatement->execute(array(
            ":abbreviation" => $this->abbreviation,
            ":name" => $this->name
        ));
        
        // capture and return the new rows autoincremented ID
        $newID = $db->lastInsertId();
        if ($newID == 0) {
            $newID = null;
        }

        return $newID;
    }
}