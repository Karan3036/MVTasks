public class Testingemail {

    public Testingemail() {
        List<String> to = new List<String>();
        // to.add(quoterec.OwnerId);
        to.add('karsingh9377@gmail.com');
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setSubject('Quote Accepted by Customer');
        email.setToAddresses(to);
        email.setHtmlBody('Quote Accepted by Customer');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
        System.debug('Jaimin: Check Debug log ==> ' + email);
    }
    
    public void sendEmail() {
        Testingemail emailSender = new Testingemail();
    }
}