public class futuremethod {
@future(callout=true)
    public static void myfuturemethod(){
Http httpObject = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://source.unsplash.com/random');
        request.setMethod('GET');
        
        HttpResponse response = httpObject.send(request);
        String responseBody = response.getBody();
        System.debug(responseBody);
        String img_link = responseBody.substring(responseBody.indexof('https://'), responseBody.indexof('1080')+4);
        System.debug(img_link);
        
        HttpRequest request1 = new HttpRequest();
        request1.setEndpoint(img_link);
        request1.setMethod('GET');
        Http httpObject1 = new Http();
        HttpResponse response1 = httpObject1.send(request1);
blob image = response1.getBodyAsBlob();
        
Attachment att = new Attachment(Name = 'Img', Body = image, ContentType = 'image/jpeg',ParentId='0065g00000TtN0xAAF');
insert att;
    }
}