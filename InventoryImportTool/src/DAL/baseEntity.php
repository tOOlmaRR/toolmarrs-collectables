<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;
use GeoTradingCards\InventoryImportUtility\DAL\iEntity;

use PDO;

class BaseEntity implements iEntity
{
    private $db;
    private $useSPROCs;
    private $SPROCS;
    
    // constructor(s)
    public function __construct($db, $useSPROCs = false, $SPROCS = [])
    {
        $this->db = $db;
        $this->useSPROCs = $useSPROCs;
        $this->SPROCS = $SPROCS;
    }
    
    
    // public getters/accessors
    protected function getDB() : PDO
    {
        if (!is_null($this->db)) {
            return $this->db;
        } else {
            throw new \Exception("Found no database connection: ManufacturerEntity->getDB method");
        }
    }

    protected function getUseSPROCs()
    {
        return $this->useSPROCs;
    }

    protected function getSPROCs()
    {
        return $this->SPROCS;
    }
    
    
    
    // methods
    public function get($objectToFind)
    {
        throw new \Exception("Function has not been implemented");
    }

    public function insert($objectToInsert)
    {
        throw new \Exception("Function has not been implemented");
    }
}