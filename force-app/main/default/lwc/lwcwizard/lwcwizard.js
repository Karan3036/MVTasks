import { LightningElement, track} from 'lwc';
import getfields from "@salesforce/apex/dynamicObjectList.getfields"; 
export default class lwcwizard extends LightningElement {
    @track value = 'inProgress';
    @track data1 = [];
get options() {
    return [
             { label: ' Account', value: 'Account' } ,
             { label: 'Contact  ', value: 'Contact ' } ,
             { label: 'Lead  ', value: 'Lead' } 
            
           ];
}
get Options() {
    return this.data1;
}
handleChange(event) {
        this.value = event.detail.value;
        const select = event.detail.value;
    getfields({
      objectname: select
    })
      .then((result) => {
        let data = JSON.parse(JSON.stringify(result));
        let lstOption = [];
      for (var i = 0;i < data.length;i++) {
          lstOption.push({value: data[i].QualifiedApiName,label: data[i].DeveloperName
          });
        }
        this.data1 = lstOption;
        this.showLoadingSpinner = false;
      })
      .catch((error) => {
        error;
      });
     }
    
    @track currentStep = '1';
    @track selectedOption;
    changeHandler(event) {
    const field = event.target.name;
    if (field === 'optionSelect') {
        this.selectedOption = event.target.value;
            alert("you have selected : ",this.selectedOption);
        } 
    }
    handleOnStepClick(event) {
        this.currentStep = event.target.value;
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
 
    handleNext(){
        if(this.currentStep == "1"){
            this.currentStep = "2";
        }
        else if(this.currentStep = "2"){
            this.currentStep = "3";
        }
    }
 
    handlePrev(){
        if(this.currentStep == "3"){
            this.currentStep = "2";
        }
        else if(this.currentStep = "2"){
            this.currentStep = "1";
        }
    }
 
    handleFinish(){
 
    }
}