global with sharing class SoapAPI{
    webService static List<Contact> getRecord(string accid){
                List<Contact> con = [select id, lastname, firstname  from Contact where AccountId=:accid];
                return con;
    }
}