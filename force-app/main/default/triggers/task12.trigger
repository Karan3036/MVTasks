trigger task12 on Account (after  insert) {
    list<Contact> lstCon = new list<Contact>();
    for(Account Acc: trigger.new){
        Contact con = new Contact ();
        Con.FirstName = 'test';
        Con.AccountId = Acc.Id;
        Con.LastName = Acc.Name;
        Con.Password__c = 'KARAN';
        lstCon.Add(Con);
        
    }
insert lstCon;
}