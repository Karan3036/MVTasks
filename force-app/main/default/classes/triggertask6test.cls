@isTest
public class triggertask6test {
@isTest    
public static void updateaccount() {
 Account acc = new Account(Name = 'Testing DP' , Id='0015g000016yQUxAAM');
 Test.startTest();
 update acc;
     Contact c;   
task6class.sendMail('aksh66622@gmail.com', 'Account is updated','Account name has been updated to the account related to your contact.');

Test.stopTest();       
 }
}