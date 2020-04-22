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
        
        // if we have an ID, query based on that alone
        if (!empty($gradingClass->getID())) {
            $sql = "SELECT `ID`, `Abbreviation`, `Name`, `Description` FROM `gradingclass` WHERE `ID` = :ID";
            $sqlParameters[":ID"] = $gradingClass->getID();
        }
        
        // if we don't have an ID, use the Abbreviation
        else {
            $sql = "SELECT `ID`, `Abbreviation`, `Name`, `Description` FROM `gradingclass` WHERE `Abbreviation` = :abbreviation";
            $sqlParameters[":abbreviation"] = $gradingClass->getAbbreviation();
        }
        $getStatement = $db->prepare($sql);
        
        // perform the select and retrieve the data
        $getStatement->execute($sqlParameters);
        $row = $getStatement->fetch();
        $gradingClassFromDatabase = null;
        if ($row != false) {
            // build a business object based on the returned data
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
        $sql = "INSERT INTO `gradingclass` (`Abbreviation`, `Name`, `Description`) VALUES (:abbreviation, :name, :description)";
        $insertStatement = $db->prepare($sql);
        
        // perform the insert
        $insertStatement->execute(array(
            ":abbreviation" => $this->abbreviation,
            ":name" => $this->name,
            ":description" => $this->description,
        ));
        
        // capture and return the new row's autoincremented ID
        $newID = $db->lastInsertId();
        if ($newID == 0) {
            $newID = null;
        }
        
        return $newID;
    }
}