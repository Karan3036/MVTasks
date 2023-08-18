import { LightningElement, track,api } from 'lwc';
import sendFile from "@salesforce/apex/DropBoxCtrl.sendFile";
export default class integrationtask2 extends LightningElement {
    cv;
    get acceptedFormats() {
        return ['.pdf','.png','.jpg','.jpeg'];
    }
    handleUploadFinished(event){
        
        this.cv = event.detail.files[0].contentVersionId;
        console.log(this.cv);
    }
    handleSend(){
        console.log('handle finish ');
       
        alert('File Sent');
        console.log(this.cv);
        sendFile({cvid: this.cv});
   
}
}