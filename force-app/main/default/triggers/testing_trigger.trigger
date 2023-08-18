trigger testing_trigger on Contact (before insert) {
if(Trigger.isbefore && Trigger.isInsert){
         for(contact con: Trigger.New){
             if(con.email != null){
                 con.phone = '4204204204';
             }
        }
}
}