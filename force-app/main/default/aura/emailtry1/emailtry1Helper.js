({
    sendEmailHelper : function(component, getTo, getCc, getBcc, getSubject, getBody, getFrom,getAttachments) {
        var action = component.get("c.sendEmailAction");
        console.log('getAttachments in helper--'+JSON.stringify(getAttachments));
        action.setParams({
            'eTo' : getTo,
            'eCc' : getCc,
            'eBcc': getBcc,
            'eSubject' : getSubject,
            'eBody' : getBody,
            'eFrom' : getFrom,
            'attach' : getAttachments
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state == "SUCCESS")
                alert('Email Send successfully..!!');
            else
                alert('Failed to send Email..!!');
        });

        $A.enqueueAction(action);
    }
})