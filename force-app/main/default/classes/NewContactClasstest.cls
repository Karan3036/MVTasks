@isTest(seeAllData=false)
public class NewContactClasstest {
@isTest(seeAllData=false)
    public static void insertcontact(){
        Contact con = new Contact(firstname='Testing', lastname='trying', phone='5558566660', email='testtry001@gmail.com');
        Test.startTest();
// NewContactClass.Save();
Test.stopTest();       

    }
}