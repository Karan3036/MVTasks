import { LightningElement, api, track } from 'lwc';

export default class CustomLookupChild extends LightningElement {
    @api field;
    @api options = [];
    @track value = '';

    handleChange(event) {
        this.value = event.target.value;
        // Fire an event to notify the parent component of the change
        this.dispatchEvent(new CustomEvent('change', { detail: this.value }));
    }
}