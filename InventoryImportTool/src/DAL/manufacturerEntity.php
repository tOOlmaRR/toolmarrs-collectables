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
        $sql = "SELECT `ID`, `Name` FROM `Manufacturer` WHERE `Name` = :name LIMIT 1";
        $getStatement = $db->prepare($sql);
        
        // perform the select and retrieve the data
        $getStatement->execute(array(":name" => $manufacturer->getName()));
        $row = $getStatement->fetch();
        $manufacturerFromDatabase = null;
        if ($row != false) {
            // build a business object based on the returned data
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
        $sql = "INSERT INTO Manufacturer (`Name`) VALUES (:name)";
        $insertStatement = $db->prepare($sql);
        
        // perform the insert
        $insertStatement->execute(array(":name" => $this->name));
        
        // capture and return the new rows autoincremented ID
        $newID = $db->lastInsertId();
        if ($newID == 0) {
            $newID = null;
        }
        return $newID;
    }
}