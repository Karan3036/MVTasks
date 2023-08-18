public class GmailApiNamedCredential {
    @AuraEnabled
    public static string sendemail(String email, String Subjects, String Mail, String cvid){
        System.debug(email);
        System.debug(Subjects);
        System.debug(Mail);
        System.debug(cvid);
        try {
            
            list<ContentVersion> conVer=[Select Id,PathOnClient,FileType,Title,ContentSize,VersionData FROM ContentVersion WHERE Id =: cvid];
            System.debug(conVer);
            String mimeBody = '';
            
            String nl = '\'';
            
            String boundary = '__ctrlq_dot_org__';   
            
            mimeBody += 'MIME-Version: 1.0\n';
            
            mimeBody += 'To:'+email+'\n';
            
            
            mimeBody += 'Subject:'+Subjects+'\n';
            
            mimeBody += 'Hello Testing\n';
            
            mimeBody += 'Content-Type: multipart/mixed; boundary='+boundary+'\n';
            
            mimeBody += '--'+boundary+'\n';
            
            mimeBody += 'Content-Type: text/plain; charset=UTF-8\n';
            
            mimeBody += 'Content-Transfer-Encoding: base64\n';
            
            mimeBody += EncodingUtil.base64Encode(blob.valueOf(Mail))+'\n\n';
            
            mimeBody += '--'+boundary+'\n';
            
            mimeBody +='Content-Type: text/html; charset=UTF-8\n';
            
            mimeBody += 'Content-Transfer-Encoding: base64\n\n';

            mimeBody += EncodingUtil.base64Encode(blob.valueOf(Mail))+'\n\n';
            
            mimeBody += '--'+boundary+'\n';
            
               for(ContentVersion cv:conVer){
            if(cv.FileType == 'jpeg' || cv.FileType == 'png'){
                mimeBody += 'Content-Type:image/'+cv.FileType+';name='+cv.Title+'\n';

            }
            else if(cv.FileType == 'pdf') {
                mimeBody += 'Content-Type:application/'+cv.FileType+';name='+cv.Title+'\n';
            }
            
            mimeBody += 'Content-Disposition: attachment; filename=”'+cv.PathOnClient+'”\n';
            
            mimeBody += 'Content-Transfer-Encoding: base64\n\n';
            
            mimeBody += Encodingutil.base64Encode(cv.VersionData)+'\n\n';
            
            }
            
            mimeBody += '--'+boundary+'--';
            System.debug(mimeBody);
            Http http = new Http();
            
            HttpRequest req = new HttpRequest();  
            
            req.setEndpoint('callout:Gmail_API/gmail/v1/users/aksh66622@gmail.com/messages/send');
            
            //(Gmail_API)API Name of Name credential
            
               req.setHeader('Authorization', 'Bearer ');
            
               req.setHeader('Content-Type', 'message/rfc822');
            
               req.setBody('{ "raw" : "' + mimeBody  + '"}');
            
               req.setMethod('POST');
            
               req.setTimeout(1 * 10000);
            
               system.debug('req——>>'+req);
            
            HttpResponse response = http.send(req);
            
               system.debug('response——>>'+response.getBody());
            
               System.debug(response);
            
            if (response.getStatusCode() != 201) {
            
                   System.debug('The status code returned was not expected: ' +
                        response.getStatusCode() + '' + response.getStatus());  
            
            } else {
            
                   System.debug(response.getBody());
            
            }  
            
            return null;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}