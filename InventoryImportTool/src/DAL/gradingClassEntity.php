<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\classes\GradingClass;
use GeoTradingCards\InventoryImportUtility\DAL\iEntity;
use GeoTradingCards\InventoryImportUtility\DAL\BaseEntity;

class GradingClassEntity extends BaseEntity implements iEntity
{
    // private members
    private $ID;
    private $abbreviation;
    private $name;
    private $description;



    // methods
    public function get($gradingClass)
    {
        // set up the query
        $db = $this->getDB();
        $sqlParameters = array();
        if ($this->getSPROCs()) {
            $sproc = $this->getSPROCs()["select"]["gradingclass"];
            $sql = "EXEC [$sproc] @ID=:id, @abbreviation=:abbreviation";
            $sqlParams = [":id" => $gradingClass->getID(),
                ":abbreviation" => $gradingClass->getAbbreviation()
            ];
        } else {
            // if we have an ID, query based on that alone
            if (!empty($gradingClass->getID())) {
                $sql = "SELECT `ID`, `Abbreviation`, `Name`, `Description` FROM `gradingclass` WHERE `ID` = :id";
                $sqlParams[":id"] = $gradingClass->getID();
            }
            
            // if we don't have an ID, use the Abbreviation
            else {
                $sql = "SELECT `ID`, `Abbreviation`, `Name`, `Description` FROM `gradingclass` WHERE `Abbreviation` = :abbreviation";
                $sqlParams[":abbreviation"] = $gradingClass->getAbbreviation();
            }
        }
        $getStatement = $db->prepare($sql);
        
        // perform the select and retrieve the data
        $getStatement->execute($sqlParams);
        $row = $getStatement->fetch();

        // build/return a business object based on the returned data
        $gradingClassFromDatabase = null;
        if ($row != false) {
            $gradingClassFromDatabase = new GradingClass;
            $gradingClassFromDatabase->setID($row["ID"]);
            $gradingClassFromDatabase->setAbbreviation($row["Abbreviation"]);
            $gradingClassFromDatabase->setName($row["Name"]);
            $gradingClassFromDatabase->setDescription($row["Description"]);
        }
        return $gradingClassFromDatabase;
    }

    public function insert($gradingClass)
    {
        $newID = null;
        
        // build up this entity object with the given business object
        $this->abbreviation = $gradingClass->getAbbreviation();
        $this->name = $gradingClass->getName();
        $this->description = $gradingClass->getDescription();

        // set up the query
        $db = $this->getDB();
        if ($this->getUseSPROCs()) {
            $sproc = $this->getSPROCs()["insert"]["gradingclass"];
            $sql = "EXEC [$sproc] :id, :abbreviation, :name, :description";
            $insertStatement = $db->prepare($sql);
            $insertStatement->bindParam(":id", $newID, \PDO::PARAM_INT, 4);
        } else {
            $sql = "INSERT INTO `gradingclass` (`Abbreviation`, `Name`, `Description`) VALUES (:abbreviation, :name, :description)";
            $insertStatement = $db->prepare($sql);
        }
        $insertStatement->bindParam(":abbreviation", $this->abbreviation);
        $insertStatement->bindParam(":name", $this->name);
        $insertStatement->bindParam(":description", $this->description);
        
        // perform the insert
        $insertStatement->execute();
        
        // capture and return the new row's autoincremented ID
        if (!$this->getUseSPROCs()) {
            $newID = $db->lastInsertId();
        }
        if ($newID == 0) {
            $newID = null;
        }
        
        return $newID;
    }
}