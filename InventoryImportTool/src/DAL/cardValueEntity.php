<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\classes\CardValue;
use GeoTradingCards\InventoryImportUtility\DAL\iEntity;
use GeoTradingCards\InventoryImportUtility\DAL\BaseEntity;
use GeoTradingCards\InventoryImportUtility\Helpers\DateTimeHelpers;

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
        throw new Exception("CardValueEntity->get() should never be called");
    }
    
    public function insert($cardValue)
    {
        $newID = null;

        // build up this entity object with the given business object
        $this->ID = $cardValue->getID();
        $this->lowValue = $cardValue->getLowValue();
        $this->highValue = $cardValue->getHighValue();
        $this->lastAppraisal = DateTimeHelpers::convertToDbFriendlyString($cardValue->getLastAppraisal(), "F j, Y");
        $this->lastAppraisalSource = $cardValue->getLastAppraisalSource();
        $this->card_ID = $cardValue->getCard()->getID();
        
        // set up the query
        $db = $this->getDB();
        if ($this->getUseSPROCs()) {
            $sproc = $this->getSPROCs()["insert"]["cardvalue"];
            $sql = "EXEC [$sproc] :id, :lowValue, :highValue, :lastAppraisal, :lastAppraisalSource, :cardID";
            $insertStatement = $db->prepare($sql);
            $insertStatement->bindParam(":id", $newID, \PDO::PARAM_INT, 4);
        } else {
            $sql = "INSERT INTO `cardvalue` (`LowValue`, `HighValue`, `LastAppraisal`, `LastAppraisalSource`, `Card_ID`) VALUES (:lowValue, :highValue, :lastAppraisal, :lastAppraisalSource, :cardID)";
            $insertStatement = $db->prepare($sql);
        }
        $insertStatement->bindParam(":lowValue", $this->lowValue);
        $insertStatement->bindParam(":highValue", $this->highValue);
        $insertStatement->bindParam(":lastAppraisal", $this->lastAppraisal);
        $insertStatement->bindParam(":lastAppraisalSource", $this->lastAppraisalSource);
        $insertStatement->bindParam(":cardID", $this->card_ID);

        // perform the insert
        $insertStatement->execute();
        
        // capture and return the new rows autoincremented ID
        if (!$this->getUseSPROCs()) {
            $newID = $db->lastInsertId();
        }
        if ($newID == 0) {
            $newID = null;
        }

        return $newID;
    }
}