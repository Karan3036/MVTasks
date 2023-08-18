public class DropBoxCtrl {
    @AuraEnabled
    public static string sendFile(String cvid){
        System.debug(cvid);
        try {
            
            list<ContentVersion> conVer=[Select Id,PathOnClient,FileType,Title,ContentSize,VersionData FROM ContentVersion WHERE Id =: cvid];
            System.debug(conVer);
            String mimeBody = '';
            
            String nl = '\'';
            
            String boundary = '__ctrlq_dot_org__';   
            
            mimeBody += 'MIME-Version: 1.0\n';
            
               for(ContentVersion cv:conVer){
            if(cv.FileType == 'jpg' || cv.FileType == 'png'){
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
            
            req.setEndpoint('https://content.dropboxapi.com/2/files/upload');
            
               req.setHeader('Authorization', 'Bearer ' + 'sl.BWok8PTcLju1GlxSc-7qX2wMvYnxbxKvqza-mV5GeZkBrHZ2-mUTjx4VCYuJsG-0QKGC7k61xKDlUwnwEKP6v0z2uM_nUrymsClyJ5pVZUaZEBIeIXVoxgR0rrY94BvYpJpQzX9u4LD9');
            
              // req.setHeader('Content-Type', 'message/rfc822');
                req.setHeader('Content-Type', 'application/octet-stream');
               req.setHeader('Dropbox-API-Arg','{"path":"/ ","mode":"add","autorename":true,"mute":false,"strict_conflict":false}');
            
               req.setBody('{ "raw" : "' + mimeBody  + '"}');
            
               req.setMethod('POST');
            
               req.setTimeout(6 * 1000);
            
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
            System.debug(e.getMessage() + ':' + e.getLineNumber());
            return null;
        }
    }
}