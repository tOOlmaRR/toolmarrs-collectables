<?php
namespace GeoTradingCards\InventoryImportUtility\Classes;

class CardValue
{
    // private members
    private $ID;
    private $lowValue;
    private $highValue;
    private $lastAppraisal;
    private $lastAppraisalSource;
    
    
    
    // constructor(s)
    public function __construct()
    {
        
    }
    
    
    
    // public getters/accessors
    public function getID() : int
    {
        return $this->ID;
    }

    public function getLowValue() : ?float
    {
        return $this->lowValue;
    }
    
    public function getHighValue() : ?float
    {
        return $this->highValue;
    }
    
    public function getLastAppraisal() : ?string
    {
        return $this->lastAppraisal;
    }
    
    public function getLastAppraisalSource() : ?string
    {
        return $this->lastAppraisalSource;
    }
    
    
    
    // public setters
    public function setID(int $cardValueID)
    {
        $this->ID = $cardValueID;
    }
    
    public function setLowValue(?float $cardValueLowValue)
    {
        $this->lowValue = $cardValueLowValue;
    }
    
    public function setHighValue(?float $cardValueHighValue)
    {
        $this->highValue = $cardValueHighValue;
    }
    
    public function setLastAppraisal(?string $cardValueLastAppraisal)
    {
        $this->lastAppraisal = $cardValueLastAppraisal;
    }
    
    public function setLastAppraisalSource(?string $cardValueLastAppraisalSource)
    {
        $this->lastAppraisalSource = $cardValueLastAppraisalSource;
    }
}