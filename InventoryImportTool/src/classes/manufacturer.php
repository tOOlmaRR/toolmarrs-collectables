<?php
namespace GeoTradingCards\InventoryImportUtility\Classes;

class Manufacturer
{
    // private members
    private $ID;
    private $name;
    
    
    
    // constructor(s)
    public function __construct()
    {
        
    }
    
    
    
    // public getters/accessors
    public function getID() : int
    {
        return $this->ID;
    }
    
    public function getName() : string
    {
        return $this->name;
    }
    
    
    
    // public setters
    public function setID(int $manufacturerID)
    {
        $this->ID = $manufacturerID;
    }

    public function setName(string $manufacturerName)
    {
        $this->name = $manufacturerName;
    }
}