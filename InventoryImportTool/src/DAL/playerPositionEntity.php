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
        if ($this->getUseSPROCs()) {
            $sproc = $this->getSPROCs()["select"]["playerposition"];
            $sql = "EXEC [$sproc] @ID=:id, @abbreviation=:abbreviation";
            $sqlParams = [":id" => $position->getID(),
                ":abbreviation" => $position->getAbbreviation()
            ];
        } else {
            // if we have an ID, query based on that alone
            if (!empty($position->getID())) {
                $sql = "SELECT `ID`, `Abbreviation`, `Name` FROM `playerposition` WHERE `ID` = :id";
                $sqlParams[":id"] = $position->getID();
            }
            
            // if we don't have an ID, use the Abbreviation of the PlayerPosition
            else {
                $sql = "SELECT `ID`, `Abbreviation`, `Name` FROM `playerposition` WHERE `Abbreviation` = :abbreviation";
                $sqlParams[":abbreviation"] = $position->getAbbreviation();
            }
        }
        $getStatement = $db->prepare($sql);
        
        // perform the select and retrieve the data
        $getStatement->execute($sqlParams);
        $row = $getStatement->fetch();
        
        // build/return a business object based on the returned data
        $positionFromDatabase = null;
        if ($row != false) {
            $positionFromDatabase = new PlayerPosition();
            $positionFromDatabase->setID($row["ID"]);
            $positionFromDatabase->setAbbreviation($row["Abbreviation"]);
            $positionFromDatabase->setName($row["Name"]);
        }
        return $positionFromDatabase;
    }
    
    public function insert($position)
    {
        $newID = null;

        // build up this entity object with the given business object
        $this->ID = $position->getID();
        $this->abbreviation = $position->getAbbreviation();
        $this->name = $position->getName();

        
        // set up the query
        $db = $this->getDB();
        if ($this->getUseSPROCs()) {
            $sproc = $this->getSPROCs()["insert"]["playerposition"];
            $sql = "EXEC [$sproc] :id, :abbreviation, :name";
            $insertStatement = $db->prepare($sql);
            $insertStatement->bindParam(":id", $newID, \PDO::PARAM_INT, 10);
        } else {
            $sql = "INSERT INTO `playerposition` (`Abbreviation`, `Name`) VALUES (:abbreviation, :name)";
            $insertStatement = $db->prepare($sql);
        }
        $insertStatement->bindParam(":abbreviation", $this->abbreviation);
        $insertStatement->bindParam(":name", $this->name);
        
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