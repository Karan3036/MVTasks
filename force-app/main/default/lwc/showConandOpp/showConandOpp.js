import { LightningElement, track, wire } from 'lwc';
import { createMessageContext, releaseMessageContext,APPLICATION_SCOPE,subscribe, unsubscribe } from 'lightning/messageService';
import SAMPLEMC from "@salesforce/messageChannel/SampleMessageChannel__c";
import findContactByAccountId from '@salesforce/apex/ConOppController.findContactByAccountId';
import findOpportunityByAccountId from '@salesforce/apex/OppController.findOpportunityByAccountId';

export default class showConandOpp extends LightningElement {
    context = createMessageContext();
    subscription = null;
    @track receivedMessage = '';
    @track accountId;

    @track columns = [
        { label: 'First Name', fieldName: 'FirstName' },
        { label: 'Last Name', fieldName: 'LastName'},
        { label: 'Email', fieldName: 'Email', type: 'email' }
    ];
   @track contactList;


   @wire (findContactByAccountId,{accountId:'$accountId'}) wiredAccount({data,error}){
        if (data) {
             this.contactList = data;
        console.log(data); 
        } else if (error) {
        console.log(error);
        }
   }

   @track columns1 = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Stage Name', fieldName: 'StageName'},
    { label: 'Close Date', fieldName: 'CloseDate', type: 'date' }
];
@track opportunityList;

@wire (findOpportunityByAccountId,{accountId:'$accountId'}) wiredAccounts({data,error}){
    if (data) {
         this.opportunityList = data;
    console.log(data); 
    } else if (error) {
    console.log(error);
    }
}
    // @track objectApiName1='Account';
    // fields1 = [NAME_FIELD, STAGE_NAME, CLOSE_DATE];
    // @track objectApiName2='Account';
    // fields2 = [NAME, EMAIL];
    // columns1 =  [
    //     { label: 'First Name', fieldName: 'FirstName' },
    //     { label: 'Last Name', fieldName: 'LastName'},
    //     { label: 'Email', fieldName: 'Email', type: 'email' },    
    // ];
    // @api accountId;
    // @wire(findContactByAccountId,{accountId:'$accountId'}) contacts;
    // columns2 =  [
    //     { label: 'Name', fieldName: 'Name' },
    //     { label: 'Stage Name', fieldName: 'StageName'},
    //     // { label: 'Email', fieldName: 'Email', type: 'email' },    
    // ];
    // @api accountId;
    // @wire(findOpportunityByAccountId,{accountId:'$accountId'}) Opportunities;
    connectedCallback(){
        this.subscribeMC();
    }
    subscribeMC() {
        if (this.subscription) {
            return;
        }
        this.subscription = subscribe(this.context, SAMPLEMC, (message) => {
            this.handleMessage(message);
        },{scope: APPLICATION_SCOPE});
     }
     handleMessage(message) {       
        console.log('message:::'+JSON.stringify(message));
        this.accountId = message.recordId;
        this.recordId = message.recordId;
        this.receivedMessage = message ? message.recordData.value : 'no message payload';
    }
}