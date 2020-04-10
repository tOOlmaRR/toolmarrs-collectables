<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\DAL\ManufacturerEntity;
use GeoTradingCards\InventoryImportUtility\DAL\CardSetEntity;
use GeoTradingCards\InventoryImportUtility\DAL\CardEntity;
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
            $options = [
                PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES   => false,
            ];
            try {
                $db = new \PDO($this->dbHost, $this->dbUser, $this->dbPassword, $options);
                if ($db != null) {
                    $this->databaseConnection = $db;
                }
            } catch (\PDOException $e) {
                 throw new \PDOException($e->getMessage(), (int)$e->getCode());
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
                
            case "cardset":
                return new CardSetEntity($this->getDatabaseConnection());
                
            case "card":
                return new CardEntity($this->getDatabaseConnection());
                
            case "attribute":
                return new AttributeEntity($this->getDatabaseConnection());
                
            case "cardhasattribute":
                return new CardHasAttributeEntity($this->getDatabaseConnection());
            
            default:
                return null;
        }
    }
}