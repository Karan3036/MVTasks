import { LightningElement, track} from 'lwc';


export default class CreateRecordWithFieldIntigrity extends LightningElement {

    rec = {
        LastName : this.lastname,
        FirstName : this.firstname,
        Birthdate : this.Birthdate,
        Email_Ids__c : this.email,
        User__c : this.User__c
    }
    Ages__c;
    handleNameChange(event) {
        this.rec.LastName = event.target.value;
        console.log("lname", this.rec.LastName);
    }
    
    handleIndChange(event) {
        this.rec.FirstName = event.target.value;
        console.log("fname", this.rec.FirstName);
    }
    
    handlePhnChange(event) {
        this.rec.Birthdate = event.target.value;
        console.log( event.detail.value );
        let d1 = new Date( event.detail.value );
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
        if ( this.Ages__c >= 18) {
            console.log('alright');
        } else {
            alert("Age should be greater than or equal to 18");
        } 

}
    

    handleemiChange(event) {
        this.rec.Email_Ids__c = event.target.value;
        console.log("email", this.rec.Email_Ids__c);
    }
    handleusernameChange(event){
        this.rec.User__c = event.target.value;
        console.log("email", this.rec.User__c);
    }

    
}