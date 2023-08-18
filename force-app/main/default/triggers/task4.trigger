trigger task4 on Opportunity (before insert, before update) {
if(trigger.isUpdate || trigger.isInsert){
        if((Trigger.isBefore && Trigger.isUpdate) || (Trigger.isBefore && Trigger.isInsert) ){
        for(Opportunity eachoppo: Trigger.New){
            eachoppo.Type = 'New Customer';
        }
    }
    }
}