<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\Classes\CardSet as CardSet;

class CardSetEntity
{
    // private members
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
    private $manufacturerID;
    
    
    
    // constructor(s)
    public function __construct()
    {
        
    }
    
    
    
    // methods
    public function getCardSet($cardSet)
    {
        return null; // no CardSet found
    }
    
    
    
    public function insertCardSet($cardSet)
    {
        return 1; // ID of inserted CardSet
    }
    
    

}

