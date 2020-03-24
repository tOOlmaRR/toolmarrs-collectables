<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\classes\Team
use GeoTradingCards\InventoryImportUtility\DAL\iEntity;
use GeoTradingCards\InventoryImportUtility\DAL\BaseEntity;

class TeamEntity extends BaseEntity implements iEntity
{
    public function get($team)
    {
        // For now, assume it's not in the database
        return null;
    }
    
    public function insert($objectToInsert)
    {
        return null;
    }
}