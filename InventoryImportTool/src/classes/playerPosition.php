<?php
namespace GeoTradingCards\InventoryImportUtility\Classes;

class PlayerPosition
{
    // private members
    private $ID;
    private $abbreviation;
    private $name;
    
    
    
    // constructor(s)
    public function __construct()
    {
        
    }
    
    
    
    // public getters/accessors
    public function getID() : ?int
    {
        return $this->ID;
    }
    
    public function getAbbreviation() : ?string
    {
        return $this->abbreviation;
    }
    
    public function getName() : ?string
    {
        return $this->name;
    }
    
    
    
    // public setters
    public function setID(int $playerPositionID)
    {
        $this->ID = $playerPositionID;
    }
    
    public function setAbbreviation(?string $playerPositionAbbreviation)
    {
        $this->abbreviation = $playerPositionAbbreviation;
    }
    
    public function setName(?string $playerPositionName)
    {
        $this->name = $playerPositionName;
    }
}