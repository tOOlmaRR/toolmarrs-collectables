<?php
namespace GeoTradingCards\InventoryImportUtility\Helpers;

class DateTimeHelpers
{
    /**
    * Determine if a given datetime string in a given format is valid
    */
    public static function validateDateTime($dateString, $dateFormat) : bool
    {
        $dateTimeObject = \DateTime::createFromFormat($dateFormat, $dateString);
        return $dateTimeObject && $dateTimeObject->format($dateFormat) == $dateString;
    }
}
