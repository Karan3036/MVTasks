import { LightningElement,track, wire } from 'lwc';
import getLead from "@salesforce/apex/LeadHelper.getLeads";
import getAccountList from "@salesforce/apex/AccountHelper.getAccounts";
import getContacts from "@salesforce/apex/ContactHelper.getContacts";
import sendEmail from "@salesforce/apex/EmailHandler.sendEmailToController";

export default class EmailSendingWizard extends LightningElement {
    @track currentStep = '1';
    isStepOne = false;
    acctrue = false;
    contrue = false;
    leadtrue = false;

    @track accountList;
    @track leadlist;
    @track contlist;
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
        if (this.value == 'Lead') {
            console.log("lead function call");
            this.leadtrue = true;
            this.acctrue = false;
            this.contrue = false;
            
        } 
        else if(this.value == 'Account'){
            console.log("Account function call");
            this.contrue = false;
            this.acctrue = true;
            this.leadtrue = false;   
        }
        else if(this.value == 'Contact'){
            console.log("contact function call");
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
            console.log("goto page 2");
            this.currentStep = "2";
            this.isStepOne = false;
        }
        else if(this.currentStep = "2"){
            console.log(this.emailsubject);
            console.log(this.emailbody);
            console.log("goto page 3");
            this.currentStep = "3";
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
        console.log("finish method call");
        console.log(this.email);
        console.log(this.emailsubject);
        console.log(this.emailbody);
        sendEmail({ toSend: this.email, subject: this.emailsubject, body: this.emailbody});
        // console.log("Sending email to", this.email);
        console.log(sendEmail);
    }
}