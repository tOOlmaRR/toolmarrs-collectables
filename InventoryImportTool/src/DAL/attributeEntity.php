<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\Classes\CardAttribute;
use GeoTradingCards\InventoryImportUtility\DAL\iEntity;
use GeoTradingCards\InventoryImportUtility\DAL\BaseEntity;

class AttributeEntity extends BaseEntity implements iEntity
{
    // private members
    private $ID;
    private $abbreviation;
    private $fullName;
    private $comments;
    
    
    
    // methods
    public function get($cardAttribute)
    {
        // set up the query
        $db = $this->getDB();
        $sqlParameters = array();
        
        // if we have an ID, query based on that alone
        if (!empty($cardAttribute->getID())) {
            $sql = "SELECT `ID`, `Abbreviation`, `FullName`, `Comments` FROM `attributes` WHERE `ID` = :ID";
            $sqlParameters[":ID"] = $card->getID();
        }
        // if we don't have an ID, use the abbreviation
        // TODO: Handle Error/Corrected Variations, and any other edge cases where two different cards in the same set may have the same card number
        else {
            $sql = "SELECT `ID`, `Abbreviation`, `FullName`, `Comments` FROM `attributes` WHERE `Abbreviation` = :abbreviation";
            $sqlParameters[":abbreviation"] = $cardAttribute->getAbbreviation();
        }
        $getStatement = $db->prepare($sql);
        
        // perform the select and retrieve the data
        $getStatement->execute($sqlParameters);
        $row = $getStatement->fetch();
        $cardAttributeFromDatabase = null;
        if ($row != false) {
            // build a business object based on the returned data
            $cardAttributeFromDatabase = new CardAttribute;
            $cardAttributeFromDatabase->setID($row["ID"]);
            $cardAttributeFromDatabase->setAbbreviation($row["Abbreviation"]);
            $cardAttributeFromDatabase->setFullName($row["FullName"]);
            $cardAttributeFromDatabase->setComments($row["Comments"]);
        }
        return $cardAttributeFromDatabase;
    }
    
    public function insert($cardAttribute)
    {
        $newID = null;
        
        // build up this entity object with the given business object
        $this->ID = $cardAttribute->getID();
        $this->abbreviation = $cardAttribute->getAbbreviation();
        $this->fullName = $cardAttribute->getFullName();
        $this->comments = $cardAttribute->getComments();
        
        // set up the query
        $db = $this->getDB();
        $sql = "INSERT INTO `attributes` (`Abbreviation`, `FullName`, `Comments`) VALUES (:abbreviation, :fullName, :comments)";
        $insertStatement = $db->prepare($sql);
        
        // perform the insert
        $insertStatement->execute(array(
            ":abbreviation" => $this->abbreviation,
            ":fullName" => $this->fullName,
            ":comments" => $this->comments
        ));
        
        // capture and return the new rows autoincremented ID
        $newID = $db->lastInsertId();
        if ($newID == 0) {
            $newID = null;
        }
        
        return $newID;
    }
}