public class newcontactregisclass {
    public String firstname{get;set;}
    public String lastname{get;set;}
    public String email{get;set;}
    public String password{get;set;}
    public String selectedaccId {set;get;}
    List<selectOption> options=new List<selectoption>();
    list <Contact> conList;

    public newcontactregisclass(){
       conlist=new List<Contact>();
        selectedaccId ='';
    }

    public pageReference Save(){
        Contact con = new Contact(FirstName=firstname, LastName=lastname, Email=email, Password__c=password);
        conList.add(con);
        insert conList;
        return null; 
        
   }
    public List<SelectOption> getListOfAccount(){
        options.add(new selectOption('','--Select--'));
        for(Account acc:[select id,name from account ]){
            options.add(new selectOption(acc.id,acc.name));
        }
        return options; 
    }
}