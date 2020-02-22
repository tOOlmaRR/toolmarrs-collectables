<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\DAL\iEntity;
use GeoTradingCards\InventoryImportUtility\Classes\Manufacturer as Manufacturer;

class ManufacturerEntity extends BaseEntity implements iEntity
{
    // private members
    private $name;
    
    
    
    //  methods
    public function get($manufacturer)
    {
        $manufacturerFromDatabase = null;
        $db = $this->getDB();
        $sql = "SELECT ID, Name FROM Manufacturer WHERE Name = :name LIMIT 1";
        $getStatement = $db->prepare($sql);
        $getStatement->execute(array(":name" => $manufacturer->getName()));
        $row = $getStatement->fetch();
        if ($row == false) {
            $manufacturerFromDatabase = null;
        } else {
            $manufacturerFromDatabase = new Manufacturer;
            $manufacturerFromDatabase->setID(intval($row["ID"]));
            $manufacturerFromDatabase->setName($row["Name"]);
        }
        return $manufacturerFromDatabase;
    }
    
    public function insert($manufacturer)
    {
        $newID = null;
        $db = $this->getDB();
        $this->name = $manufacturer->getName();
        $sql = "INSERT INTO Manufacturer (`Name`) VALUES (:name)";
        $insertStatement = $db->prepare($sql);
        $insertStatement->execute(array(":name" => $this->name));
        $newID = $db->lastInsertId();
        if ($newID == 0) {
            $newID = null;
        }
        return $newID;
    }
}