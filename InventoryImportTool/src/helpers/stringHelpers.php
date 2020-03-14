<?php
namespace GeoTradingCards\InventoryImportUtility\Helpers;

class StringHelpers
{
    // Function to check if a given string starts with another string
    // Note: this is a case-sensitive match
    // CREDIT:  https://www.geeksforgeeks.org/php-startswith-and-endswith-functions/ (as of 2020-02-20)
    public static function startsWith($sourceString, $startString) : bool
    {
        $len = strlen($startString);
        $substr = substr($sourceString, 0, $len);
        return (substr($sourceString, 0, $len) === $startString);
    }
     
    // Function to check if a given string ends with another string
    // Note: this is a case-sensitive match
    // CREDIT:  https://www.geeksforgeeks.org/php-startswith-and-endswith-functions/ (as of 2020-02-20)
    public static function endsWith($sourceString, $endString) : bool
    {
        $len = strlen($endString);
        if ($len == 0) {
            return true;
        }
        return (substr($sourceString, -$len) === $endString); 
    }
    
    // Function to check if a given string contains another given string (ie. the 'needle')
    // Note: this is a case-sensitive match
    // CREDIT: https://www.tutorialrepublic.com/faq/how-to-check-if-a-string-contains-a-specific-word-in-php.php (as of 2020-03-14)
    public static function contains($sourceString, $needle) {
        // Test if string contains the word 
        if (strpos($sourceString, $needle) !== false) {
            return true;
        } else {
            return false;
        }
    }
}