({
    doInit : function(component, event, helper) {
        var action = component.get('c.getPickList');
        action.setParams({
            objName : component.get('v.objName'),
            fldName : component.get('v.fldName')
        });
        action.setCallback(this,function(result){
            var resultValue = result.getReturnValue();
            component.set('v.ratingList',resultValue);
        });
        $A.enqueueAction(action);
    },
    doSave : function(component, event, helper) {
        var action = component.get('c.createAccount');
        action.setParams({
            ac : component.get('v.createAcc')
        });
        action.setCallback(this,function(result){
            var getAllValue = component.get('v.createAcc');
            alert(JSON.stringify(getAllValue));
        });
        $A.enqueueAction(action);
    },
    docancel : function(component, event, helper) {
        component.set('v.createAcc','');
    },
})