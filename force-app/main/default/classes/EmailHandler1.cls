public with sharing class EmailHandler1 {
    @AuraEnabled
    // OG AT EH2
    public static string sendEmailToController(String email, String Subjects, String Mail, String cvid, String emailTemplateId){
        
        try{
            String mailBody1 = '';
            if (emailTemplateId != null) {
                EmailTemplate template = [SELECT Id, Body FROM EmailTemplate WHERE Id = :emailTemplateId];
                mailBody1 = template.Body;
            }
            list<ContentVersion> conVer = new List<ContentVersion>();
            if (cvid != null) {
                conVer = [Select Id, PathOnClient, FileType, Title, ContentSize, VersionData FROM ContentVersion WHERE Id =: cvid]; 
            }
            List<String> emailList = email.split(' ');
            for (String toAddress : emailList) {
            System.debug(toAddress);
            String subject = Subjects;
            String mailBody = Mail;
            //String mailBody1 = template.Body;
            System.debug(mailBody1);
            System.debug(conVer);
            String mimeBody = '';
            
            String nl = '\'';
            
            String boundary = '__ctrlq_dot_org__';   
            
            mimeBody += 'MIME-Version: 1.0\n';
            
            mimeBody += 'To:'+toAddress+'\n';
            
            
            mimeBody += 'Subject:'+Subjects+'\n';
            
            mimeBody += 'Hello Testing\n';
            
            mimeBody += 'Content-Type: multipart/mixed; boundary='+boundary+'\n';
            
            mimeBody += '--'+boundary+'\n';
            
            mimeBody += 'Content-Type: text/plain; charset=UTF-8\n';
            
            mimeBody += 'Content-Transfer-Encoding: base64\n';
            
            mimeBody += EncodingUtil.base64Encode(blob.valueOf(mailBody1+' '+Mail))+'\n\n';
            
            mimeBody += '--'+boundary+'\n';
            
            mimeBody +='Content-Type: text/html; charset=UTF-8\n';
            
            mimeBody += 'Content-Transfer-Encoding: base64\n\n';

            mimeBody += EncodingUtil.base64Encode(blob.valueOf(mailBody1+' '+Mail))+'\n\n';
            
            mimeBody += '--'+boundary+'\n';
            
               for(ContentVersion cv:conVer){
            if(cv.FileType == 'jpg' || cv.FileType == 'png' || cv.FileType == 'jpeg'){
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
            
            HttpRequest req1 = new HttpRequest();  
            
            req1.setEndpoint('callout:Gmail_API/upload/gmail/v1/users/aksh66622@gmail.com/messages/send?uploadType=media');
            
            //(Gmail_API)API Name of Name credential
            
               req1.setHeader('Authorization', 'Bearer ');
            
               req1.setHeader('Content-Type', 'message/rfc822');
            
               req1.setBody('{ "raw" : "' + mimeBody  + '"}');
            
               req1.setMethod('POST');
            
               req1.setTimeout(60 * 1000);
            
               system.debug('req——>>'+req1);
            
            HttpResponse response = http.send(req1);
            
               system.debug('response——>>'+response.getBody());
            
               System.debug(response);
            
            if (response.getStatusCode() != 200) {
            
                   System.debug('The status code returned was not expected: ' +
                        response.getStatusCode() + '' + response.getStatus());  
            
            } else {
            
                   System.debug(response.getBody());
            
            }  
            } 
            return null;
        } catch (Exception e) {
            System.debug(e.getMessage() + ':' + e.getLineNumber());
            return null;
        }    



    
    }
}