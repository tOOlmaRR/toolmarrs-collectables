<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\Classes\Card;
use GeoTradingCards\InventoryImportUtility\Classes\CardSet;
use GeoTradingCards\InventoryImportUtility\Classes\Subset;
use GeoTradingCards\InventoryImportUtility\Classes\League;
use GeoTradingCards\InventoryImportUtility\Classes\Sport;
use GeoTradingCards\InventoryImportUtility\Classes\Team;
use GeoTradingCards\InventoryImportUtility\Classes\PlayerPosition;
use GeoTradingCards\InventoryImportUtility\DAL\iEntity;
use GeoTradingCards\InventoryImportUtility\DAL\BaseEntity;



class CardEntity extends BaseEntity implements iEntity
{
    // private members - DB Columns
    private $ID;
    private $cardNumber;
    private $title;
    private $comments;
    private $gradingModifier;

    // private members - foreign keys
    private $cardSet_ID;
    private $subset_ID;
    private $team_ID;
    private $playerPosition_ID;
    private $sport_ID;



    // methods
    public function get($card)
    {
        // set up the query
        $db = $this->getDB();
        if ($this->getUseSPROCs()) {
            $sproc = $this->getSPROCs()["select"]["card"];
            $sql = "EXEC [$sproc] @ID=:id, @cardNumber=:cardNumber, @cardTitle=:title, @cardSet_ID=:cardSetID";
            $sqlParams = [":id" => $card->getID(),
                ":cardNumber" => $card->getCardNumber(),
                ":title" => $card->getTitle(),
                ":cardSetID" => $card->getCardSet()->getID()
            ];
        } else {
            // if we have an ID, query based on that alone
            if (!empty($card->getID())) {
                $sql = "SELECT `ID`, `CardNumber`, `Title`, `Comments`, `GradingModifier`, `CardSet_ID`, `Subset_ID`, `Team_ID`, `PlayerPosition_ID`, `Sport_ID` FROM `card` WHERE `ID` = :id";
                $sqlParams[":id"] = $card->getID();
            }
            // if we don't have an ID, use the combination of CardNumber, Title, and CardSet_ID
            // TODO: Handle Error/Corrected Variations, and any other edge cases where two different cards in the same set may have the same card number            
            else {
                $sql = "SELECT `ID`, `CardNumber`, `Title`, `Comments`, `GradingModifier`, `CardSet_ID`, `Subset_ID`, `Team_ID`, `PlayerPosition_ID`, `Sport_ID` FROM `card` WHERE `CardNumber` = :cardNumber AND `CardSet_ID` = :cardSetID AND `Title` = :title";
                $sqlParams[":cardNumber"] = $card->getCardNumber();
                $cardSet = $card->getCardSet();
                if (empty($cardSet)) {
                    return null;
                } else {
                    $sqlParams[":cardSetID"] = $cardSet->getID();
                }
            }
        }
        $getStatement = $db->prepare($sql);
        
        // perform the select and retrieve the data
        $getStatement->execute($sqlParams);
        $row = $getStatement->fetch();
        
        // build/return a business object based on the returned data
        $cardFromDatabase = null;
        if ($row != false) {
            $cardFromDatabase = new Card;
            $cardFromDatabase->setID($row["ID"]);
            $cardFromDatabase->setCardNumber($row["CardNumber"]);
            $cardFromDatabase->setTitle($row["Title"]);
            $cardFromDatabase->setComments($row["Comments"]);
            
            $gradingModifierFloat = floatval($row["GradingModifier"]);
            if ($gradingModifierFloat == 0) {
                $gradingModifierFloat = null;
            }
            $cardFromDatabase->setGradingModifier($gradingModifierFloat);
            
            $cardSet = new CardSet();
            $cardSet->setID($row["CardSet_ID"]);
            $cardFromDatabase->setCardSet($cardSet);
            
            if (!is_null($row["Subset_ID"])) {
                $subset = new Subset();
                $subset->setID($row["Subset_ID"]);
                $cardFromDatabase->setSubset($subset);
            }
            
            if (!is_null($row["Team_ID"])) {
                // assume that the team belongs to the NHL League and the Hockey sport
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
                $cardFromDatabase->setTeam($team);
            }
            
            if (!is_null($row["PlayerPosition_ID"])) {
                $position = new PlayerPosition();
                $position->setID($row["PlayerPosition_ID"]);
            }
            
            $hockeySport = new Sport();
            if (!is_null($row["Sport_ID"] && $row["Sport_ID"] == 1)) {
                $hockeySport->setID(1);
                $hockeySport->setName("Hockey");
            } else {
                $hockeySport->setID($row["Sport_ID"]);
            }
            $cardFromDatabase->setSport($hockeySport);
            
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
        $this->sport_ID = 1; // assume all cards we are inserting are Hockey cards
        
        // set up the query
        $db = $this->getDB();
        if ($this->getUseSPROCs()) {
            $sproc = $this->getSPROCs()["insert"]["card"];
            $sql = "EXEC [$sproc] :id, :cardNumber, :title, :comments, :gradingModifier, :cardSetID, :subsetID, :teamID, :positionID, :sportID";
            $insertStatement = $db->prepare($sql);
            $insertStatement->bindParam(":id", $newID, \PDO::PARAM_INT, 10);
        } else {
            $sql = "INSERT INTO `card` (`CardNumber`, `Title`, `Comments`, `GradingModifier`, `CardSet_ID`, `Subset_ID`, `Team_ID`, `PlayerPosition_ID`, `Sport_ID`) VALUES (:cardNumber, :title, :comments, :gradingModifier, :cardSetID, :subsetID, :teamID, :positionID, :sportID)";
            $insertStatement = $db->prepare($sql);
        }
        $insertStatement->bindParam(":cardNumber", $this->cardNumber);
        $insertStatement->bindParam(":title", $this->title);
        $insertStatement->bindParam(":comments", $this->comments);
        $insertStatement->bindParam(":gradingModifier", $this->gradingModifier);
        $insertStatement->bindParam(":cardSetID", $this->cardSet_ID);
        $insertStatement->bindParam(":subsetID", $this->subset_ID);
        $insertStatement->bindParam(":teamID", $this->team_ID);
        $insertStatement->bindParam(":positionID", $this->playerPosition_ID);
        $insertStatement->bindParam(":sportID", $this->sport_ID);

        // perform the insert
        $insertStatement->execute();

        // capture and return the new rows autoincremented ID
        if (!$this->getUseSPROCs()) {
            $newID = $db->lastInsertId();
        }
        if ($newID == 0) {
            $newID = null;
        }
        
        return $newID;
    }
}