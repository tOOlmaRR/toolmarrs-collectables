<?php
namespace GeoTradingCards\InventoryImportUtility\Classes;

use GeoTradingCards\InventoryImportUtility\Classes\Manufacturer as Manufacturer;

class CardSet
{
    // private members
    private $ID;
    private $baseSetName;
    private $insertSetName;
    private $fullName;
    private $season;
    private $size;
    private $rarity;
    private $gradingModifier;
    private $comments;
    private $lastBeckettUpdate;
    private $lastInventoryCheck;
    private $manufacturer;
    private $cards;
    private $subsets;
    
    
    
    // constructor(s)
    public function __construct()
    {
        
    }
    
    
    // public getters/accessors
    public function getID() : int
    {
        return $this->ID;
    }
    
    public function getBaseSetName() : string
    {
        return $this->baseSetName;
    }
    
    public function getInsertSetName() : string
    {
        return $this->insertSetName ?? "";
    }
    
    public function getFullName() : string
    {
        return $this->fullName;
    }
    
    public function getSeason() : string
    {
        return $this->season;
    }
    
    public function getSize() : ?int
    {
        return $this->size;
    }
    
    public function getRarity() : string
    {
        return $this->rarity ?? "";
    }
    
    public function getGradingModifier() : ?float
    {
        return $this->gradingModifier;
    }
    
    public function getComments() : string
    {
        return $this->comments ?? "";
    }
    
    public function getLastBeckettUpdate() : ?string
    {
        return $this->lastBeckettUpdate;
    }
    
    public function getLastInventoryCheck() : ?string
    {
        return $this->lastInventoryCheck;
    }
    
    public function getManufacturer() : Manufacturer
    {
        return $this->manufacturer;
    }
    
    public function getCards() : ?array
    {
        return $this->cards;
    }
    
    public function getSubsets() : ?array
    {
        return $this->subsets;
    }
    
    
    
    // public setters
    public function setID(int $cardSetID)
    {
        $this->ID = $cardSetID;
    }

    public function setBaseSetName(string $cardSetBaseSetName)
    {
        $this->baseSetName = $cardSetBaseSetName;
    }

    public function setInsertSetName(string $cardSetInsertSetName)
    {
        $this->insertSetName = $cardSetInsertSetName;
    }

    public function setFullName(string $cardSetFullName)
    {
        $this->fullName = $cardSetFullName;
    }

    public function setSeason(string $cardSetSeason)
    {
        $this->season = $cardSetSeason;
    }

    public function setSize(?int $cardSetSize)
    {
        $this->size = $cardSetSize;
    }

    public function setRarity(string $cardSetRarity)
    {
        $this->rarity = $cardSetRarity;
    }

    public function setGradingModifier(?float $cardSetGradingModifier)
    {
        $this->gradingModifier = $cardSetGradingModifier;
    }

    public function setComments(string $cardSetComments)
    {
        $this->comments = $cardSetComments;
    }

    public function setLastBeckettUpdate(?string $cardSetLastBeckettUpdate)
    {
        $this->lastBeckettUpdate = $cardSetLastBeckettUpdate;
    }

    public function setLastInventoryCheck(?string $cardSetLastInventoryCheck)
    {
        $this->lastInventoryCheck = $cardSetLastInventoryCheck;
    }

    public function setManufacturer(Manufacturer $cardSetManufacturer)
    {
        $this->manufacturer = $cardSetManufacturer;
    }
    
    public function setCards(array $cardSetCards)
    {
        $this->cards = $cardSetCards;    
    }
    
    public function setSubsets(array $cardSetSubsets)
    {
        $this->subsets = $cardSetSubsets;
    }
}