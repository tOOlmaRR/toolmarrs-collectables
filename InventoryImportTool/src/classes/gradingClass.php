<?php
namespace GeoTradingCards\InventoryImportUtility\Classes;

class GradingClass
{
    // private members
    private $ID;
    private $abbreviation;
    private $name;
    private $description;
    
    
    
    // constructor(s)
    public function __construct()
    {
        
    }



    // public getters/accessors
    public function getID() : int
    {
        return $this->ID;
    }
    
    public function getAbbreviation() : string
    {
        return $this->abbreviation;
    }
    
    public function getName() : string
    {
        return $this->name;
    }
    
    public function getDescription() : string
    {
        return $this->description;
    }
    
    
    
    // public setters
    public function setID(int $gradingClassID)
    {
        $this->ID = $gradingClassID;
    }
    
    public function setAbbreviation(string $gradingClassAbbreviation)
    {
        $this->abbreviation = $gradingClassAbbreviation;
    }
    
    public function setName(int $gradingClassName)
    {
        $this->name = $gradingClassName;
    }
    
    public function setDescription(int $gradingClassDescription)
    {
        $this->description = $gradingClassDescription;
    }
}