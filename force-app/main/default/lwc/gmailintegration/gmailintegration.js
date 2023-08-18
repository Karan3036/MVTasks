import { LightningElement,track, wire,api } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
//import getContacts from "@salesforce/apex/ContactHelper.getContacts";
import CONTACT_EMAIL from '@salesforce/schema/Contact.Email';
//import sendEmail from "@salesforce/apex/GmailApiNamedCredential.sendemail";
import sendEmail from "@salesforce/apex/EmailHandler1.sendEmailToController";
//import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class Gmailintegration extends LightningElement {
    @api recordId; 
    cv;
    //selectedFilesToUpload = []; //store selected files
    @track showSpinner = false; //used for when to show spinner
    @track fileName; //to display the selected file name
    file; //holding file instance
    myFile;    
    fileType;//holding file type
    fileReaderObj;
    base64FileData;
    @wire(getRecord, { recordId: '$recordId', fields: [CONTACT_EMAIL] }) contactRecord;
    get email() {
      return getFieldValue(this.contactRecord.data, CONTACT_EMAIL);
    }
    getsubject(event){
        this.emailsubject = event.target.value;
    }
    getbody(event){
        this.emailbody = event.target.value;
    }
      
    handleUploadFinished(event){
        
        this.cv = event.detail.files[0].contentVersionId;
        console.log(this.cv);
    }
    handleFinish(){
        console.log('handle finish ');
       
        alert('Email Sent');
        console.log("finish method call");
        console.log(this.email);
        console.log(this.emailsubject);
        console.log(this.emailbody);
        console.log(this.cv);
        // console.log(this.fileName);
        // console.log(this.fileType);
        // console.log(this.base64FileData);
        sendEmail({ email: this.email, Subjects: this.emailsubject, Mail: this.emailbody, cvid: this.cv});
        
            
    }
    }