public class NewContactClass {
 public String firstName{get;set;}
    public String lastName{get;set;}
    public String phone{get;set;}
    public String email{get;set;}
    list <contact> conList;

    public NewContactClass(){
       conlist=new List<contact>();
    }

    public pageReference Save(){
        Contact con = new Contact(firstname=firstname, lastname=lastname, phone=phone, email=email);
        conList.add(con);
        insert conList;
        return null; 
   }
}