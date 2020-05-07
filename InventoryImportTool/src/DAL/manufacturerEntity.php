<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\DAL\iEntity;
use GeoTradingCards\InventoryImportUtility\Classes\Manufacturer;

class ManufacturerEntity extends BaseEntity implements iEntity
{
    // private members
    private $name;
    
    
    
    //  methods
    public function get($manufacturer)
    {
        // set up the query
        $db = $this->getDB();
        if ($this->getUseSPROCs()) {
            $sproc = $this->getSPROCs()["select"]["manufacturer"];
            $sql = "EXEC [$sproc] @ID=:id, @name=:name";
            $sqlParams = [":id" => $manufacturer->getID(), ":name" => $manufacturer->getName()];
        } else {
            $sql = "SELECT `ID`, `Name` FROM `manufacturer` WHERE `Name` = :name LIMIT 1";
            $sqlParams = [":name" => $manufacturer->getName()];
        }
        $getStatement = $db->prepare($sql);
        
        // perform the select and retrieve the data
        $getStatement->execute($sqlParams);
        $row = $getStatement->fetch();
        $manufacturerFromDatabase = null;

        // build/return a business object based on the returned data
        if ($row != false) {
            $manufacturerFromDatabase = new Manufacturer;
            $manufacturerFromDatabase->setID(intval($row["ID"]));
            $manufacturerFromDatabase->setName($row["Name"]);
        }
        return $manufacturerFromDatabase;
    }
    
    public function insert($manufacturer)
    {
        // build up this entity object with the given business object
        $this->name = $manufacturer->getName();
        
        // set up the query
        $db = $this->getDB();
        if ($this->getUseSPROCs()) {
            $sproc = $this->getSPROCs()["insert"]["manufacturer"];
            $sql = "EXEC [$sproc] :id, :name";
            $insertStatement = $db->prepare($sql);
            $insertStatement->bindParam(":id", $newID, \PDO::PARAM_INT, 4);
        } else {
            $sql = "INSERT INTO manufacturer (`Name`) VALUES (:name)";
            $insertStatement = $db->prepare($sql);
        }
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