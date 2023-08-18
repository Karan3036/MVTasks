public with sharing class EmailHandler {
    @AuraEnabled(cacheable=true)
    public static void sendEmailToController(String email, String Subjects, String Mail, String cvid){
        
        try{
            ContentVersion conVer=[Select Id,PathOnClient,FileType,Title,ContentSize,VersionData FROM ContentVersion WHERE Id =: cvid LIMIT 1];
            String mimeBody = '';
            String boundary = '__ctrlq_dot_org__';  
HttpRequest req = new HttpRequest();
String toAddress = email;
String subject = Subjects;
String mailBody = Mail;    
     
//req.setHeader('Content-Length', mbody.length() + '');
req.setHeader('Content-Type', 'application/json');
// req.setHeader('Content-Encoding', 'UTF-8'); 
// req.setEndpoint(‘callout:Gmail_API/upload/gmail/v1/users/aksh66622@gmail.com/messages/send?uploadType=media’);


req.setEndpoint('callout:Gmail_API/gmail/v1/users/aksh66622@gmail.com/messages/send');
//req.setEndpoint('https://gmail.googleapis.com');
    if(conVer.FileType == 'jpeg' || conVer.FileType == 'png'){
    mimeBody += 'Content-Type:image/'+conVer.FileType+';name='+conVer.Title+'\n';

    }
    else if(conVer.FileType == 'pdf') {
    mimeBody += 'Content-Type:application/'+conVer.FileType+';name='+conVer.Title+'\n';
    }

    // mimeBody += 'Content-Disposition: attachment; filename=”'+conVer.PathOnClient+'”\n';
    // mimeBody += 'Content-Transfer-Encoding: base64\n\n';

    mimeBody += Encodingutil.base64Encode(conVer.VersionData)+'\n\n';

    

    mimeBody += '--'+boundary+'--';
    System.debug('mimeBody' + mimeBody);


// system.debug(mbody);
req.setMethod('POST');     
      
 
        String mbody = '{ "raw" : "' + EncodingUtil.base64Encode(Blob.valueof( 'To: ' + toAddress + '\r\nContent-Type:text/plain; charset=utf-8;\r\nSubject: ' + subject + '\r\n\r\n' + mailBody + '\r\n\r\nAttachment: ' + mimeBody))  + '"}';
        req.setHeader('Content-Length', mbody.length() + mimeBody.length() + '');
        req.setBody(mbody);
        // req.setFileAttachment(mimeBody);
      //  req.setBodyAsBlob(bodyBlob);

        // req.setFileAttachment(mimeBody);


        System.debug(mbody);

// Send the request, and return a response
Http h = new Http();
HttpResponse res = h.send(req);
system.debug(res);
            // }
           
        }catch(Exception ex){
            System.debug(ex.getMessage() + ':' + ex.getLineNumber());
            
        }

    
    }
}