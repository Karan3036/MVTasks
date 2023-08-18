public with sharing class ExcTest {
    public void ExcTest() {
            List<Account> listacc=[select id,name,rating from account];
            try{
                for(Account ac:listacc){
                    if(ac.rating.equals('Hot')){
    
                    }
                }
            }catch(Exception e){
                List<Error_log__c> tasks = new List<Error_log__c>();
                System.debug('Eccc ' +e);
                Error_log__c exc = new Error_log__c();
                String stackTrace = e.getStackTraceString().substringBefore('\n');
                String className = stackTrace.substringAfter('.').substringBefore('.');	
                String methodName = stackTrace.substringBefore(':').substringAfter(className).substringAfter('.');
                System.debug('stackTrace ' +stackTrace);
                System.debug('className ' +className);
                System.debug('methodName ' +methodName);
                exc.Exception_Message__c = e.getMessage();
                exc.Exception_Type__c = e.getTypeName();
                exc.Line_Number__c = e.getLineNumber();
                exc.More_Details__c = e.getStackTraceString();
                exc.Method_Name__c=methodName;
                exc.Class_Name__c=className;
                tasks.add(exc);
                insert tasks;
            }

    }
}