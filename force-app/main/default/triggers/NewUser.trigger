trigger NewUser on Contact (after insert) {
    // Create a list to store the users that need to be created
    List<User> newUsers = new List<User>();
    List<Profile> profileList = [Select Id from Profile where Name=: 'Standard Platform User' limit 1];
    // Iterate over the contacts that were just inserted
    for (Contact contact : Trigger.new) {
        // Create a new user
        User newUser = new User();
        newUser.Username = contact.User__c;
        System.debug(contact.Email);
        newUser.Email = contact.Email;
        System.debug(contact.Email);
        newUser.FirstName = contact.FirstName;
        System.debug(contact.FirstName);
        newUser.LastName = contact.LastName;
        System.debug(contact.LastName);
        newUser.EmailEncodingKey = 'ISO-8859-1';
        newUser.TimeZoneSidKey = 'Europe/London';
        newUser.LocaleSidKey = 'en_GB';
        newUser.LanguageLocaleKey = 'en_US';
        newUser.ProfileId = profileList[0].Id;
        newUser.Alias = contact.FirstName;
        newUsers.add(newUser);
    }

    // Insert the new users
    insert newUsers;

    // Send an email to the new user with a link to reset their password
    for(User u: newUsers){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {u.Email};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Welcome to our company');
        mail.setPlainTextBody('You can reset your password by clicking on this link : '+'https://Mvclouds.com/resetpassword?u='+EncodingUtil.base64Encode(Blob.valueOf(u.Id)));
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    //update the contact with the new user id
    List<Contact> contToUpdate = new List<Contact>();
    for(Contact c: Trigger.new){
        c.User__c = newUsers[0].Id;
        contToUpdate.add(c);
    }
    update contToUpdate;
}