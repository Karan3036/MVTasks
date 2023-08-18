trigger approval on Account (after insert) {
    if(Trigger.isAfter){
        Account a = Trigger.new[0];
        system.debug('a '+a);
        Approval.ProcessSubmitRequest reql = new Approval.ProcessSubmitRequest();
        reql.setObjectId(a.Id);
        
        Approval.ProcessResult result = Approval.process(reql);
        system.debug('submitted for approval successfully '+result.isSuccess());
    }
}