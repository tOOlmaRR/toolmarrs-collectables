class InputValidator
{
    static validateSport(sport) {
        if (typeof(sport) == "string" && sport.length <= 25)
            return true;
        else
            return false;
    }
    
    static validateSeason(season) {
        if (typeof(season) == "string" && (season.length == 7 || season.length == 4))
            return true;
        else
            return false;
    }
    
    static validateBaseSetName(baseSetName) {
        if (typeof(baseSetName) == "string" && baseSetName.length <= 100)
            return true;
        else
            return false;
    }
    
    static validateInsertSetName(insertSetName) {
        if (typeof(insertSetName) == "undefined" || (typeof(insertSetName) == "string" && insertSetName.length <= 100))
            return true;
        else
            return false;
    }
}
module.exports = InputValidator;
