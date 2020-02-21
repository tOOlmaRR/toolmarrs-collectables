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
        return null; // no CardSet found
    }
    
    public function insert($manufacturer)
    {
        return 1;  // ID of inserted CardSet
    }
}