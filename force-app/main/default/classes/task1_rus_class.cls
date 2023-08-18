public class task1_rus_class {
  
    public static void rollupContacts(list<contact> lstOfconts){
        system.debug('lstOfconts : '+lstOfconts);
        set<id> accIds = new set<id>();
        list<account> updLstOfAccs = new list<account>();
        list<contact> lstCons = new list<contact>();
      
        for(contact con : lstOfconts){
    if(con.accountid != null)
            accIds.add(con.accountid);
        }
        system.debug('accIds:'+accIds);
        list<account> lstAccs = [select id,name,Tot_Amount__c, (select id,Amount__c from contacts) from account where id in : accIds];
      
        for(account acc : lstAccs){
            system.debug('acc.contacts.size()'+acc.contacts.size());
			decimal sumamt = 0;
           if(acc.contacts.size() >0)
           for(contact co : acc.contacts){
		       if(co.Amount__c != null)
               sumamt = sumamt+co.Amount__c;            
            }
		acc.Tot_Amount__c = sumamt;
		updLstOfAccs.add(acc);
		}
        if(updLstOfAccs.size() > 0){
            update updLstOfAccs;
        }
      
      
    }
  
}