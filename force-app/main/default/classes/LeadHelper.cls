public with sharing class LeadHelper {
    public String leadId{get;set;}
    public Lead lObj{get;set;}
    public LeadHelper() {
        lObj = new Lead();
    }  
    @AuraEnabled(cacheable=true)    
    public static List<Lead> getLeads(){
        return [select id, name, Status, rating, Email from Lead limit 500];
    }
}