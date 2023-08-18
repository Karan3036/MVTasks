trigger task14 on Account (before insert) {
      for(Account acc : trigger.new)
    {
     List<Account> mynew = [SELECT Id, Name FROM Account WHERE Name =: acc.Name];
     delete mynew;
    }
}