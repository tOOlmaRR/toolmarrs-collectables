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
        $db = $this->getDB();
        if (!is_null($db)) {
            $sql = "SELECT ID, Name FROM Manufacturer WHERE Name = :name LIMIT 1";
            //$getStatement->bindParam(":name", $manufacturer->getName());
            $getStatement = $db->prepare($sql);
            $getStatement->execute(array(":name" => $manufacturer->getName()));
            $row = $getStatement->fetch();
            if ($row == false) {
                return null;
            } else {
                $manufacturerFromDatabase = new Manufacturer;
                $manufacturerFromDatabase->setID($row["ID"]);
                $manufacturerFromDatabase->setName($row["Name"]);
                return $manufacturerFromDatabase;
            }
        } else {
            throw new \Exception("Found no database connection: ManufacturerEntity->get method");
        }
        return null; // no CardSet found
    }
    
    public function insert($manufacturer)
    {
        return 1;  // ID of inserted CardSet
    }
}