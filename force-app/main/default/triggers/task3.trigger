trigger task3 on Opportunity (before update) {
if(trigger.isUpdate){
        if(Trigger.isBefore && Trigger.isUpdate){
        for(Opportunity eachoppo: Trigger.New){
            eachoppo.StageName = 'Prospecting';
            eachoppo.closedate=system.today()+15;
        }
    }
    }
}