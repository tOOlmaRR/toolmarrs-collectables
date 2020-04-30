<?php
namespace GeoTradingCards\InventoryImportUtility\Helpers;

class DateTimeHelpers
{
    /**
    * Determine if a given datetime string in a given format is valid
    */
    public static function validateDateTime($datetimeString, $datetimeFormat) : bool
    {
        $datetimeObject = \DateTime::createFromFormat($datetimeFormat, $datetimeString);
        return $datetimeObject && $datetimeObject->format($datetimeFormat) == $datetimeString;
    }
    
    /**
    * Given a string, return a string in a format that can be inserted into a DateTime column in a database, assuming the column is nullable
    */
    public static function convertToDbFriendlyString($datetimeString, $expectedinputFormat) : ?string {
        if (is_null($datetimeString)) {
            return null;
        } elseif (DateTimeHelpers::validateDateTime($datetimeString, $expectedinputFormat)) {
            $datetimeObject = \DateTime::createFromFormat($expectedinputFormat, $datetimeString);
            return $datetimeObject->format("Y-m-d");
        } else {
            return null;
        }
    }
}
