trigger sendPasswordResetEmail on User (after insert) {
    // Get the list of new users
    List<User> newUsers = Trigger.new;

    // Create a list to hold the user's email addresses
    List<String> emailAddresses = new List<String>();

    // Iterate through the new users
    for (User u : newUsers) {
        // Add the user's email address to the email addresses list
        emailAddresses.add(u.Email);
    }

    // Send the password reset email
    Messaging.reserveSingleEmailCapacity(emailAddresses.size());
    Messaging.SingleEmailMessage[] mails = new Messaging.SingleEmailMessage[0];
    for (String email : emailAddresses) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] { email });
        mail.setSubject('Password Reset Request');
        mail.setPlainTextBody('You can reset your password by clicking on this link : '+'https://Mvclouds.com/resetpassword?u=');
        mails.add(mail);
    }
    Messaging.sendEmail(mails);
}