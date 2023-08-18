import { LightningElement, api, wire } from 'lwc';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';

export default class CustomLookupField extends LightningElement {
    @api fieldName;
    @api options;
   // @api onchange;
    @api selectedValue;
    @api objectApiName;
    @api picklistFieldApiName;
    @api isMultiEntry;
    @wire(getObjectInfo, { objectApiName: '$objectApiName' })
    objectInfo;
    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: '$picklistFieldApiName' })
    picklistValues;

    connectedCallback() {
        this.options = this.picklistValues.data.values;
    }

    handleChange(event) {
        this.selectedValue = event.target.value;
        this.onchange({ selectedValue: this.selectedValue });
    }
}