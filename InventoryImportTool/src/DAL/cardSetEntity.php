<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\DAL\iEntity;
use GeoTradingCards\InventoryImportUtility\DAL\BaseEntity;
use GeoTradingCards\InventoryImportUtility\Classes\CardSet as CardSet;

class CardSetEntity extends BaseEntity implements iEntity
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
    
    
    
    // methods
    public function get($cardSet)
    {
        return null; // no CardSet found
    }
    
    
    
    public function insert($cardSet)
    {
        return 1; // ID of inserted CardSet
    }
}