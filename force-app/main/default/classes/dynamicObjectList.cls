public with sharing class dynamicObjectList {
     @AuraEnabled(cacheable=true)
    public static List<FieldDefinition> getfields(string objectname){
        string query = 'select DeveloperName,QualifiedApiName from FieldDefinition where EntityDefinition.QualifiedApiName = :objectname ORDER BY DeveloperName ASC';
        list<FieldDefinition> lstObject = Database.query(query);
        system.debug('lstObject==> '+lstObject);
        return lstObject;
    }
}