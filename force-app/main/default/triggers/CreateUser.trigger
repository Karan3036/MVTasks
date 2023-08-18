trigger CreateUser on Contact (after insert) {

    List<User> userList = new List<User>();
    Set<Id> contactIds = new Set<Id>();
    for(Contact c: Trigger.New){
       
            contactIds.add(c.id);
   
    }

    if(contactIds.size() > 0){
        CreateUserHandler.createUserFromContact(contactIds);
    }
    
}