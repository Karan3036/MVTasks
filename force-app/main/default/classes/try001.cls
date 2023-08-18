public with sharing class try001 {
    @AuraEnabled(cacheable=true)
    public static list<Opportunity> findById(String accId) {      
        list<Opportunity> opp = [
            SELECT Name
            FROM Opportunity 
            WHERE AccountId=:accId ];
        System.debug(opp);
        return opp;
    }
}