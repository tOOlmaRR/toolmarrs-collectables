<?php
namespace GeoTradingCards\InventoryImportUtility\Classes;

class Subset
{
    // private members
    private $ID;
    private $name;
    private $size;
    private $gradingModifier;
    private $cardSet;
    private $cards;
    
    // constructor(s)
    public function __construct()
    {
        
    }
    
    
    
    // public getters/accessors
    public function getID() : ?int
    {
        return $this->ID;
    }
    
    public function getName() : ?string
    {
        return $this->name;
    }
    
    public function getSize() : ?int
    {
        return $this->size;
    }
    
    public function getGradingModifier() : ?float
    {
        return $this->gradingModifier;
    }
    
    public function getCardSet() : ?CardSet
    {
        return $this->cardSet;
    }
    
    public function getCards() : ?array
    {
        return $this->cards;
    }
    
    
    
    // public setters
    public function setID(int $subsetID)
    {
        $this->ID = $subsetID;
    }
    
    public function setName(?string $subsetName)
    {
        $this->name = $subsetName;
    }
    
    public function setSize(?int $subsetSize)
    {
        $this->size = $subsetSize;
    }
    
    public function setGradingModifier(?float $subsetGradingModifier)
    {
        $this->gradingModifier = $subsetGradingModifier;
    }
    
    public function setCardSet(?CardSet $cardSet)
    {
        $this->cardSet = $cardSet;
    }
    
    public function setCards(?array $subsetCards)
    {
        $this->cards = $subsetCards;
    }
}