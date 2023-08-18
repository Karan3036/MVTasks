trigger task8 on Account (before insert) {
    for(account acc:trigger.new){
        String s = acc.Name;
        if(acc.Gender__c == 'Male'){
            acc.Name = 'Mr.'+ acc.Name;
        }
        if(acc.Gender__c == 'Female' && acc.Marital_Status__c == 'Single'){
            acc.Name = 'Ms.'+ acc.Name;
        }
        if(acc.Gender__c == 'Female' && acc.Marital_Status__c == 'Married'){
            acc.Name = 'Mrs.'+ acc.Name;
        }
    }
}