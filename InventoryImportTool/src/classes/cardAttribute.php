<?php
namespace GeoTradingCards\InventoryImportUtility\Classes;

class CardAttribute
{
    // private members
    private $ID;
    private $abbreviation;
    private $fullName;
    private $comments;
    
    
    
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
    
    public function getFullName() : ?string
    {
        return $this->fullName;
    }
    
    public function getComments() : ?string
    {
        return $this->comments;
    }
    
    
    
    // public setters
    public function setID(int $cardAttributeID)
    {
        $this->ID = $cardAttributeID;
    }
    
    public function setAbbreviation(?string $cardAttributeAbbreviation)
    {
        $this->abbreviation = $cardAttributeAbbreviation;
    }
    
    public function setFullName(?string $cardAttributeFullName)
    {
        $this->fullName = $cardAttributeFullName;
    }
    
    public function setComments(?string $cardAttributeComments)
    {
        $this->comments = $cardAttributeComments;
    }
}