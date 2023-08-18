@isTest
public class triggertask3test {
@isTest    
public static void updateoppo() {
 Opportunity opp = new Opportunity(Amount = 1000 , id='0065g00000TtN0xAAF');

 Test.startTest();
 update opp;
 Test.stopTest();
 

 opp = [SELECT StageName,CloseDate FROM Opportunity WHERE Id ='0065g00000TtN0xAAF'];
 System.debug('Stage and Closedate after updating opportunity record: ' + opp.StageName +' & '+opp.CloseDate);
 

 System.assertEquals('Prospecting', opp.StageName);
    System.assertEquals(system.today()+15, opp.CloseDate);
 }
}