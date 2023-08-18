trigger task1a on Account (before insert, before update, before delete, after insert, after update) {

    if(trigger.isInsert) {
    
    
        if(trigger.isAfter || trigger.isBefore) {    
            for(Account account : trigger.new) {                
                system.debug(account.Name);
                
            }
        }
        
        if(trigger.isAfter) {
        
            for(Account account : trigger.newMap.Values()) {
                 system.debug(account.Name);                
            }
        }
    
    }
    
    if(trigger.isUpdate) {
    
        for(Account account : trigger.new) {
        
            if(account.Name != trigger.oldMap.get(account.Id).Name) {
                system.debug(account.Name);
            }     
        }
        
        for(Account account : trigger.old) {
        
            if(account.Name != trigger.newMap.get(account.Id).Name) {
                system.debug(account.Name);
            }     
        }  
        
        for(Account account : trigger.oldMap.Values()) {
        
            if(account.Name != trigger.newMap.get(account.Id).Name) {
                system.debug(account.Name);
            }     
        }               
    }
    
    if(trigger.isDelete) {
    
        if(trigger.isBefore) {
            
            for(Account account : trigger.old) {
                system.debug(account.Name);
                system.debug(trigger.oldMap.get(account.Id).Name);           
            }
            
            for(Account account : trigger.oldMap.Values()) {
                system.debug(account.Name);           
            }

            
        }
    
    }
       
}