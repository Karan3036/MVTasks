global class Batchtask2 implements Database.Batchable<sObject>{
    
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
    //    List<Account> accountlist = new List<Account>();
        String query ='Select id, Name from Account'; 
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> scope){
        List<Opportunity> OpportunityList = new List<Opportunity>();
        for(Account a : scope) { 
            //set your opportunity values here
            Opportunity opp = new Opportunity();
            opp.name = 'Opp' + a.Name;
            opp.CloseDate=date.Today();
            opp.StageName='Prospecting';
            opp.AccountId = a.id; 
            OpportunityList.add(opp); 
        } 
        if(OpportunityList.size() > 0)
            insert OpportunityList; 
    }
    
    global void finish(Database.BatchableContext BC)    {
    }
}