({
     
   selectStep1 : function(component,event,helper){
        component.set("v.selectedStep", "step1");
    },
    selectStep2 : function(component,event,helper){
        component.set("v.selectedStep", "step2");
    },
    selectStep3 : function(component,event,helper){
        component.set("v.selectedStep", "step3");
    },
    selectStep4 : function(component,event,helper){
        component.set("v.selectedStep", "step4");
    },
    
    nextTab : function(component, event, helper) {

         var getselectedStep = component.get("v.selectedStep");
         component.set("v.setMessage", '');           
        var showAccount = component.get("v.showAccount");
        var showContact = component.get("v.showContact");
        var showEvent = component.get("v.showEvent");
        var showData = component.get("v.showData");
        
        
        if(showAccount == true && getselectedStep == "step1"){
            component.set("v.selectedStep", "step2");
            var accountName = component.find("Name").get("v.value");
            console.log('accountName:::'+accountName);
            if(accountName =='' || accountName == null){
                component.set("v.setMessage",'error');           
            }
            if(component.get("v.setMessage")=='error')
            { 
                component.set("v.showContact",false);
                component.set("v.showEvent", false);
                component.set("v.showError", true);
                component.set("v.showData", false);
                
            }
            else
            { 
                component.set("v.showAccount", false);
                component.set("v.showContact", true);
                component.set("v.showEvent", false); 
                component.set("v.showError", false);
                component.set("v.showData", false);
            }
        }    
        if(showContact == true && getselectedStep == "step2"){
            component.set("v.selectedStep", "step3");
            var lastName = component.find("LastName").get("v.value");
            console.log('lastName:::'+lastName);
            if(lastName =='' || lastName == null){
                component.set("v.setMessage",'error');           
            }
            if(component.get("v.setMessage")=='error')
            { 
                component.set("v.showAccount", false);
                component.set("v.showEvent", false);
                component.set("v.showError", true);
                component.set("v.showData", false);
            }
            else
            { 
                component.set("v.showAccount", false);
                component.set("v.showContact", false);
                component.set("v.showEvent", true);
                component.set("v.showError", false);
                component.set("v.showData", false);
            }
        }   
        
        if(showEvent == true && getselectedStep == "step3"){
            component.set("v.selectedStep", "step4");
             var StartDateTime = component.find("EventStartDateTime").get("v.value");
            console.log('StartDateTime:::'+StartDateTime);
            var EndDateTime = component.find("EventEndDateTime").get("v.value");
            console.log('EndDateTime:::'+EndDateTime);

            if(component.get("v.setMessage")=='error')
            { 
                component.set("v.showAccount", false);
                component.set("v.showContact", false);
                component.set("v.showError", true);
                component.set("v.showData", false);
                
            }
            else
            { 
                component.set("v.showEvent", false);
                component.set("v.showContact", false);
                component.set("v.showAccount", false)
                component.set("v.showError", false);
                component.set("v.showData", true);
            }
        }   
        
    },
    prevTab : function(component, event, helper) {
        
         var getselectedStep = component.get("v.selectedStep");
        if(getselectedStep == "step2"){
            component.set("v.selectedStep", "step1");
        }
        else if(getselectedStep == "step3"){
            component.set("v.selectedStep", "step2");
        }
        else if(getselectedStep == "step4"){
            component.set("v.selectedStep", "step3");
        }
        
        var showAccount = component.get("v.showAccount");
        var showContact = component.get("v.showContact");
        var showEvent = component.get("v.showEvent");
        var showData = component.get("v.showData");
        
        
        if(showContact == true){
            component.set("v.showAccount", true);
            component.set("v.showContact", false);
            component.set("v.showEvent", false);
            component.set("v.showError", false);
            component.set("v.showData", false);
        }    
        if(showEvent == true){
            component.set("v.showAccount", false);
            component.set("v.showContact", true);
            component.set("v.showEvent", false);
            component.set("v.showError", false);
            component.set("v.showData", false);
        } 
        if(showData == true){
            component.set("v.showAccount", false);
            component.set("v.showContact", false);
            component.set("v.showEvent", true);
            component.set("v.showError", false);
            component.set("v.showData", false);
        }  
    },
    
    
    saveRecord : function(component, event, helper) {
        helper.saveData(component, event, helper);
        alert('Finished...');
        component.set("v.selectedStep", "step1");
    }
})