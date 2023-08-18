public with sharing class lwc_task5 {
    @AuraEnabled(Cacheable = true)
    public static List<List<SObject>> getAccountData(String textkey) {
        try {
            textkey = '%' + textkey + '%';
        System.debug('search name'+ textkey);
        List<List<SObject>> searchList = [FIND : textkey IN ALL FIELDS RETURNING Account(Name), Contact(FirstName,LastName) ,Lead(Name,Email),Opportunity(Name,StageName),Contract(Name,Status),Pricebook2(Name,Description)];
        System.debug('serch List' + searchList);
        
        return searchList; 
    } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
    }
    
}

@AuraEnabled(Cacheable = true)
public static list<SObject> getAccount(String filed1, String filed2, String filed3 ) {
    try {
        list<SObject> accLst = Database.query('SELECT '+ filed1 + ','+ filed2 + ' FROM ' + filed3 + ' LIMIT 10');
        System.debug(accLst);
        return accLst;
    } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
    }
    }
}