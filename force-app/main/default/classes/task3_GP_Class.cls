public class task3_GP_Class {
public static void great_problem(List<Contact> contactlist){
Set<Id> accids = new Set<Id>();
for(Contact con : contactlist){
    accids.add(con.AccountId);
}
Map<Id, Account> acc = new Map<Id, Account>([SELECT Id, Max_Amount__c FROM Account WHERE Id IN : accids]);
List<Contact> c = new List<Contact>();
for(Contact con : contactlist){
        while (con.Amount__c > acc.get(con.AccountId).Max_Amount__c) {
            Contact co = new Contact(LastName = con.LastName,Amount__c = acc.get(con.AccountId).Max_Amount__c, AccountId = con.AccountId);
            c.add(co);
            con.Amount__c -= acc.get(con.AccountId).Max_Amount__c;   
    }
}
insert c;
}
}