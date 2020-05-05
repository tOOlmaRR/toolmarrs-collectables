<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\DAL\ManufacturerEntity;
use GeoTradingCards\InventoryImportUtility\DAL\CardSetEntity;
use GeoTradingCards\InventoryImportUtility\DAL\CardEntity;
use GeoTradingCards\InventoryImportUtility\DAL\AttributeEntity;
use GeoTradingCards\InventoryImportUtility\DAL\CardHasAttributeEntity;
use GeoTradingCards\InventoryImportUtility\DAL\TeamEntity;
use GeoTradingCards\InventoryImportUtility\DAL\PlayerPositionEntity;
use GeoTradingCards\InventoryImportUtility\DAL\CardValueEntity;
use GeoTradingCards\InventoryImportUtility\DAL\SubsetEntity;
use GeoTradingCards\InventoryImportUtility\DAL\SingleCardEntity;
use GeoTradingCards\InventoryImportUtility\DAL\SingleCardGradingEntity;
use GeoTradingCards\InventoryImportUtility\DAL\GradingClassEntity;

use PDO;

class EntityFactory
{
    // private members
    private $dbInfo;
    private $dbType;
    private $dbDSN;
    private $dbUser;
    private $dbPassword;
    private $databaseConnection;
    
    
    
    // constructor(s)
    public function __construct(array $databaseInfo)
    {
        $this->dbInfo = $databaseInfo;
        $this->dbType = $databaseInfo['type'];
        $this->dbUser = $databaseInfo['user'];
        $this->dbPassword = $databaseInfo['password'];
        $this->getDatabaseConnection();
    }
    
    
    //  methods
    public function getDatabaseConnection() : PDO
    {
        if (is_null($this->databaseConnection)) {
            // Determine DSN based on DB Type, Host, and DB Name
            if ($this->dbType == "mysql") {
                $this->dbDSN = "mysql:host=" . $this->dbInfo['host'] . ";dbname=" . $this->dbInfo['name'];
            } elseif ($this->dbType == "mssql") {
                $this->dbDSN = "odbc:Driver={SQL Server Native Client 11.0};Server=" . $this->dbInfo['host'] . ";Database=" . $this->dbInfo['name'];
            } else {
                throw new \Exception("Database Type Configuration Error");
            }
            
            // Get a connection to the database if we don't already have one
            $options = [
                PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES   => false,
            ];
            try {
                $db = new \PDO($this->dbDSN, $this->dbUser, $this->dbPassword, $options);
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
                
            case "team":
                return new TeamEntity($this->getDatabaseConnection());
                
            case "position":
                return new PlayerPositionEntity($this->getDatabaseConnection());
                
            case "cardvalue":
                return new CardValueEntity($this->getDatabaseConnection());
                
            case "subset":
                return new SubsetEntity($this->getDatabaseConnection());
                
            case "single":
                return new SingleCardEntity($this->getDatabaseConnection());
                
            case "grading":
                return new SingleCardGradingEntity($this->getDatabaseConnection());
                
            case "gradingclass":
                return new GradingClassEntity($this->getDatabaseConnection());
            
            default:
                return null;
        }
    }
}