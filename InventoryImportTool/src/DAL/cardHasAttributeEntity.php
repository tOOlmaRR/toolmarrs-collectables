<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\DAL\iEntity;
use GeoTradingCards\InventoryImportUtility\DAL\BaseEntity;

class CardHasAttributeEntity extends BaseEntity implements iEntity
{
    // private members
    private $card_ID;
    private $attributes_ID;
    
    
    
    // methods
    public function get($cardHasAttributes)
    {
        // We should never have to call this function
        throw new Exception("CardHasAttributeEntity->get() should never be called");
    }
    
    public function insert($cardHasAttributes)
    {
        // build up this entity object with the given business object
        $this->card_ID = $cardHasAttributes->cardID;
        $this->attributes_ID = $cardHasAttributes->attributeID;

        // set up the query
        $db = $this->getDB();
        $sql = "INSERT INTO `card_has_attributes` (`Card_ID`, `Attributes_ID`) VALUES (:cardID, :attributeID)";
        $insertStatement = $db->prepare($sql);
        
        // perform the insert
        $insertStatement->execute(array(
            ":cardID" => $this->card_ID,
            ":attributeID" => $this->attributes_ID
        ));
        
        return true;
    }
}