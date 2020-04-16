<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\classes\CardValue;
use GeoTradingCards\InventoryImportUtility\DAL\iEntity;
use GeoTradingCards\InventoryImportUtility\DAL\BaseEntity;

class CardValueEntity extends BaseEntity implements iEntity
{
    // private members
    private $ID;
    private $lowValue;
    private $highValue;
    private $lastAppraisal;
    private $lastAppraisalSource;
    private $card_ID;




    // methods
    public function get($cardValue)
    {
        // We should never have to call this function
        throw new Exception("CardHasAttributeEntity->get() should never be called");
    }
    
    public function insert($objectToInsert)
    {
        $newID = null;

        // build up this entity object with the given business object
        $this->ID = $objectToInsert->getID();
        $this->lowValue = $objectToInsert->getLowValue();
        $this->highValue = $objectToInsert->getHighValue();
        $this->lastAppraisal = $objectToInsert->getLastAppraisal();
        $this->lastAppraisalSource = $objectToInsert->getLastAppraisalSource();
        $this->card_ID = $objectToInsert->getCard()->getID();
        
        // set up the query
        $db = $this->getDB();
        $sql = "INSERT INTO `cardvalue` (`LowValue`, `HighValue`, `LastAppraisal`, `LastAppraisalSource`, `Card_ID`) VALUES (:lowValue, :highValue, :lastAppraisal, :lastAppraisalSource, :cardID)";
        $insertStatement = $db->prepare($sql);
        
        // perform the insert
        $insertStatement->execute(array(
            ":lowValue" => $this->lowValue,
            ":highValue" => $this->highValue,
            ":lastAppraisal" => $this->lastAppraisal,
            ":lastAppraisalSource" => $this->lastAppraisalSource,
            ":cardID" => $this->card_ID
        ));
        
        // capture and return the new rows autoincremented ID
        $newID = $db->lastInsertId();
        if ($newID == 0) {
            $newID = null;
        }

        return $newID;
    }
}