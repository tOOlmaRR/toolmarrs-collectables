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
        if ($this->getUseSPROCs()) {
            $sproc = $this->getSPROCs()["select"]["attributes"];
            $sql = "EXEC [$sproc] @ID=:id, @abbreviation=:abbreviation";
            $sqlParams = [":id" => $cardAttribute->getID(),
                ":abbreviation" => $cardAttribute->getAbbreviation()
            ];
        } else {
            // if we have an ID, query based on that alone
            if (!empty($cardAttribute->getID())) {
                $sql = "SELECT `ID`, `Abbreviation`, `FullName`, `Comments` FROM `attributes` WHERE `ID` = :id";
                $sqlParams[":id"] = $card->getID();
            }
            // if we don't have an ID, use the abbreviation
            // TODO: Handle Error/Corrected Variations, and any other edge cases where two different cards in the same set may have the same card number
            else {
                $sql = "SELECT `ID`, `Abbreviation`, `FullName`, `Comments` FROM `attributes` WHERE `Abbreviation` = :abbreviation";
                $sqlParams[":abbreviation"] = $cardAttribute->getAbbreviation();
            }
        }
        $getStatement = $db->prepare($sql);
        
        // perform the select and retrieve the data
        $getStatement->execute($sqlParams);
        $row = $getStatement->fetch();

        // build/return a business object based on the returned data
        $cardAttributeFromDatabase = null;
        if ($row != false) {
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
        if ($this->getUseSPROCs()) {
            $sproc = $this->getSPROCs()["insert"]["attributes"];
            $sql = "EXEC [$sproc] :id, :abbreviation, :fullName, :comments";
            $insertStatement = $db->prepare($sql);
            $insertStatement->bindParam(":id", $newID, \PDO::PARAM_INT, 4);
        } else {
            $sql = "INSERT INTO `attributes` (`Abbreviation`, `FullName`, `Comments`) VALUES (:abbreviation, :fullName, :comments)";
            $insertStatement = $db->prepare($sql);
        }
        $insertStatement->bindParam(":abbreviation", $this->abbreviation);
        $insertStatement->bindParam(":fullName", $this->fullName);
        $insertStatement->bindParam(":comments", $this->comments);
        
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