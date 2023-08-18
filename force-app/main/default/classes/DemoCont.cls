public with sharing class DemoCont {
    public Contact con {get;set;}   
    public ApexPages.StandardSetController acc{get; set;} 
    public DemoCont()
    {
       con = new Contact();
       lstContact = new List<Contact>();
    }
    public List<Contact> lstContact 
    {  
        get  
        {  
            if(acc != null)  
                return (List<Contact>)acc.getRecords();  
            else  
                return null ;  
        }  
        set;
    }  
    public PageReference Search()
    {
        String query= '';
        String strFilter = '';
        if(con.FirstName != null && (con.FirstName ).trim() !='')
        {
           strFilter  = strFilter  +  ' where Name Like \''+con.FirstName+'%\'' ;
        }
        if(strFilter != '')
        {
            query = 'Select firstname,lastname,email from Contact '+strFilter+ ' limit 1000';
            System.debug('Query ---->'+ query );
            acc = new ApexPages.StandardSetController(Database.getQueryLocator(query)); 
            acc.setPageSize(10);
        }
        else
        {
        }
       return null;
    }
    public Boolean hasNext  
    {  
        get  
        {  
            return acc.getHasNext();  
        }  
        set;  
    }  
    public Boolean hasPrevious  
    {  
        get  
        {  
            return acc.getHasPrevious();  
        }  
        set;  
    }  
    public Integer pageNumber  
    {  
        get  
        {  
            return acc.getPageNumber();  
        }  
        set;  
    }  
    public void previous()  
    {  
        acc.previous();  
    }  
    public void next()  
    {  
        acc.next();  
    }  
   
}