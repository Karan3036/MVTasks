import { LightningElement,api,wire,track } from 'lwc';
import getForm from '@salesforce/apex/FieldSetController.getForm';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import 'c/customLookupField';
import abc from '@salesforce/apex/try0001.findId';
import xyz from '@salesforce/apex/UpdateRecord.updateField';
import getSecondLookupOptions from '@salesforce/apex/try001.findById';
import { CloseActionScreenEvent } from "lightning/actions";
export default class DynamicPageGenerator extends LightningElement {
    @api objectName;
    @api recordId;
    @api fieldSet;
    @track fields = [];
    @track options = [];
    @track value = '';
    @api isSuccess = false;
    @track values;
    @track ab;
    handleChange(event) {
        if(event.target.fieldName === 'AccountId') {
        let fieldApiName = event.target.name;
        console.log('fieldApiName ===>' + fieldApiName);
         let fieldValue = event.target.value;
         console.log('fieldValue ===>' + fieldValue);
         // Filter the fields to find the first lookup field
        let firstLookupField = this.fields.find(fields => fields.APIName === 'AccountId');
        console.log('firstLookupField ===>' + JSON.stringify(firstLookupField));
        // Filter the fields to find the second lookup field
        let secondLookupField = this.fields.find(fields => fields.APIName === 'Opportunity_Name__c');
        console.log('secondLookupField ===>',JSON.stringify(secondLookupField));
        // Make a server-side call to get the options for the second lookup field based on the value of the first lookup field
        getSecondLookupOptions({ accId: fieldValue })
            .then(result => {
                // Update the options of the second lookup field
                let options = result.map(item => item.Name);
                secondLookupField.options = options;
                this.options = result.map(item => item.Name);
                this.value = fieldValue;
                console.log('result ===>' , JSON.stringify(options));
                console.log('result ===>' , secondLookupField.options);
            })
            .catch(error => {
                console.log(error);
            });
    }
    }

    connectedCallback()
    {
        getForm({ recordId: this.recordId,objectName:'Contact', fieldSetName:'FieldSet'})
        .then(result => {
            console.log('Data:'+ JSON.stringify(result));
            if (result) {
                console.log('new object --> ',{result});
                let tfields= [];
                result.Fields.forEach(element => {
                    var checkBool = false;
                    if (element.APIName == 'Opportunity_Name__c') {checkBool = true} else {checkBool = false}
                    var temp1 = {APIName:element.APIName, IsRequired : element.IsRequired, checkOpp:checkBool};
                    console.log('temp1 --: ',{temp1});
                    tfields.push(temp1);
                });
                this.fields = tfields;
          
                this.error = undefined;
            }
        }) .catch(error => {
            console.log(error);
            this.error = error;
        });      
    }


    @api
    hanldeProgressValueChange(event) {
        this.values = event.detail;
        console.log('Value========>' + this.values);
        abc({ fieldvalue:this.values})
        .then(result => {
            console.log('Data:'+ JSON.stringify(result));
            if (result) {
                this.ab = result.Id;
                console.log(this.ab);          
                this.error = undefined;
                
            }
        }) .catch(error => {
            console.log(error);
            this.error = error;
        });  
    }

    saveClick(e)
    {   console.log('Record Id========>' + this.recordId);
        console.log('Value Id========>' + this.ab);  
        console.log('Vande Mataram');
        const inputFields = e.detail.fields;
       
        this.template.querySelector('lightning-record-edit-form').submit(inputFields);
        xyz({recordId:this.recordId,FieldValue:this.ab})  
        .then(result => {
           console.log('from apex');
        })  
        .catch(error => {
           console.log('error -> ',error);
        })
        this.dispatchEvent(new CloseActionScreenEvent());  
   




         
    }
    
    validateFields() {
        return [...this.template.querySelectorAll("lightning-input-field")].reduce((validSoFar, field) => {
            return (validSoFar && field.reportValidity());
        }, true);
        
    }
    handleSuccess(e)
    {
        this.showMessage('Record Saved Successfully','success');

    }
    handleError(e)
    {
        this.template.querySelector('[data-id="message"]').setError(e.detail.detail);
        e.preventDefault();
    }

    showMessage(message,variant)
    {
        const event = new ShowToastEvent({
            title: 'Record Save',
            variant: variant,
            mode: 'dismissable',
            message: message
        });
        this.dispatchEvent(event);
    }

    
}