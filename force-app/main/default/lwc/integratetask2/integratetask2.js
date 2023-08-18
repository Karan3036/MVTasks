import { LightningElement,track, wire,api } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import CONTACT_EMAIL from '@salesforce/schema/Contact.Email';
import sendfile from "@salesforce/apex/DropboxController.uploadFileByRecord";
import deletefiles from "@salesforce/apex/DropboxController.deletefilebyname";
import getfiles from "@salesforce/apex/DropboxService.getfile";
export default class Gmailintegration extends LightningElement {
    @api recordId; 
    cv;
    @track showSpinner = false; //used for when to show spinner
    @track fileName; //to display the selected file name
    @track tableData;
    file; //holding file instance
    myFile;    
    fileType;//holding file type
    fileReaderObj;
    base64FileData;
    @wire(getRecord, { recordId: '$recordId', fields: [CONTACT_EMAIL] }) contactRecord;
    get email() {
      return getFieldValue(this.contactRecord.data, CONTACT_EMAIL);
    }
    handleUploadFinished(event){
        this.cv = event.detail.files[0].contentVersionId
    }
    @track outputText;
    deletefile() {
        this.outputText = this.template.querySelector('lightning-input').value;
        console.log(this.outputText);
        alert("Deleting a file");
        deletefiles({filenametoDelete: this.outputText});
    }
    handleFinish(){
        alert("Sending a file");
        console.log("finish method call");
        sendfile({recordId: this.recordId, cvid: this.cv});
        console.log(this.recordId);
        console.log(this.cv);
    }
    getfiless(){
        alert("Getting a list of files");
        getfiles()
        .then(data => {
         let kam = '';
            // let objData = { File_Id : '',File_Name : '' };

            window.console.log('jsonResponse ===> '+JSON.stringify(data));
            // retriving the response data
            // let exchangeData = data['entries'];
            let exchangeData = data.entries;
            console.log('exk',exchangeData);
            console.log(exchangeData[1].name);
            // adding data object
            // objData.File_Id = exchangeData['id'];
            // console.log(objData.File_Id);
            for(let i = 0; i < 2; i++){
                let objData ={File_Id : '', File_Name : ''};
            objData.File_Name = exchangeData[i].name;
            objData.File_Id = exchangeData[i].id;
             console.log({objData});
             kam = objData;
                }
                // console.log({objData});
            // adding data object to show in UI
            this.tableData = kam;
            console.log(this.tableData);
        })
        .catch(error => {
            console.log("in catch");
            console.log({error});
        })
    }
    }