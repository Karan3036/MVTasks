trigger task6 on Account (after update) {
    List<Id> listOfAccountIds = new List<Id>();
    for(Account eachAccount : Trigger.New){
    //only name modified then send email to related contact
        if(eachAccount.Name != Trigger.oldmap.get(eachAccount.Id).Name){
            listOfAccountIds.add(eachAccount.Id);
        }
    }

    for(Contact c : [select Email from Contact where AccountId IN :listOfAccountIds]){

task6class.sendMail(c.Email, 'Account is updated','Account name has been updated to the account related to your contact.');

    }
}