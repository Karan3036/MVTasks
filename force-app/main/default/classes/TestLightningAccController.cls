public with sharing class TestLightningAccController 
{
@AuraEnabled
    public static list<Contact> getRelatedList(Id recordId)
    {
        List<Contact> Conlist = [Select id, name,firstname,lastname,email from Contact where AccountId =: recordId ];
        return Conlist;
    }

// This method used for reterived  the list of opportunity records based on the search string

@AuraEnabled

public static list<Contact> getByName(String searchKey) {

String name = '%' + searchKey + '%';

return [SELECT id, name,firstname,lastname,email from Contact WHERE name LIKE :name];

}
   
}