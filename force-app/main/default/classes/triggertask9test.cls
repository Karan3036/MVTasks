@isTest
public class triggertask9test {
@isTest(SeeAllData=true)    
public static void deletecon() {
 Contact con = new Contact(Id = '0035g00000qt8JfAAI' );
 Test.startTest();
 delete con;
Test.stopTest();       
 }
}