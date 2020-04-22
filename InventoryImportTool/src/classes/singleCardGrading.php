<?php
namespace GeoTradingCards\InventoryImportUtility\Classes;

use GeoTradingCards\InventoryImportUtility\Classes\SingleCard as SingleCard;
use GeoTradingCards\InventoryImportUtility\Classes\GradingClass as GradingClass;

class SingleCardGrading
{
    // private members
    private $ID;
    private $edges;
    private $surfaces;
    private $corners;
    private $alignment;
    private $overallGrade;
    private $BCG_serialNumber;
    private $BCG_Grade;
    private $singleCard;
    private $gradingClass;
    
    
    
    // constructor(s)
    public function __construct()
    {
        
    }



    // public getters/accessors
    public function getID() : ?int
    {
        return $this->ID;
    }
    
    public function getEdges() : ?int
    {
        return $this->edges;
    }
    
    public function getSurfaces() : ?int
    {
        return $this->surfaces;
    }
    
    public function getCorners() : ?int
    {
        return $this->corners;
    }
    
    public function getAlignment() : ?int
    {
        return $this->alignment;
    }
    
    public function getOverallGrade() : ?float
    {
        return $this->overallGrade;
    }
    
    public function getBCG_serialNumber() : ?string
    {
        return $this->BCG_serialNumber;
    }
    
    public function getBCG_Grade() : ?float
    {
        return $this->BCG_Grade;
    }
    
    public function getSingleCard() : SingleCard
    {
        return $this->singleCard;
    }
    
    public function getGradingClass() : ?GradingClass
    {
        return $this->gradingClass;
    }
    
    
    
    // public setters
    public function setID(int $singleCardGradingID)
    {
        $this->ID = $singleCardGradingID;
    }
    
    public function setEdges(?int $singleCardGradingEdges)
    {
        $this->edges = $singleCardGradingEdges;
    }
    
    public function setSurfaces(?int $singleCardGradingSurfaces)
    {
        $this->surfaces = $singleCardGradingSurfaces;
    }
    
    public function setCorners(?int $singleCardGradingCorners)
    {
        $this->corners = $singleCardGradingCorners;
    }
    
    public function setAlignment(?int $singleCardGradingAlignment)
    {
        $this->alignment = $singleCardGradingAlignment;
    }
    
    public function setOverallGrade(?float $singleCardGradingOverallGrade)
    {
        $this->overallGrade = $singleCardGradingOverallGrade;
    }
    
    public function setBCG_serialNumber(?string $singleCardGradingBCG_serialNumber)
    {
        $this->BCG_serialNumber = $singleCardGradingBCG_serialNumber;
    }
    
    public function setBCG_Grade(?float $singleCardGradingBCG_Grade)
    {
        $this->BCG_Grade = $singleCardGradingBCG_Grade;
    }
    
    public function setSingleCard(SingleCard $singleCardGradingSingleCard)
    {
        $this->singleCard = $singleCardGradingSingleCard;
    }
    
    public function setGradingClass(GradingClass $singleCardGradingClass)
    {
        $this->gradingClass = $singleCardGradingClass;
    }
}