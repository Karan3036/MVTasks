import { LightningElement, track } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import EMAIL_FIELD from '@salesforce/schema/Account.Email__c';

export default class ForgetPassword extends LightningElement {
  @track username = null;

  handleUsernameChange(event) {
    this.username = event.target.value;
  }

  handleClick() {
    const fields = {};
    fields[EMAIL_FIELD.fieldApiName] = this.username;
    const recordInput = { apiName: ACCOUNT_OBJECT.objectApiName, fields };
    createRecord(recordInput)
      .then(() => {
        this.dispatchEvent(
          new ShowToastEvent({
            title: 'Success',
            message: 'Reset email sent',
            variant: 'success'
          })
        );
      })
      .catch(error => {
        this.dispatchEvent(
          new ShowToastEvent({
            title: 'Error sending reset email',
            message: error.body.message,
            variant: 'error'
          })
        );
      });
  }
}