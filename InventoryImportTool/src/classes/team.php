<?php
namespace GeoTradingCards\InventoryImportUtility\Classes;

use GeoTradingCards\InventoryImportUtility\Classes\League as League;

class Team
{
    // private members
    private $ID;
    private $location;
    private $name;
    private $league;
    
    
    
    // constructor(s)
    public function __construct()
    {
        
    }
    
    
    
    // public getters/accessors
    public function getID() : ?int
    {
        return $this->ID;
    }
    
    public function getLocation() : ?string
    {
        return $this->location;
    }
    
    public function getName() : string
    {
        return $this->name;
    }
    
    public function getLeague() : League
    {
        return $this->league;
    }
    
    
    
    // public setters
    public function setID(int $teamID)
    {
        $this->ID = $teamID;
    }

    public function setLocation(?string $teamLocation)
    {
        $this->location = $teamLocation;
    }
    
    public function setName(string $teamName)
    {
        $this->name = $teamName;
    }
   
    public function setLeague(League $teamLeague)
    {
        $this->league = $teamLeague;
    }
}