global class AgeChecker implements Schedulable {
    global void execute(SchedulableContext SC) {
        //query for contacts whose age is above 18
        List<Contact> contacts = [SELECT Id,Email_Ids__c,Age__c FROM Contact WHERE Age__c > 18];
        //create a list of email addresses to send the email to
        List<String> emailAddresses = new List<String>();
        for (Contact contact : contacts) {
            if(contact.Email_Ids__c != null) {
            List<String> contactEmails = contact.Email_Ids__c.split(',');
            emailAddresses.addAll(contactEmails);
        }
        }
        //create an email message and set the recipient, subject, and body
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setToAddresses(emailAddresses);
        message.setSubject('Age Check');
        message.setPlainTextBody('This is an automated message to inform you that your age is above 18');
        //send the email
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
    }
}
//String cronExpression = '0 41 14 * * ?'; //daily at 1 PM
//AgeChecker ageChecker = new AgeChecker();
//Id jobId = System.schedule('Age Check', cronExpression, ageChecker);
//System.debug(jobId);