public with sharing class ConHel {
    @AuraEnabled(cacheable=true)
    public static Contact findContactById(String recordId) {      
        return [
            SELECT Id, FirstName,LastName,Email,Phone  
            FROM Contact 
            WHERE Id=:recordId ];
    }
}