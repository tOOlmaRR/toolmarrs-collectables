<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\DAL\iEntity;
use GeoTradingCards\InventoryImportUtility\DAL\BaseEntity;

class CardEntity extends BaseEntity implements iEntity
{
    public function get($card)
    {
        //TODO: Complete this when I need it
        
        // set up the query
        /*$db = $this->getDB();
        $sqlParamaters = array();
        
        // if we have an ID, query based on that alone
        if (!empty($card->getID())) {
            $sql = "SELECT `ID`, `CardNumber`, `Title`, `Comments`, `GradingModifier`, `CardSet_ID`, `Subset_ID`, `Team_ID`, `PlayerPosition_ID` FROM `Card` WHERE `ID` = :ID";
            $sqlParamaters[] = ":ID" => $card->getID();
        }
        // if we don't have an ID, use the combination of CardNumnber and CardSet_ID
        else {
            $sql = "SELECT `ID`, `CardNumber`, `Title`, `Comments`, `GradingModifier`, `CardSet_ID`, `Subset_ID`, `Team_ID`, `PlayerPosition_ID` FROM `Card` WHERE `CardNumber` = :cardNumber AND `CardSet_ID` = :cardSetID";
            $sqlParamaters[] = ":cardNumber" => $card->getCardNumber();
            $cardSet = $card->getCardSet();
            if (empty($cardSet)) {
                return null;
            } else {
                $sqlParamaters[] = ":cardSetID" => $cardSet->getID();
            }
        }
        $getStatement = $db->prepare($sql);
        
        // perform the select and retrieve the data
        $getStatement->execute($sqlParamaters);
        $row = $getStatement->fetch();
        $cardFromDatabase = null;
        if ($row != false) {
            return null;
        } else {
            // build and return an object
            
        }
        return $cardFromDatabase*/
        return null;
    }
    
    public function insert($objectToInsert)
    {
        return null;
    }
}