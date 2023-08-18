public with sharing class CreateUserHandler {

    @future
    public static void createUserFromContact(Set<Id> contactIds) {
        //System Administrator
        List<User> userList = new List<User>();
        List<Profile> profileList = [Select Id from Profile where Name=: 'Standard Platform User' limit 1];
        List<UserRole> roleList = [Select Id from UserRole where Name=: 'CEO' limit 1];
        for(Contact contactObj : [Select Id, Name, Email_Ids__c,User__c,LastName,FirstName from Contact where Id IN: contactIds limit 50000]){
            User uObj = new User();
            uObj.Username = contactObj.User__c;
            uObj.Email = contactObj.Email;
            //uObj.Alias = contactObj.FirstName;
            uObj.Alias = 'shai';
            uObj.FirstName = contactObj.FirstName;
            uObj.LastName = contactObj.LastName;
            uObj.UserRoleId = roleList[0].Id;
            uObj.ProfileId = profileList[0].Id;
            uObj.IsActive = true; 
            uObj.TimeZoneSidKey = 'GMT';
            uObj.LanguageLocaleKey = 'en_US';
            uObj.EmailEncodingKey = 'UTF-8';
            uObj.LocaleSidKey = 'en_US';
            uObj.Contact__c = contactObj.Id; //This line is added to set the contact Id to contact__c field
            userList.add(uObj);
        }
        try{
               insert userList;  // insert the user record
            System.debug(userList);
            System.debug('Workdone');
            System.enqueueJob(new SendPasswordResetEmails(userList));
            //sendPasswordResetEmail(userList);
        }catch(Exception e){
             System.debug('Error...' + e);
              // Catch Exception
         }
        
    }
    public class SendPasswordResetEmails implements Queueable {
    private List<User> users;

    public SendPasswordResetEmails(List<User> users) {
        this.users = users;
    }

    public void execute(QueueableContext context) {
        for (User user : users) {
            sendPasswordResetEmail(user.Id);
        }
    }

    private void sendPasswordResetEmail(Id userId) {
        User user = [SELECT Id,Username, Email FROM User WHERE Id = :userId];
        String resetUrl = URL.getSalesforceBaseUrl().toExternalForm() + '/secur/forgotpassword.jsp?un=' + user.Username;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {user.Email};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Password Reset');
        mail.setPlainTextBody('Please use the following link to reset your password: ' + resetUrl);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}
   
}