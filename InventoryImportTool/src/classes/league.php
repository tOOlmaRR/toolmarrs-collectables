<?php
namespace GeoTradingCards\InventoryImportUtility\Classes;

use GeoTradingCards\InventoryImportUtility\Classes\Sport as Sport;

class League
{
    // private members
    private $ID;
    private $abbreviation;
    private $name;
    private $sport;
    private $teams;
    
    
    
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
    
    public function getSport() : Sport
    {
        return $this->sport;
    }
    
    public function getTeams() : array
    {
        return $this->teams;
    }
    
    
    
    // public setters
    public function setID(int $leagueID)
    {
        $this->ID = $leagueID;
    }
    
    public function setAbbreviation(string $leagueAbbreviation)
    {
        $this->abbreviation = $leagueAbbreviation;
    }
    
    public function setName(string $leagueName)
    {
        $this->name = $leagueName;
    }
    
    public function setSport(Sport $leagueSport)
    {
        $this->sport = $leagueSport;
    }
    
    public function setTeams(array $leagueTeams)
    {
        $this->teams = $leagueTeams;
    }
}