trigger task5 on Account (before insert, before update) {
if(trigger.isUpdate || trigger.isInsert){
        if((Trigger.isBefore && Trigger.isUpdate) || (Trigger.isBefore && Trigger.isInsert) ){
        for(Account eachacc: Trigger.New){
            eachacc.Ownership = 'Public';
        }
        }
    }
}