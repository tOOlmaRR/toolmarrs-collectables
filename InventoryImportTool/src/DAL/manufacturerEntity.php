<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\Classes\Manufacturer as Manufacturer;



class ManufacturerEntity
{
    // private members
    private $name;
    
    
    
    // constructor(s)
    public function __construct()
    {
    }
    
    
    
    //  methods
    public function getManufacturer($manufacturer)
    {
        return null; // no CardSet found
    }
    
    public function insertManufacturer($manufacturer)
    {
        return 1;  // ID of inserted CardSet
    }
}