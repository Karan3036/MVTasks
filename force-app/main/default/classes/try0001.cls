public with sharing class try0001 {
    @AuraEnabled(cacheable=true)
    public static Opportunity findId(String fieldvalue) {      
        return [
            SELECT Id  
            FROM Opportunity
            WHERE Name=:fieldvalue ];
    }
}