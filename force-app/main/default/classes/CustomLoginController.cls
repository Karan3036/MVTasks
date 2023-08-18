public class CustomLoginController {

public String username{get; set;}
public String password {get; set;}

public pageReference doLogin()
{  
     List<Registration_Page__c> obj = new List<Registration_Page__c>();
if(username != null && username != '')
{
obj = [Select Username__c,Password__c from Registration_Page__c where Username__c =:username Limit 1];
if(obj.size()>0)
{
for(Registration_Page__c log : obj){
if(password == log.Password__c)
{
    return Page.Newaccountrelcontact ;
}
else
{
    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Invalid Password' );
    ApexPages.addMessage(myMsg);
    system.debug('MyMsg:'+myMsg);
}
}
}
else
{
ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Username does not exist' );
ApexPages.addMessage(myMsg);
system.debug('MyMsg:'+myMsg);
}
}
return null;
}
}