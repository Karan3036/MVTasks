public with sharing class dbct {
     
    private String apiKey;
    private String apiSecret;
    private String redirectURI;
    private String Dropbox_Account_endpoint;
    private String Dropbox_files_endpoint;
    private String Dropbox_OAuth_authorize;
    private String Dropbox_OAuth_token;
    private String authorizationCode;
    private String refreshToken;
     
    public String code { get; set; }
    public String username { get; set; }
    public String fileName { get; set; }
    public Blob fileBody { get; set; }
    public Boolean success { get; set; }
    public Boolean connected { get; set; }
    public Boolean isError{get;set;}
    public String errorMessage{get;set;}
    public String successMessage{get;set;}
    public Boolean isSuccess{get;set;}
    public dbct() {
        connected = false;
        success = false;
        successMessage = '';
        apiKey = '4iuuixqxklmcd7g'; // this is your dropbox apikey
        apiSecret = 'c5hzp9rw73v10h3'; // this is your dropbox api secret
        redirectURI = 'https://mvclouds36-dev-ed.develop.lightning.force.com/lightning/n/Dropbox'; // url of the vf page in which the dropbox login is done
        Dropbox_Account_endpoint = 'https://api.dropboxapi.com/2/users/get_current_account';
        Dropbox_files_endpoint = 'https://content.dropboxapi.com/1/files_put/auto/';
        Dropbox_OAuth_authorize = 'https://www.dropbox.com/oauth2/authorize';
        Dropbox_OAuth_token = 'https://api.dropboxapi.com/oauth2/token';
         
        code = ApexPages.currentPage().getParameters().get('code');
        if(code != null) {
            connected = true;
            authorizationCode = code;
            getAccessToken();
            fetchUserInfo();
        }
    }
     
    public PageReference getAuthorizationCode() {
        String uri = Dropbox_OAuth_authorize +
                     '?client_id=' + apiKey +
                     '&response_type=code' +
                     '&redirect_uri=' + redirectURI;
        PageReference pr = new PageReference(uri);
        pr.setRedirect(true);
        return pr;
    }
     
    private void getAccessToken() {
        if(authorizationCode != null) {
            try {
                Http h = new Http();
                HttpRequest req = new HttpRequest();
                  
                req.setEndpoint(Dropbox_OAuth_token);  
                string bodyRequest = '';
                bodyRequest = 'code=' + EncodingUtil.urlEncode(authorizationCode, 'UTF-8');
                bodyRequest+= '&client_id=' + EncodingUtil.urlEncode(apiKey, 'UTF-8');
                bodyRequest+= '&client_secret=' + EncodingUtil.urlEncode(apiSecret, 'UTF-8');
                bodyRequest+= '&redirect_uri=' + EncodingUtil.urlEncode(redirectURI, 'UTF-8');
                bodyRequest+= '&grant_type=authorization_code';
                 
                req.setBody(bodyRequest);    
                req.setHeader('Content-length', string.ValueOf(bodyRequest.length()));
                req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                req.setMethod('POST');
                req.setTimeout(60*1000);
                 
                HttpResponse res = h.send(req);  
                system.debug(res.getBody());
                map<string, string> jsonValues = new map<string, string>();
                jsonValues = parseJSONToMap(res.getBody());
                if(jsonValues.containsKey('error')) {
                    isError = true;
                    errorMessage = 'Could not connect to DropBox!!';
                    connected = false;
                }
                else {
                   connected = true;
                   isSuccess = true;
                   refreshToken = jsonValues.get('access_token');
                }
            }
            catch(Exception e) {
                isError = true;
                errorMessage = 'Could not connect to DropBox!!';
            }
        }
        else{ 
            isError = true;
            errorMessage = 'Could not connect to DropBox!!';
        }
    }
     
     
    // method that returns the user data of the connected dropbox account
    private void fetchUserInfo() {
         
        if(refreshToken != null) {
            try {
                Http h = new Http();
                HttpRequest req = new HttpRequest(); 
                req.setEndpoint(Dropbox_Account_endpoint);
                req.setHeader('Authorization', 'Bearer '+refreshToken);
                req.setMethod('POST');
                req.setTimeout(60*1000);
                HttpResponse res = h.send(req);
                system.debug(res.getBody());
                Map<string, string> jsonValues = new Map<string, string>();
                jsonValues = parseJSONToMap(res.getBody());
                if(jsonValues.containsKey('error')){
                   isError = true;
                   errorMessage = 'Could not connect to DropBox!!';
                }
                else {
                     username = jsonValues.get('email');
                     isSuccess = true;
                     successMessage = 'DropBox Account : '+ username + ' Connect Successfully';
                }
            }
            catch(Exception e) {
                isError = true;
                errorMessage = 'Could not connect to DropBox!!';
            }
        }
    }
     
    public void createFolder(){
        isError = false;
        String endPoint = 'https://api.dropboxapi.com/2/files/create_folder_v2';
        String body = '{"path": "/Test","autorename": false}';
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        req.setEndpoint(endpoint);
        req.setHeader('Authorization', 'Bearer '+refreshToken);
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('POST');
        req.setBody(body);
        res = http.send(req);
        Map<string, string> jsonDataMap = new Map<string, string>();
        jsonDataMap = parseJSONToMap(res.getBody());
        if(jsonDataMap.containsKey('error')){
            isError = true;
            errorMessage = 'Create Folder Process failed!!';
        }
        else {
            successMessage = 'Folder Created Successfully!!';
            isSuccess = true;
        }
    }
     
    public void deleteFolderOrFile(){
        String endPoint = 'https://api.dropboxapi.com/2/files/delete_v2';
        String body = '{"path": "/Test"}';
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setHeader('Authorization', 'Bearer '+refreshToken);
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('POST');
        req.setBody(body);
        HttpResponse res = http.send(req);
        system.debug(res);
        Map<string, string> jsonDataMap = new Map<string, string>();
        jsonDataMap = parseJSONToMap(res.getBody());
        if(jsonDataMap.containsKey('error')){
            isError = true;
            errorMessage = 'Delete Folder Process failed!!';
        }
        else {
            successMessage = 'Folder Deleted Successfully!!';
            isSuccess = true;
        }
    }
     
    // method that uploads files to dropbox
    public void uploadToDropBox(Blob file, String filename) {
        try {
            String boundary = '----------9889464542212';
            String bodyEncoded = EncodingUtil.base64Encode(file);
            Blob bodyEncoded2 = EncodingUtil.base64Decode(bodyEncoded);
            String body = '{ "path": "/Homework/math/1.jpg", "mode": "add", "autorename": true, "mute": false, "strict_conflict": false }';
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            String endpoint = 'https://content.dropboxapi.com/2/files/upload';
            //req.setEndpoint('callout:SalesforceBox/2/files/upload');
            req.setEndpoint(endpoint);
            req.setHeader('Authorization', 'Bearer '+refreshToken);
            req.setHeader('Dropbox-API-Arg', body);
            req.setHeader('Content-Type', 'application/octet-stream');
            req.setHeader('Content-length', String.valueOf(bodyEncoded.length()));
            req.setBody(body);
            req.setBodyAsBlob(bodyEncoded2);
            req.setMethod('POST');
            req.setTimeout(60*1000);
            HttpResponse resp = http.send(req);
            system.debug(resp.getBody());
            map<string, string> jsonDataMap = new map<string, string>();
            jsonDataMap = parseJSONToMap(resp.getBody());
            if(jsonDataMap.containsKey('error')){
                isError = true;
                errorMessage = 'Error:'+jsonDataMap.get('error');
            } else{
                  successMessage = 'File Upload Successfully!!';
                  isSuccess = true;
              }
        }
        catch(Exception e) {
            isError = true;
            errorMessage = 'Files couldn\'t be uploaded to Dropbox.';
        }
    }
     
    private map<string, string> parseJSONToMap(string JSONValue){
        JSONParser parser = JSON.createParser(JSONValue);
        map<string, string> jsonMap = new map<string, string>();
        string keyValue = '';
        string tempValue = '';
        while (parser.nextToken() != null) {
            if(parser.getCurrentToken() == JSONToken.FIELD_NAME){
                keyValue = parser.getText();
                parser.nextToken();
                tempValue = parser.getText();
                jsonMap.put(keyValue, tempValue);            
            }
        }
        return jsonMap;
    }
     
    public void uploadFiles() {
        uploadToDropBox(fileBody, fileName);
    }
}