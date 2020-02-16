<?php
namespace GeoTradingCards\InventoryImportUtility\Classes;

use GeoTradingCards\InventoryImportUtility\Classes\CardSet as CardSet;
use GeoTradingCards\InventoryImportUtility\Classes\Subset as Subset;
use GeoTradingCards\InventoryImportUtility\Classes\Team as Team;
use GeoTradingCards\InventoryImportUtility\Classes\PlayerPosition as PlayerPosition;
use GeoTradingCards\InventoryImportUtility\Classes\CardValue as CardValue;
use GeoTradingCards\InventoryImportUtility\Classes\CardAttribute as CardAttribute;
use GeoTradingCards\InventoryImportUtility\Classes\SingleCard as SingleCard;

class Card
{
    // private members
    private $ID;
    private $cardNumber;
    private $title;
    private $comments;
    private $gradingModifier;
    private $cardSet;
    private $subset;
    private $team;
    private $playerPosition;
    private $cardValue;
    private $attributes;
    private $singleCards;

    
    
    // constructor(s)
    public function __construct()
    {
        
    }
    
    
    
    // public getters/accessors
    public function getID() : int
    {
        return $this->ID;
    }
    
    public function getCardNumber() : string
    {
        return $this->cardNumber;
    }
    
    public function getTitle() : string
    {
        return $this->title;
    }
    
    public function getComments() : string
    {
        return $this->comments;
    }
    
    public function getGradingModifier() : float
    {
        return $this->gradingModifier;
    }
    
    public function getCardSet() : CardSet
    {
        return $this->cardSet;
    }
    
    public function getSubset() : Subset
    {
        return $this->subset;
    }
    
    public function getTeam() : Team
    {
        return $this->team;
    }
    
    public function getPlayerPosition() : PlayerPosition
    {
        return $this->playerPosition;
    }
    
    public function getCardValue() : CardValue
    {
        return $this->cardValue;
    }
    
    public function getAttributes() : array
    {
        return $this->attributes;
    }
    
    public function getSingleCards() : array
    {
        return $this->singleCards;
    }
    
    
    
    // public setters
    public function setID(int $cardID)
    {
        $this->ID = $cardID;
    }
    
    public function setCardNumber(string $cardNumber)
    {
        $this->cardNumber = $cardNumber;
    }
   
    public function setTitle(string $cardTitle)
    {
        $this->title = $cardTitle;
    }
    
    public function setComments(string $cardComments)
    {
        $this->comments = $cardComments;
    }
    
    public function setGradingModifier(float $cardGradingModifier)
    {
        $this->gradingModifier = $cardGradingModifier;
    }
    
    public function setCardSet(CardSet $cardSet)
    {
        $this->cardSet = $cardSet;
    }
    
    public function setSubset(Subset $cardSubset)
    {
        $this->subset = $cardSubset;
    }
    
    public function setTeam(Team $cardTeam)
    {
        $this->team = $cardTeam;
    }
    
    public function setPlayerPosition(PlayerPosition $cardPlayerPosition)
    {
        $this->playerPosition = $cardPlayerPosition;
    }
    
    public function setCardValue(CardValue $cardValue)
    {
        $this->cardValue = $cardValue;
    }
    
    public function setAttributes(array $cardAttributes)
    {
        $this->attributes = $cardAttributes;
    }
    
    public function setSingleCards(array $cardSingleCards)
    {
        $this->singleCards = $cardSingleCards;
    }
}