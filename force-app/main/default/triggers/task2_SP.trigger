trigger task2_SP on Contact (after update) {
task2_SP_Class.method1(trigger.old,trigger.new[0], trigger.old[0]);
    //List<Id> oldaccid = new List<Id>();
 //   List<Id> newaccid = new List<Id>();
 //list<contact> lstofconts = trigger.old;
   // contact af = trigger.new[0];
    //contact bt = trigger.old[0];
    //set<id> accids = new set<id>();
    //for (Contact con : lstofconts) {
      //  if (con.AccountId != null) {
            //newaccid.add(Trigger.newmap.get(con.Id).AccountId);
            //oldaccid.add(Trigger.oldmap.get(con.Id).AccountId);
            //System.debug(oldaccid);
            //System.debug(newaccid);
        //    accids.add(con.accountid);
        //}
    //}
    //List<Contact> conlist = [SELECT AccountId from Contact WHERE AccountId IN:accids];
    //if (!conlist.isEmpty()) {
      //  for (Contact acc: conlist){
        //    acc.AccountId = af.accountid;
        //}
    //}
    //if(!conlist.isEmpty()){
      //  update conlist;
    //}
}