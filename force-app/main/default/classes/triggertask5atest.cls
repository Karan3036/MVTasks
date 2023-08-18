@isTest
public class triggertask5atest {
@isTest    
public static void insertaccount() {
 Account acc = new Account(Name = 'Demo ACC' , Ownership='Other');
 System.debug('Ownership before inserting account record: ' + acc.Ownership);
 Test.startTest();
 insert acc;
 Test.stopTest();
 

 acc = [SELECT Name,Ownership FROM Account WHERE Id =:acc.Id];
 System.debug('Ownership after inserting account record: ' + acc.Ownership);
 

 System.assertEquals('Public', acc.Ownership);
  
 }
}