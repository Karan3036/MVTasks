@isTest
public class testclass {
@isTest(SeeAllData=true)    
public static void info() {
 Test.startTest();
AccountHelper.getAccounts();
  AccountHelper.getAccountRecordsList();
    ConOppController.findContactByAccountId('0035g00000km5BrAAI');
    ContactAttachments.getAttachments('0035g00000km5BrAAI');
    ContactAttachments.deleteAttachments('0695g00000AePCcAAN');
    AccountsController.findByName('karan');
        AccountsController.findByName_2('karan');
        AccountsController.updateCase('0035g00000km5BrAAI','0015g000014SURrAAO');
Test.stopTest();       
 }
}