<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\DAL\iEntity;
use GeoTradingCards\InventoryImportUtility\DAL\BaseEntity;
use GeoTradingCards\InventoryImportUtility\Classes\CardSet as CardSet;

class CardSetEntity extends BaseEntity implements iEntity
{
    // private members
    private $baseSetName;
    private $insertSetName;
    private $fullName;
    private $season;
    private $size;
    private $rarity;
    private $gradingModifier;
    private $comments;
    private $lastBeckettUpdate;
    private $lastInventoryCheck;
    private $manufacturerID;
    
    
    
    // methods
    public function get($cardSet)
    {
        $cardSetFromDatabase = null;
        $db = $this->getDB();
        $sql = "SELECT ID, BaseSetName, InsertSetName, FullName, Season, Size, Rarity, GradingModifier, Comments, LastBeckettUpdate, LastInventoryCheck, Manufacturer_ID FROM CardSet WHERE BaseSetName = :baseSetName AND InsertSetName = :insertSetName AND Season = :season LIMIT 1";
        $getStatement = $db->prepare($sql);
        $getStatement->execute(array(
            ":baseSetName" => $cardSet->getBaseSetName(),
            ":insertSetName" => $cardSet->getInsertSetName(),
            ":season" => $cardSet->getSeason()
        ));
        $row = $getStatement->fetch();
        if ($row == false) {
            $cardSetFromDatabase = null;
        } else {
            $cardSetFromDatabase = new CardSet;
            $cardSetFromDatabase->setID(intval($row["ID"]));
            $cardSetFromDatabase->setBaseSetName($row["BaseSetName"] != null ? $row["BaseSetName"] : '');
            $cardSetFromDatabase->setInsertSetName($row["InsertSetName"] != null ? $row["InsertSetName"] : '');
            $cardSetFromDatabase->setFullName($row["FullName"] != null ? $row["FullName"] : '');
            $cardSetFromDatabase->setSeason($row["Season"] != null ? $row["Season"] : '');
            
            $sizeInt = intval($row["Size"]);
            if ($sizeInt == 0) {
                $sizeInt = null;
            }
            $cardSetFromDatabase->setSize($sizeInt);
            $cardSetFromDatabase->setRarity($row["Rarity"] != null ? $row["Rarity"] : '');
            
            $gradingModifierFloat = floatval($row["GradingModifier"]);
            if ($gradingModifierFloat == 0) {
                $gradingModifierFloat = null;
            }
            $cardSetFromDatabase->setGradingModifier($gradingModifierFloat);
            $cardSetFromDatabase->setComments($row["Comments"] != null ? $row["Comments"] : '');
            $cardSetFromDatabase->setLastBeckettUpdate($row["LastBeckettUpdate"] != null ? $row["LastBeckettUpdate"] : '');
            $cardSetFromDatabase->setLastInventoryCheck($row["LastInventoryCheck"] != null ? $row["LastInventoryCheck"] : '');
            $cardSetFromDatabase->setManufacturer($cardSet->getManufacturer());
        }
        return $cardSetFromDatabase;
    }
    
    
    
    public function insert($cardSet)
    {
        return 1; // ID of inserted CardSet
    }
}