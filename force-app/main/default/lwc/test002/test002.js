import { LightningElement,track, wire } from 'lwc';
import getLead from "@salesforce/apex/LeadHelper.getLeads";
import getAccountList from "@salesforce/apex/AccountHelper.getAccounts";
import getContacts from "@salesforce/apex/ContactHelper.getContacts";
import sendEmail from "@salesforce/apex/EmailHandler1.sendEmailToController";
import getEmailTemplates from '@salesforce/apex/tempo.getEmailTemplates';

export default class EmailSendingWizard extends LightningElement {
    @track currentStep = '1';
    isStepOne = false;
    acctrue = false;
    contrue = false;
    leadtrue = false;
    @track selected;
    @track accountList;
    @track leadlist;
    @track contlist;

//------------------------------------------------------------------------------------    
    @track selectedTemplate;

  @wire(getEmailTemplates)
  emailTemplates;

  handleTemplateChange(event) {
    this.selectedTemplate = event.target.value;
    console.log(this.selectedTemplate);
  }

  get emailTemplateOptions() {
    if (!this.emailTemplates || !this.emailTemplates.data) {
      return [];
    }
    return this.emailTemplates.data.map(template => {
      return { label: template.Name, value: template.Id };
    });
  }
  

 //--------------------------------------------------------------------------------------------------------- 
 
 
 pageSizeOptions = [5, 10, 25, 50, 75, 100]; //Page size options
 records = []; // All records available in the data table
 //columns = []; //columns information available in the data table
 totalRecords = 0; //Total no.of records
 pageSize; //No.of records to be displayed per page
 totalPages; //Total no.of pages
 pageNumber = 1; //Page number    
 recordsToDisplay = []; //Records to be displayed on the page
 get bDisableFirst() {
     return this.pageNumber == 1;
 }
 get bDisableLast() {
     return this.pageNumber == this.totalPages;
 }
//  @api recordId;
//  @track lstAllFiles;
//  @track error;
 

//  handleUploadFinished(event) {
//      this.connectedCallback();
//  }

//  connectedCallback() {
//      fetchFiles({recordId:this.recordId})
//      .then(result=>{
//          // this.lstAllFiles = result; 
//          this.error = undefined;
//          // console.log('RESULT--> ' + JSON.stringify(result));
//                  this.records = result;
//                  this.totalRecords = result.length; // update total records count                 
//                  this.pageSize = this.pageSizeOptions[0]; //set pageSize with default value as first option
//                  this.paginationHelper(); // call helper menthod to update pagination logic 
//      }).catch(error=>{
//          this.lstAllFiles = undefined; 
//          this.error = error;
//      })
     
//  }
 
 handleRecordsPerPage(event) {
     this.pageSize = event.target.value;
     this.paginationHelper();
 }
 previousPage() {
     this.pageNumber = this.pageNumber - 1;
     this.paginationHelper();
 }
 nextPage() {
     this.pageNumber = this.pageNumber + 1;
     this.paginationHelper();
 }
 firstPage() {
     this.pageNumber = 1;
     this.paginationHelper();
 }
 lastPage() {
     this.pageNumber = this.totalPages;
     this.paginationHelper();
 }
 // JS function to handel pagination logic 
 paginationHelper() {
     this.recordsToDisplay = [];
     // calculate total pages
     this.totalPages = Math.ceil(this.totalRecords / this.pageSize);
     // set page number 
     if (this.pageNumber <= 1) {
         this.pageNumber = 1;
     } else if (this.pageNumber >= this.totalPages) {
         this.pageNumber = this.totalPages;
     }
     // set records to display on current page 
     for (let i = (this.pageNumber - 1) * this.pageSize; i < this.pageNumber * this.pageSize; i++) {
         if (i === this.totalRecords) {
             break;
         }
         this.recordsToDisplay.push(this.records[i]);
         console.log(this.recordsToDisplay);
     }
 }
 
 








 //----------------------------------------------------------------------------------------------------------

