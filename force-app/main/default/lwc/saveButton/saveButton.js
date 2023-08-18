import { LightningElement, api } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class SaveButton extends LightningElement {
    @api record;
    @api Ages__c;
    handleSave() {
        let d1 = new Date( this.record.Birthdate );
        let d2 = new Date();

        let varAge = d2.getYear() - d1.getYear();
        console.log( varAge );

        if ( d1.getUTCMonth() < d2.getUTCMonth() ) {
            -varAge;
        }else if ( d1.getUTCMonth() === d2.getUTCMonth() ) {
            if ( d1.getUTCDate() < d2.getUTCDate() )
                -varAge;
        }   
        this.Ages__c = varAge;  
        if (this.Ages__c >= 18) {
            const emailIds = this.record.Email_Ids__c.split(',');
        const fields = {
            'FirstName': this.record.FirstName,
            'LastName': this.record.LastName,
            'Email' : emailIds[0],
            'Email_Ids__c': this.record.Email_Ids__c,
            'Birthdate': this.record.Birthdate,
            'User__c' : this.record.User__c
        };
        const recordInput = { apiName: 'Contact', fields };
        createRecord(recordInput)
            .then(record => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record created',
                        variant: 'success'
                    })
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
        } else {
            console.log("Age should be greater than or equal to 18");
            alert("Age should be greater than or equal to 18");
        }
    }
}