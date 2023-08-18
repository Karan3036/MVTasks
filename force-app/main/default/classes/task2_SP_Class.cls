public class task2_SP_Class {
 public static void method1(list<contact> lstofconts,contact af,contact bt){
    set<id> accids = new set<id>();
    for (Contact con : lstofconts) {
        if (con.AccountId != null) {
            accids.add(con.accountid);
        }
    }
    List<Contact> conlist = [SELECT AccountId from Contact WHERE AccountId IN:accids];
    if (!conlist.isEmpty()) {
        for (Contact acc: conlist){
            acc.AccountId = af.accountid;
        }
    }
    if(!conlist.isEmpty()){
        update conlist;
    }
}
}