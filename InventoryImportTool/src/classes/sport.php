<?php
namespace GeoTradingCards\InventoryImportUtility\Classes;

class Sport
{
    // private members
    private $ID;
    private $name;
    private $leagues;
    
    
    
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
    
    public function getLeagues() : array
    {
        return $this->leagues;
    }
    
    
    
    // public setters
    public function setID(int $sportID)
    {
        $this->ID = $sportID;
    }
    
    public function setName(string $sportName)
    {
        $this->name = $sportName;
    }
    
    public function setLeagues(array $sportLeagues)
    {
        $this->leagues = $sportLeagues;
    }
}