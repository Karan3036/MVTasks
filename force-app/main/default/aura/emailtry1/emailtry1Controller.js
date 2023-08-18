({

    doInit: function(component, event, helper) {
        var action = component.get("c.getOrgWideEmailAddress");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.from", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
    sendEmail: function(component, event, helper) {
        var to = component.get("v.to");
        var cc = component.get("v.cc");
        var bcc = component.get("v.bcc");
        var subject = component.get("v.subject");
        var body = component.get("v.body");
        var from = component.find("fromId").get("v.value");
        //console.log('files before send--'+JSON.stringify(component.get("v.files")));
        var attachments = component.get("v.files");
        //console.log('Added attachments--'+attachments.length);
        var validEmail = component.find('isValid').reduce(function (validSoFar, inputCmp) {
                inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        if(validEmail){
            console.log('attachments---'+JSON.stringify(attachments));
            helper.sendEmailHelper(component, to, cc, bcc, subject, body, from, attachments);
        }
    },
    uploadFile: function(component, event, helper){
        var uploadedFiles = component.get("v.files");
        var singleFile = event.getParam("files");
        //console.log('document Id2-->'+singleFile.get('documentId'));
        for(var i = 0; i < singleFile.length; i++){
            console.log('elements--'+JSON.stringify(singleFile[i].documentId));
            uploadedFiles.push(JSON.stringify(singleFile[i].documentId));
        }
        component.set("v.files", uploadedFiles);
    }
})