<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;
use GeoTradingCards\InventoryImportUtility\DAL\iEntity;

use PDO;

class BaseEntity implements iEntity
{
    private $db;
    
    // constructor(s)
    public function __construct($db)
    {
        $this->db = $db;
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