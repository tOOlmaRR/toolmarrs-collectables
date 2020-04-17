<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\classes\Team;
use GeoTradingCards\InventoryImportUtility\classes\League;
use GeoTradingCards\InventoryImportUtility\classes\Sport;
use GeoTradingCards\InventoryImportUtility\DAL\iEntity;
use GeoTradingCards\InventoryImportUtility\DAL\BaseEntity;

class TeamEntity extends BaseEntity implements iEntity
{
    // private members
    private $ID;
    private $location;
    private $name;
    private $league_ID;



    // methods
    public function get($team)
    {
        // set up the query
        $db = $this->getDB();
        $sqlParameters = array();
        
        // if we have an ID, query based on that alone
        if (!empty($team->getID())) {
            $sql = "SELECT `ID`, `Location`, `Name`, `League_ID` FROM `team` WHERE `ID` = :ID";
            $sqlParameters[":ID"] = $team->getID();
        }
        
        // if we don't have an ID, use the Name of the team
        // TODO: Take League into consideration - for now we assume that the first result we get is correct
        else {
            $sql = "SELECT `ID`, `Location`, `Name`, `League_ID` FROM `team` WHERE `Name` = :name";
            $sqlParameters[":name"] = $team->getName();
        }
        $getStatement = $db->prepare($sql);
        
        // perform the select and retrieve the data
        $getStatement->execute($sqlParameters);
        $row = $getStatement->fetch();
        $teamFromDatabase = null;
        if ($row != false) {
            // build a business object based on the returned data
            $teamFromDatabase = new Team;
            $teamFromDatabase->setID($row["ID"]);
            $teamFromDatabase->setLocation($row["Location"]);
            $teamFromDatabase->setName($row["Name"]);
            
            // TODO: Support Leagues other than the NHL, and support cases where NHL isn't ID=1
            $nhlLeague = new League();
            $nhlLeague->setID(1);
            $nhlLeague->setName('National Hockey League');
            $nhlLeague->setAbbreviation('NHL');
            $hockeySport = new Sport();
            $hockeySport->setID(1);
            $hockeySport->setName("Hockey");
            $nhlLeague->setSport($hockeySport);
            $teamFromDatabase->setLeague($nhlLeague);
        }
        return $teamFromDatabase;
    }
    
    public function insert($team)
    {
        $newID = null;
        
        // build up this entity object with the given business object
        $this->ID = $team->getID();
        $this->location = $team->getLocation();
        $this->name = $team->getName();
        
        // TODO: Support Leagues other than the NHL, and support cases where NHL isn't ID=1
        $this->league_ID = $team->getLeague()->getID();
        
        // set up the query
        $db = $this->getDB();
        $sql = "INSERT INTO `team` (`Location`, `Name`, `League_ID`) VALUES (:location, :name, :leagueID)";
        $insertStatement = $db->prepare($sql);
        
        // perform the insert
        $insertStatement->execute(array(
            ":location" => $this->location,
            ":name" => $this->name,
            ":leagueID" => $this->league_ID
        ));
        
        // capture and return the new rows autoincremented ID
        $newID = $db->lastInsertId();
        if ($newID == 0) {
            $newID = null;
        }
        
        return $newID;
    }
}