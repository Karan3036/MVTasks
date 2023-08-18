global class Batchtask1 implements Database.Batchable <SObject>{
global Database.QueryLocator start (Database.BatchableContext bc)
{
    return Database.getQueryLocator('SELECT name from Account');
}
   global void execute(Database.BatchableContext bc, List<Account> acList)
   {
       for(Account ac :acList)
       {
          ac.name = ac.name+'5';
           
       }
       
       update acList;
   }
    
    global void finish(Database.BatchableContext bc)
    {
       Batchtask2 hp = new Batchtask2();
       Database.executeBatch(hp);
    }
    
}