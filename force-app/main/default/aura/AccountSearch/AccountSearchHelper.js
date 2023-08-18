({
    updateDraggedCase : function(component, event, helper, conId, accid) {
        var action = component.get("c.updateCase");
        console.log('try    9:- '+accid);
        console.log('try    8:- '+conId);
        action.setParams({ conId : conId, 
                           accid : accid});
        $A.enqueueAction(action);
    }
   
})