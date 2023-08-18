public with sharing class OppController {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> findOpportunityByAccountId(String accountId) {      
        return [
            SELECT Id, Name, StageName, CloseDate  
            FROM Opportunity 
            WHERE AccountId=:accountId 

            LIMIT 10];
    }
}