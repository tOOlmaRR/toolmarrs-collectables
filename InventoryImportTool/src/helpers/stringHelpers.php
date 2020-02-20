<?php
namespace GeoTradingCards\InventoryImportUtility\Helpers;

class StringHelpers
{
    // Function to check if a given string starts with another string
    // Note: this is a case-sensitive match
    // CREDIT:  https://www.geeksforgeeks.org/php-startswith-and-endswith-functions/ (as of 2020-02-20)
    public static function startsWith($sourceString, $startString)
    {
        $len = strlen($startString);
        $substr = substr($sourceString, 0, $len);
        return (substr($sourceString, 0, $len) === $startString);
    }
     
    // Function to check if a given string ends with another string
    // Note: this is a case-sensitive match
    // CREDIT:  https://www.geeksforgeeks.org/php-startswith-and-endswith-functions/ (as of 2020-02-20)
    public static function endsWith($sourceString, $endString)
    {
        $len = strlen($endString);
        if ($len == 0) {
            return true;
        }
        return (substr($sourceString, -$len) === $endString); 
    }
}