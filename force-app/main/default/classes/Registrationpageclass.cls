public class Registrationpageclass {
    public String Name{get;set;}
    public String email{get;set;}
    public String password{get;set;}
    list <Registration_Page__c> regList;

    public Registrationpageclass(){
       reglist=new List<Registration_Page__c>();
    }

    public pageReference Save(){
        Registration_Page__c reg = new Registration_Page__c(Name__c=name, Email__c=email, Password__c=password);
        regList.add(reg);
        insert regList;
        return null; 
        
   }
}