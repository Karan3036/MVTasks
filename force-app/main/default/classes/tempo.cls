public with sharing class tempo {
    @AuraEnabled(cacheable=true)
    public static List<EmailTemplate> getEmailTemplates() {
      return [SELECT Id, Name FROM EmailTemplate];
    }
  }