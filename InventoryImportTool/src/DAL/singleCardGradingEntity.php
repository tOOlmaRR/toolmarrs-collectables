<?php
namespace GeoTradingCards\InventoryImportUtility\DAL;

use GeoTradingCards\InventoryImportUtility\classes\SingleCardGrading;
use GeoTradingCards\InventoryImportUtility\DAL\iEntity;
use GeoTradingCards\InventoryImportUtility\DAL\BaseEntity;

class SingleCardGradingEntity extends BaseEntity implements iEntity
{
    // private members
    private $ID;
    private $edges;
    private $surfaces;
    private $corners;
    private $alignment;
    private $overallGrade;
    private $BCG_SerialNumber;
    private $BCG_Grade;
    private $gradingClass_ID;
    private $singleCard_ID;



    // methods
    public function get($grading)
    {
        // We should never have to call this function
        throw new Exception("SingleCardGradingEntity->get() should never be called");
    }

    public function insert($grading)
    {
        $newID = null;
        
        // build up this entity object with the given business object
        $this->ID = $grading->getID();
        $this->edges = $grading->getEdges();
        $this->surfaces = $grading->getSurfaces();
        $this->corners = $grading->getCorners();
        $this->alignment = $grading->getAlignment();
        $this->overallGrade = $grading->getOverallGrade();
        $this->BCG_SerialNumber = $grading->getBCG_serialNumber();
        $this->BCG_Grade = $grading->getBCG_Grade();
        $this->gradingClass_ID = $grading->getGradingClass()->getID();
        $this->singleCard_ID = $grading->getSingleCard()->getID();
        
        // set up the query
        $db = $this->getDB();
        if ($this->getUseSPROCs()) {
            $sproc = $this->getSPROCs()["insert"]["singlecardgrading"];
            $sql = "EXEC [$sproc] :id, :edges, :surfaces, :corners, :alignment, :overallGrade, :BCGSerialNumber, :BCGGrade, :gradingClassID, :singleCardID";
            $insertStatement = $db->prepare($sql);
            $insertStatement->bindParam(":id", $newID, \PDO::PARAM_INT, 10);
        } else {
            $sql = "INSERT INTO `singlecardgrading` (`Edges`, `Surfaces`, `Corners`, `Alignment`, `OverallGrade`, `BCG_SerialNumber`, `BCG_Grade`, `GradingClass_ID`, `SingleCard_ID`) 
                VALUES (:edges, :surfaces, :corners, :alignment, :overallGrade, :BCGSerialNumber, :BCGGrade, :gradingClassID, :singleCardID)";
            $insertStatement = $db->prepare($sql);
        }
        $insertStatement->bindParam(":edges", $this->edges);
        $insertStatement->bindParam(":surfaces", $this->surfaces);
        $insertStatement->bindParam(":corners", $this->corners);
        $insertStatement->bindParam(":alignment", $this->alignment);
        $insertStatement->bindParam(":overallGrade", $this->overallGrade);
        $insertStatement->bindParam(":BCGSerialNumber", $this->BCG_SerialNumber);
        $insertStatement->bindParam(":BCGGrade", $this->BCG_Grade);
        $insertStatement->bindParam(":gradingClassID", $this->gradingClass_ID);
        $insertStatement->bindParam(":singleCardID", $this->singleCard_ID);

        // perform the insert
        $insertStatement->execute();
        
        // capture and return the new row's autoincremented ID
        if (!$this->getUseSPROCs()) {
            $newID = $db->lastInsertId();
        }
        if ($newID == 0) {
            $newID = null;
        }
        
        return $newID;
    }
}