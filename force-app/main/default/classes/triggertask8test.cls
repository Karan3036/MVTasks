@isTest
public class triggertask8test {
@isTest    
public static void insertaccount() {
 Account acc = new Account(Name = 'Testing DP', Gender__c = 'Female', Marital_Status__c ='Single' );
 Test.startTest();
 insert acc;
Test.stopTest();       
 }
}