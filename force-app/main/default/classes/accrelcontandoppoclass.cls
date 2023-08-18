public class accrelcontandoppoclass {

    public string recid{get;set;}    
    public list<Account> Acclst{get;set;}
    public List<Contact> contacts {get; set;}
    public List<Opportunity> opportunities {get; set;}
    
    public accrelcontandoppoclass(){
        Acclst = [SELECT Id, Name, Phone, BillingCountry, BillingPostalCode, BillingState, BillingCity, BillingStreet FROM Account LIMIT 10];
        contacts=null;
        opportunities=null;
    }
    
    public void showDetails() {
        contacts=[SELECT Id, FirstName, LastName, Email FROM Contact WHERE AccountId=:recId];
        opportunities=[SELECT Id, Name, StageName, CloseDate FROM Opportunity WHERE AccountId=:recId];
    }
}