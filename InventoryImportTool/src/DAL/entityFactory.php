<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\DAL\ManufacturerEntity;
use GeoTradingCards\InventoryImportUtility\DAL\CardSetEntity;
use PDO;

class EntityFactory
{
    // private members
    private $dbHost;
    private $dbUser;
    private $dbPassword;
    private $databaseConnection;
    
    
    
    // constructor(s)
    public function __construct(string $host, string $user, string $password)
    {
        $this->dbHost = $host;
        $this->dbUser = $user;
        $this->dbPassword = $password;
        $this->getDatabaseConnection();
    }
    
    
    //  methods
    public function getDatabaseConnection() : PDO
    {
        if (is_null($this->databaseConnection)) {
            // Get a connection to the database if we don't already have one
            $db = new \PDO($this->dbHost, $this->dbUser, $this->dbPassword);
            if ($db != null) {
                $this->databaseConnection = $db;
            }
        }
        return $this->databaseConnection;
    }
    
    public function getEntity(string $entityType)
    {
        switch ($entityType)
        {
            case "manufacturer":
                return new ManufacturerEntity($this->getDatabaseConnection());
                break;
                
            case "cardset":
                return new CardSetEntity($this->getDatabaseConnection());
                break;
            
            default:
                return null;
                break;
        }
    }
}