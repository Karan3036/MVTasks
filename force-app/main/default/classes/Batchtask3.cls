global class Batchtask3 implements Database.Batchable<sobject>{

   global final User currentOwner;
   global final User newOwner;
   

   global Batchtask3(){

      currentOwner = [SELECT ID FROM User Where ID='0055g00000FncrwAAB'];
      newOwner = [SELECT ID FROM User Where ID='0055g00000FoP0tAAF'];
   }

   global Database.QueryLocator start(Database.BatchableContext BC){
      String currentOwnerId = currentOwner.Id;
      return Database.getQueryLocator('SELECT Id, OwnerId FROM Account where OwnerId =: currentOwnerId');
      // System.debug('Started.....');
   }

   global void execute(Database.BatchableContext BC, List<Account> accts){
     for(Account acct : accts){
      acct.OwnerId = newOwner.Id; 
     }
     update accts;
 //      System.debug('executed.....');
    }

   global void finish(Database.BatchableContext BC){
AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =:BC.getJobId()];
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
String[] toAdd=new String[] {a.CreatedBy.Email};     
mail.setToaddresses(toAdd);
//mail.setReplyto('aksh66622@gmail.com');       /// Change the Email Id
mail.setSubject('Apex Sharing Recalculation ' + a.Status);
mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems +' batches with '+ a.NumberOfErrors + ' failures.');
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
   }
}