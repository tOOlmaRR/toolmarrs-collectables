<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\Classes\Card;
use GeoTradingCards\InventoryImportUtility\DAL\iEntity;
use GeoTradingCards\InventoryImportUtility\DAL\BaseEntity;


class CardEntity extends BaseEntity implements iEntity
{
    // private members
    private $ID;
    private $cardNumber;
    private $title;
    private $comments;
    private $gradingModifier;
    private $cardSet_ID;
    private $subset_ID;
    private $team_ID;
    private $playerPosition_ID;



    // methods
    public function get($card)
    {
        // set up the query
        $db = $this->getDB();
        $sqlParameters = array();
        
        // if we have an ID, query based on that alone
        if (!empty($card->getID())) {
            $sql = "SELECT `ID`, `CardNumber`, `Title`, `Comments`, `GradingModifier`, `CardSet_ID`, `Subset_ID`, `Team_ID`, `PlayerPosition_ID` FROM `card` WHERE `ID` = :ID";
            $sqlParameters[":ID"] = $card->getID();
        }
        // if we don't have an ID, use the combination of CardNumber and CardSet_ID
        // TODO: Handle Error/Corrected Variations, and any other edge cases where two different cards in the same set may have the same card number
        else {
            $sql = "SELECT `ID`, `CardNumber`, `Title`, `Comments`, `GradingModifier`, `CardSet_ID`, `Subset_ID`, `Team_ID`, `PlayerPosition_ID` FROM `card` WHERE `CardNumber` = :cardNumber AND `CardSet_ID` = :cardSetID";
            $sqlParameters[":cardNumber"] = $card->getCardNumber();
            $cardSet = $card->getCardSet();
            if (empty($cardSet)) {
                return null;
            } else {
                $sqlParameters[":cardSetID"] = $cardSet->getID();
            }
        }
        $getStatement = $db->prepare($sql);
        
        // perform the select and retrieve the data
        $getStatement->execute($sqlParameters);
        $row = $getStatement->fetch();
        $cardFromDatabase = null;
        if ($row != false) {
            // build a business object based on the returned data
            $cardFromDatabase = new Card;
            $cardFromDatabase->setID($row["ID"]);
            $cardFromDatabase->setCardNumber($row["CardNumber"]);
            $cardFromDatabase->setTitle($row["Title"]);
            $cardFromDatabase->setComments($row["Comments"]);
            
            $gradingModifierFloat = floatval($row["GradingModifier"]);
            if ($gradingModifierFloat == 0) {
                $gradingModifierFloat = null;
            }
            $cardSetFromDatabase->setGradingModifier($gradingModifierFloat);
            
            $cardSet = new CardSet();
            $cardSet->setID($row["CardSet_ID"]);
            $cardFromDatabase->setCardSet($cardSet);
            
            if (!is_null($row["Subset_ID"])) {
                $subset = new Subset();
                $subset->setID($row["Subset_ID"]);
                $cardFromDatabase->setSubset($subset);
            }
            
            if (!is_null($row["Team_ID"])) {
                $nhlLeague = new League();
                $nhlLeague->setID(1);
                $nhlLeague->setName('National Hockey League');
                $nhlLeague->setAbbreviation('NHL');
                $hockeySport = new Sport();
                $hockeySport->setID(1);
                $hockeySport->setName("Hockey");
                $nhlLeague->setSport($hockeySport);
                $team = new Team();
                $team->setID($row["Team_ID"]);
                $team->setLeague($nhlLeague);
            }
            
            if (!is_null($row["PlayerPosition_ID"])) {
                $position = new PlayerPosition();
                $position->setID($row["PlayerPosition_ID"]);
            }
        }
        return $cardFromDatabase;
    }


    
    public function insert($card)
    {
        $newID = null;
        
        // build up this entity object with the given business object
        $this->cardNumber = $card->getCardNumber();
        $this->title = $card->getTitle();
        $this->comments = $card->getComments();
        $this->gradingModifier = $card->getGradingModifier();
        $this->cardSet_ID = $card->getCardSet()->getID();
        $this->subset_ID = !is_null($card->getSubset()) ? $card->getSubset()->getID() : null;
        $this->team_ID = !is_null($card->getTeam()) ? $card->getTeam()->getID() : null;
        $this->playerPosition_ID = !is_null($card->getPlayerPosition()) ? $card->getPlayerPosition()->getID() : null;
        
        // set up the query
        $db = $this->getDB();
        $sql = "INSERT INTO `card` (`CardNumber`, `Title`, `Comments`, `GradingModifier`, `CardSet_ID`, `Subset_ID`, `Team_ID`, `PlayerPosition_ID`) VALUES (:cardNumber, :title, :comments, :gradingModifier, :cardSetID, :subsetID, :teamID, :positionID)";
        $insertStatement = $db->prepare($sql);
        
        // perform the insert
        $insertStatement->execute(array(
            ":cardNumber" => $this->cardNumber,
            ":title" => $this->title,
            ":comments" => $this->comments,
            ":gradingModifier" => $this->gradingModifier,
            ":cardSetID" => $this->cardSet_ID,
            ":subsetID" => $this->subset_ID,
            ":teamID" => $this->team_ID,
            ":positionID" => $this->playerPosition_ID,
        ));
        
        // capture and return the new rows autoincremented ID
        $newID = $db->lastInsertId();
        if ($newID == 0) {
            $newID = null;
        }
        
        return $newID;
    }
}