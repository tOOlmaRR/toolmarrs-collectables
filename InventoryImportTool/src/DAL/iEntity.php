<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

interface iEntity
{
    public function get($objectToFind);
    
    public function insert($objectToInsert);
}