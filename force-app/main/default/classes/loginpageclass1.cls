public class loginpageclass1 {

public String username{get; set;}
public String password {get; set;}

public pageReference doLogin()
{  
     List<Contact> obj = new List<Contact>();
if(username != null && username != '')
{
obj = [Select Email,Password__c from Contact where Email =:username Limit 1];
if(obj.size()>0)
{
for(Contact log : obj){
if(password == log.Password__c)
{
    return Page.accrelcontandoppo ;
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