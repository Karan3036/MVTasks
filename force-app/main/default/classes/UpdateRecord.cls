public with sharing class UpdateRecord {
   @AuraEnabled
   public static void updateField(String recordId, String FieldValue) {
       Contact contact = [SELECT Id, Opportunity_Name__c FROM Contact WHERE Id = :recordId];
       contact.Opportunity_Name__c = FieldValue;
       System.debug(recordId);
       System.debug(FieldValue);
       update contact;
   }
}