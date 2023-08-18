global class futuremethod01 {
@future
    webservice static void future(Id studentId) {
        System.debug(studentId);
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://source.unsplash.com/random');
        req.setMethod('GET');
        
        HttpResponse response = h.send(req);
        String responseBody = response.getBody();
        System.debug(responseBody);
        String img_link = responseBody.substring(responseBody.indexof('https://'), responseBody.indexof('1080'));
        System.debug(img_link);
        
        HttpRequest req1 = new HttpRequest();
        req1.setEndpoint(img_link);
        req1.setMethod('GET');
        Http h1 = new Http();
        HttpResponse response1 = h1.send(req1);
        Blob image = response1.getBodyAsBlob();
        Attachment at = new Attachment(ParentId = studentId, Name = 'image.png',Body = image );
        insert at;
        
    }
}