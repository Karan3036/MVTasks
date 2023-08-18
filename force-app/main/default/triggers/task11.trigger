trigger task11 on Account (after update) {
    Accountshare accshare = new Accountshare();
    for(account acc : trigger.new){
        if(acc.rating == 'Hot' ){
            
            accshare.AccountID = acc.id;
            accshare.RowCause = 'Manual';
            accshare.UserOrGroupId = '0055g00000FoiwzAAB';
            accshare.AccountAccessLevel = 'Read';
            accshare.OpportunityAccessLevel = 'None';
            insert accshare;
        }
    }
}