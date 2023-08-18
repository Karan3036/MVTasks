public class AccountsController {   
    @AuraEnabled
    public static List<Account> findByName(String searchKey) {
        String name =  + searchKey + '%';
        return [select id,name,(select Name,phone,Email from contacts) FROM account WHERE name LIKE :name];
    }
    @AuraEnabled
    public static List<Account> findByName_2(String searchKey) {
        String name_2 =  + searchKey + '%';
        return [select id,name,(select Name,phone,Email from contacts) FROM account WHERE name LIKE :name_2];
    }
    @AuraEnabled
    public static void updateCase(ID conId, ID accid){
        System.debug('con :- ' +conId);
        System.debug('acc :- ' +accid);
        System.debug('testtttttttttt');
        Set<Id> accID1 = new Set<Id>();
        accID1.add(conId);

        List<Contact> accountsWithNullType =[SELECT id, name, AccountId FROM Contact WHERE Id IN : accID1];
        for(Contact acc: accountsWithNullType){
            System.debug(acc.name + acc.AccountId);
            acc.AccountId = accid;
            System.debug('Helllo');
        }
        System.debug('Helllo' + accountsWithNullType);
        update accountsWithNullType;
        // Contact c = new Contact();
        // c.Id = conId;
        // c.AccountId = accid;
        // update c;
        
    }
}