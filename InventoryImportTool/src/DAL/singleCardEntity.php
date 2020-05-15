<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\classes\SingleCard;
use GeoTradingCards\InventoryImportUtility\DAL\iEntity;
use GeoTradingCards\InventoryImportUtility\DAL\BaseEntity;

class SingleCardEntity extends BaseEntity implements iEntity
{
    // private members
    private $ID;
    private $sellPrice;
    private $cost;
    private $priceSoldFor;
    private $rarity;
    private $status;
    private $comments;
    private $card_ID;
    
    
    
    // methods
    public function get($singleCard)
    {
        // We should never have to call this function
        throw new Exception("SingleCardEntity->get() should never be called");
    }
    
    public function insert($singleCard)
    {
        // build up this entity object with the given business object
        $this->ID = $singleCard->getID();
        $this->sellPrice = $singleCard->getSellPrice();
        $this->cost = $singleCard->getCost();
        $this->priceSoldFor = $singleCard->getPriceSoldFor();
        $this->rarity = $singleCard->getRarity();
        $this->status = $singleCard->getStatus();
        $this->comments = $singleCard->getComments();
        $this->card_ID = $singleCard->getCard()->getID();
        
        // set up the query
        $db = $this->getDB();
        if ($this->getUseSPROCs()) {
            $sproc = $this->getSPROCs()["insert"]["singlecard"];
            $sql = "EXEC [$sproc] :id, :sellPrice, :cost, :priceSoldFor, :rarity, :status, :comments, :cardID";
            $insertStatement = $db->prepare($sql);
        } else {
            $sql = "INSERT INTO `singlecard` (`ID`, `SellPrice`, `Cost`, `PriceSoldFor`, `Rarity`, `Status`, `Comments`, `Card_ID`) 
                VALUES (:id, :sellPrice, :cost, :priceSoldFor, :rarity, :status, :comments, :cardID)";
            $insertStatement = $db->prepare($sql);
        }
        $insertStatement->bindParam(":id", $this->ID);
        $insertStatement->bindParam(":sellPrice", $this->sellPrice);
        $insertStatement->bindParam(":cost", $this->cost);
        $insertStatement->bindParam(":priceSoldFor", $this->priceSoldFor);
        $insertStatement->bindParam(":rarity", $this->rarity);
        $insertStatement->bindParam(":status", $this->status);
        $insertStatement->bindParam(":comments", $this->comments);
        $insertStatement->bindParam(":cardID", $this->card_ID);

        // perform the insert
        $insertStatement->execute();
    }
}