@isTest
public class triggertask2test {
@isTest    
public static void createlead() {
 Lead le = new Lead(LastName='Demo', Company='Demo Company', Status='Open - Not Contacted ');
 System.debug('Rating before inserting new lead: ' + le.Rating);
 
 Test.startTest();
 // Insert book
 insert le;
 
 Test.stopTest();
 
 // Retrieve the new book
 le = [SELECT Rating FROM Lead WHERE Id =:le.Id];
 System.debug('Rating after inserting new lead: ' + le.Rating);
 
 // Test that the trigger correctly updated the price
 System.assertEquals('Hot', le.Rating);
 }
}