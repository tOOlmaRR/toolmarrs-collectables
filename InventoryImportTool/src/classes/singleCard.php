<?php
namespace GeoTradingCards\InventoryImportUtility\Classes;

use GeoTradingCards\InventoryImportUtility\Classes\Card as Card;
use GeoTradingCards\InventoryImportUtility\Classes\SingleCardGrading as SingleCardGrading;

class SingleCard
{
    // private members
    private $ID;
    private $sellPrice;
    private $cost;
    private $priceSoldFor;
    private $rarity;
    private $status;
    private $comments;
    private $card;
    private $singleCardGrading;
    
    
    
    // constructor(s)
    public function __construct()
    {
        
    }



    // public getters/accessors
    public function getID() : string
    {
        return $this->ID;
    }
    
    public function getSellPrice() : ?float
    {
        return $this->sellPrice;
    }
    
    public function getCost() : float
    {
        return $this->cost;
    }
    
    public function getPriceSoldFor() : float
    {
        return $this->priceSoldFor;
    }
    
    public function getRarity() : string
    {
        return $this->rarity;
    }
    
    public function getStatus() : string
    {
        return $this->status;
    }
    
    public function getComments() : string
    {
        return $this->comments;
    }
    
    public function getCard() : Card
    {
        return $this->card;
    }
    
    public function getSingleCardGrading() : SingleCardGrading
    {
        return $this->singleCardGrading;
    }
    
    
    
    // public setters
    public function setID(string $singleCardID)
    {
        $this->ID = $singleCardID;
    }
    
    public function setSellPrice(?float $singleCardSellPrice)
    {
        $this->sellPrice = $singleCardSellPrice;
    }
    
    public function setCost(float $singleCardCost)
    {
        $this->cost = $singleCardCost;
    }
    
    public function setPriceSoldFor(float $singlePriceSoldFor)
    {
        $this->priceSoldFor = $singlePriceSoldFor;
    }
    
    public function setRarity(string $singleCardRarity)
    {
        $this->rarity = $singleCardRarity;
    }
    
    public function setStatus(string $singleCardStatus)
    {
        $this->status = $singleCardStatus;
    }
    
    public function setComments(string $singleCardComments)
    {
        $this->comments = $singleCardComments;
    }
    
    public function setCard(Card $card)
    {
        $this->card = $card;
    }
    
    public function setSingleCardGrading(SingleCardGrading $singleCardGrading)
    {
        $this->singleCardGrading = $singleCardGrading;
    }
}