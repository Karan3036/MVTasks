import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ResetPassword extends LightningElement {
  @track email = null;
  @track password = null;
  @track confirmPassword = null;
  @track userName = null;
  @track infoTooltipDisplayData = {};
    @track requiredTooltipDisplayData = {};
    @track errorTooltipDisplayData = {};
    @track emailError;
  connectedCallback(){

    this.showUserName = false;

    this.infoTooltipDisplayData.userName = "tooltiptext userNameTooltiptext";
    this.infoTooltipDisplayData.password = "tooltiptext";

    this.requiredTooltipDisplayData.firstName = 'tooltiptext tooltipHide';
    this.requiredTooltipDisplayData.lastName = 'tooltiptext tooltipHide';
    this.requiredTooltipDisplayData.email = 'tooltiptext tooltipHide';
    this.requiredTooltipDisplayData.userName = 'tooltiptext tooltipHide';        
    this.requiredTooltipDisplayData.hearAboutUs = 'tooltiptext tooltipHide';
    this.requiredTooltipDisplayData.password = 'tooltiptext tooltipHide';
    this.requiredTooltipDisplayData.confirmPassword = 'tooltiptext tooltipHide';

    this.errorTooltipDisplayData.email = 'tooltiptext tooltipHide';
    this.errorTooltipDisplayData.password = 'tooltiptext tooltipHide';
}

  handleEmailChange(event) {
    this.email = event.target.value;
  }

  handlePasswordChange(event) {
    this.password = event.target.value;
  }

  handleConfirmPasswordChange(event) {
    this.confirmPassword = event.target.value;
  }

  onEmailInvalid(event){

    if (!event.target.validity.valid) {
        event.target.setCustomValidity('Enter a valid email address')
    }
    
}

onEmailInput(event){

    event.target.setCustomValidity('')
}

onEmailClick(event){

    let parent = event.target.parentElement.parentElement.parentElement;
    console.log('parent-', parent);
    parent.classList.remove('tooltipEmail');
}

onEmailBlur(event){

    let parent = event.target.parentElement.parentElement.parentElement;
    console.log('parent-', parent);
    parent.classList.add('tooltipEmail');
}

handleEmailChange(event){

    if(event.target.value){

        this.email = event.target.value;
        this.userName = this.email + '.cydehustle';
    
    } else {

        this.email = event.target.value;
        this.userName = this.email;
    }
}

  handleClick() {
    if (this.password !== this.confirmPassword) {
      this.dispatchEvent(
        new ShowToastEvent({
          title: 'Error',
          message: 'Passwords do not match',
          variant: 'error'
        })
      );
    } else {
      // Insert logic to reset password here
      this.dispatchEvent(
        new ShowToastEvent({
          title: 'Success',
          message: 'Password reset',
          variant: 'success'
        })
      );
    }
  }

  
}