public class EmailSender {
    public static void sendEmail(List<String> emailAddresses, String emailBody) {
        for (String emailAddress : emailAddresses) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[] { emailAddress });
            email.setPlainTextBody(emailBody);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
        }
    }
}