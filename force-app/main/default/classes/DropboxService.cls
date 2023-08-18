public class DropboxService {
    public Boolean isError{get;set;}
     public String errorMessage{get;set;}
     public String successMessage{get;set;}
     public Boolean isSuccess{get;set;}
    public class Header
 {
     public string path{get;set;}
     public string mode{get;set;}
     public boolean autorename{get;set;}
     public boolean mute{get;set;}
     public boolean strict_conflict{get;set;}
     
 }
 private static string fileLocation(string file)
 {
     return '/karan/'+file;
 }
 private static string createHeaderArgs(string file)
 {
     Header header=new Header();
     header.path=fileLocation(file);
     header.mode='add';
     header.autorename=true;
     header.mute=false;
     header.strict_conflict=false;
     return JSON.serialize(header);
 }
     
 public static string Upload(ContentVersion content)
 {
     HttpRequest req = new HttpRequest();
     req.setHeader('Content-Type','application/octet-stream');
     req.setMethod('POST');
     req.setEndpoint('https://content.dropboxapi.com/2/files/upload');
     req.setBodyAsBlob(content.VersionData);
     string fileName=content.Title+'.'+content.FileExtension;
     req.setHeader('Dropbox-API-Arg', createHeaderArgs(content.Title+'.'+content.FileExtension));
     req.setHeader('Authorization','Bearer '+Label.DropBoxKey);
     req.setTimeout(120000);
     Http http = new Http();
     HTTPResponse res = http.send(req);
     system.debug('Response:'+res.getBody());
     return fileLocation(fileName);
 }

 public static void Deletefile(String fname){
    System.debug(fname);
    String endPoint = 'https://api.dropboxapi.com/2/files/delete_v2';
    // String body = '{"path": "/" '+ fname+'}';
    String body = JSON.serialize(new Map<String, Object>{'path'=>'/karan/'+fname});
    System.debug(body);
    Http http = new Http();
    HttpRequest req = new HttpRequest();
    req.setEndpoint(endpoint);
    req.setHeader('Authorization','Bearer '+Label.DropBoxKey);
    req.setHeader('Content-Type', 'application/json');
    req.setMethod('POST');
    req.setBody(body);
    HttpResponse res = http.send(req);
    system.debug(res);
 }
 @AuraEnabled
 public static map<String, Object> getfile(){
    String endPoint = 'https://api.dropboxapi.com/2/files/list_folder';
    String body = '{"path": "/karan"}';
    System.debug(body);
    Http http = new Http();
    HttpRequest req = new HttpRequest();
    req.setEndpoint(endpoint);
    req.setHeader('Authorization','Bearer '+Label.DropBoxKey);
    req.setHeader('Content-Type', 'application/json');
    req.setMethod('GET');
    req.setBody(body);
    HttpResponse res = http.send(req);
    system.debug(res);
    System.debug(res.getBody());



    map<String, Object> mapJsonData = new map<String, Object>();
        String strResponse = null;
    if (res.getStatusCode() == 200 ) {  
        strResponse = res.getBody();  
    } 
    else {  
        throw new CalloutException(res.getBody());  
    } 
    if(!String.isBlank(strResponse)) {
        mapJsonData = (map<String, Object>)JSON.deserializeUntyped(strResponse);
        System.debug('mapJsonData ===> '+mapJsonData);
        return mapJsonData;
    }

    // if(!mapJsonData.isEmpty()) {
    //     return mapJsonData;
    //     System.debug('mapJsonData ===> '+mapJsonData);
    // }
    else {
        return null;
    }  
 }

}