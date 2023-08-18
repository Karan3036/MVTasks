import { LightningElement, api, track } from 'lwc';
export default class CustomLookupChild extends LightningElement {
    @api field;
    @api options = [];
    @track value = '';
    @api recordId;
    handleChange(e) {
        this.value = e.target.value;
        console.log(this.value);
        this.dispatchEvent(new CustomEvent('progressvaluechange', { detail: this.value }));
    }

}