    @wire (getLead) lead({data}){
        if(data){
            this.leadlist = data;
            console.log(data);
        }
    };
    @wire (getContacts) Contact({data}) {
        if (data) {
            this.contlist = data;
            console.log(data);
        }
    };
    @wire (getAccountList) Account({data}){
        if (data) {
            this.accountList = data;
            console.log(data);
        }
    };
    @track acc = [
        { label: 'Account Name', fieldName: 'Name' },
        { label: 'Email', fieldName: 'Email__c'}
    ];
    @track con = [
        {label : 'First Name' , fieldName : 'FirstName'},
        {label : 'Last Name' , fieldName : 'LastName'},
        {label : 'Email' , fieldName : 'Email'}
    ] 
    @track lea = [
        {label : 'Lead Name' , fieldName : 'Name'},
        {label : 'Email' , fieldName : 'Email'}

    ]
    value = '';
    connectedCallback(){
        this.isStepOne = true;
        console.log('isStepOne');
        this.acctrue = false;
        console.log('acctrue');
        this.contrue = false;
        console.log('contrue');
        this.leadtrue = false;
        console.log('leadtrue');
        
    }
    get options() {
        return [
            { label: 'Lead', value: 'Lead' },
            { label: 'Account', value: 'Account' },
            { label: 'Contact', value: 'Contact' },
        ];
    }
    
    handleChange(event) {
        this.value = event.detail.value;
        this.selected = event.detail.value;
        console.log(this.selected);
        if (this.value == 'Lead') {
            console.log("lead function call");
            this.totalRecords = this.leadlist.length;
            this.pageSize = this.pageSizeOptions[0]; //set pageSize with default value as first option
            this.paginationHelper(); // call helper menthod to update pagination logic 
            this.records = this.leadlist;
            this.leadtrue = true;
            this.acctrue = false;
            this.contrue = false;
            
        } 
        else if(this.value == 'Account'){
            console.log("Account function call");
            this.totalRecords = this.accountList.length;
            this.pageSize = this.pageSizeOptions[0]; //set pageSize with default value as first option
            this.paginationHelper(); // call helper menthod to update pagination logic 
            this.records = this.accountList;
            this.contrue = false;
            this.acctrue = true;
            this.leadtrue = false;   
        }
        else if(this.value == 'Contact'){
            console.log("contact function call");
            this.totalRecords = this.contlist.length;
            this.pageSize = this.pageSizeOptions[0]; //set pageSize with default value as first option
            this.paginationHelper(); // call helper menthod to update pagination logic 
            this.records = this.contlist;
            this.contrue = true;
            this.acctrue = false;
            this.leadtrue = false;
        }
    }
 
    get isStepOne() {
        return this.currentStep === "1";
    }
 
    get isStepTwo() {
        return this.currentStep === "2";
    }
 
    get isStepThree() {
        return this.currentStep === "3";
    }
 
    get isEnableNext() {
        return this.currentStep != "3";
    }
 
    get isEnablePrev() {
        return this.currentStep != "1";
    }
 
    get isEnableFinish() {
        return this.currentStep === "3";
    }

    getid(event){
        console.log(event.name);
    }
    handleNext(){
        if(this.currentStep == "1"){  
            console.log("goto page 2");
            this.currentStep = "2";
            this.isStepOne = false;
        }
        else if(this.currentStep = "2"){
              
            var selectedRecords =  this.template.querySelector("lightning-datatable").getSelectedRows();
            if(selectedRecords.length > 0){
                console.log('selectedRecords are ', selectedRecords);
                var email = ' ';
                selectedRecords.forEach(currentItem => {
                    if(this.acctrue == true){
                        email += currentItem.Email__c + ' ';
                    }
                    else{
                        email += currentItem.Email + ' ';
                    }
                });
                this.email = email.replace(' ', '');
                this.email = email.replace(' ','');
                console.log(this.email);
            }   
            console.log("goto page 3");
            this.currentStep = "3";
            this.isStepOne = false;
            this.isStepTwo = false;

        }  
        else if(this.currentStep = "3"){
            console.log(this.emailsubject);
            console.log(this.emailbody);
            console.log("goto page 3");
            this.currentStep = "1";
            this.isStepOne = false;
            this.isStepTwo = false; 
        } 
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
    handlePrev(){
        if(this.currentStep == "3"){
            console.log("goto page 2");
            this.currentStep = "2";
        }
        else if(this.currentStep = "2"){
            console.log("goto page 1");
            this.currentStep = "1";
            this.isStepOne = true;
        }
    }
 
    handleFinish(){
        console.log('handle finish ');
       
        alert('Email Sent');
        console.log("finish method call");
        console.log(this.email);
        console.log(this.emailsubject);
        console.log(this.emailbody);
        console.log(this.cv);
        
        sendEmail({ email: this.email, Subjects: this.emailsubject, Mail: this.emailbody, cvid: this.cv, emailTemplateId: this.selectedTemplate});
    }
}