import { LightningElement, wire } from 'lwc';
import getEmailTemplates from '@salesforce/apex/tempo.getEmailTemplates';

export default class Try002 extends LightningElement {
  selectedTemplate;

  @wire(getEmailTemplates)
  emailTemplates;

  handleTemplateChange(event) {
    this.selectedTemplate = event.target.value;
  }

  get emailTemplateOptions() {
    if (!this.emailTemplates || !this.emailTemplates.data) {
      return [];
    }
    return this.emailTemplates.data.map(template => {
      return { label: template.Name, value: template.Id };
    });
  }
  
}