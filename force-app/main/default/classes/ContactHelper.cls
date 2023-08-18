public with sharing class ContactHelper {
    public String contactId{get;set;}
    public Contact conObj{get;set;}
    public ContactHelper() {
        conObj = new Contact();
    }  
    @AuraEnabled(cacheable=true)    
    public static List<Contact> getContacts(String recordId){
        return [select id,firstname,lastname,Email from Contact limit 500];
    }
}