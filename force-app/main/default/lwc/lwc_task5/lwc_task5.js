import { LightningElement, track } from 'lwc';
import getAccountData from '@salesforce/apex/lwc_task5.getAccountData';
import getAccount from '@salesforce/apex/lwc_task5.getAccount';

export default class Lwc_task5 extends LightningElement {
    @track value;
    @track options =
        [
            { label: 'Account', value: 'Account' },
            { label: 'Contact', value: 'Contact' },
            { label: 'Lead', value: 'Lead' },
            { label: 'Opportunity', value: 'Opportunity' },
            { label: 'Contract', value: 'Contract' },
            { label: 'person', value: 'person' }
        ];
    @track allValues = [];

    handleChange(event) {
        if (!this.allValues.includes(event.target.value)) { this.allValues.push(event.target.value); }
        console.log(JSON.stringify(this.allValues));
        this.serchrecode();
    }

    handleRemove(event) {
        const valueRemoved = event.target.name;
        this.allValues.splice(this.allValues.indexOf(valueRemoved), 1);
        console.log(JSON.stringify(this.allValues));
        this.serchrecode();

    }
    @track searchKey;
    @track accounts;
    @track Contacts;
    @track Leads;
    @track Opportunitys;
    @track Contracts;
    @track Pricebook2s;
    
    handelSearchKey(event) {
        this.searchKey = event.target.value;
        console.log('search input:::::::::' + this.searchKey);
    }

    SearchAccountHandler(event) {
        const a = {
            textkey: this.searchKey
        }
        console.log('function');
        getAccountData(a)
            .then(result => {
                // alert('1');
                for (let index = 0; index < JSON.stringify(this.allValues.length); index++) {
                    if (this.allValues[index] === 'Account') { this.accounts = result[0]; }
                    else if (this.allValues[index] === 'Contact') { this.Contacts = result[1]; }
                    else if (this.allValues[index] === 'Lead') { this.Leads = result[2]; }
                    else if (this.allValues[index] === 'Opportunity') { this.Opportunitys = result[3]; }
                    else if (this.allValues[index] === 'Contract') { this.Contracts = result[4]; }
                    else if (this.allValues[index] === 'person') { this.Pricebook2s = result[5]; }   
                }
                console.log(JSON.stringify(result[0]));
            })
            .catch(error => {
                console.log(error);
            });

    }
    cols = [
        { label: 'Account Name', fieldName: 'Name' },
        { label: 'Phone', fieldName: 'Phone' }

    ]
    cols1 = [
        { label: 'First Name', fieldName: 'FirstName' },
        { label: 'LastName', fieldName: 'LastName' }
    ]
    cols2 = [
        { label: 'Lead Name', fieldName: 'Name' },
        { label: 'Lead Email', fieldName: 'Email' }
    ]

    cols3 = [
        { label: 'Opportunity Name', fieldName: 'Name' },
        { label: 'Opportunity stage', fieldName: 'StageName' }
    ]
    cols4 = [
        { label: 'Contracts Name', fieldName: 'Name' },
        { label: 'Status', fieldName: 'Status' }
    ]
    cols5 = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Phone No', fieldName: 'Phone_No__c' }
    ]


    serchrecode() {
        for (let index = 0; index < JSON.stringify(this.allValues.length); index++) {
            console.log('for loop' + JSON.stringify(this.allValues.length));
            if (this.allValues[index] === 'Account') {
                const filed = {
                    filed1: 'Name',
                    filed2: 'Phone',
                    filed3: 'Account'
                };
                getAccount(filed)
                    .then(result => {
                        console.log('Account');
                        if (result != null) {
                            this.accounts = result;
                        }
                       
                    })
                    .catch(error => {console.log("Account call error");
                    });
            } else if (this.allValues[index] === 'Contact') {
                const filed = {
                    filed1: 'FirstName',
                    filed2: 'LastName',
                    filed3: 'Contact'
                };
                getAccount(filed)
                    .then(result => {
                        console.log('cccconli');
                        if (result != null) {
                            this.Contacts = result;
                        }
                       
                    })
                    .catch(error => {
                    });


            } else if (this.allValues[index] === 'Lead') {
                const filed = {
                    filed1: 'Name',
                    filed2: 'Email',
                    filed3: 'Lead'
                };
                getAccount(filed)
                    .then(result => {
                        console.log('lllllead');
                        if (result != null) {
                            this.Leads = result;
                        }
                    })
                    .catch(error => {
                    });

            } else if (this.allValues[index] === 'Opportunity') {
                const filed = {
                    filed1: 'Name',
                    filed2: 'StageName',
                    filed3: 'Opportunity'
                };
                getAccount(filed)
                    .then(result => {
                        console.log('Opportunity');
                        if (result != null) {
                            this.Opportunitys = result;
                        }
                    })
                    .catch(error => {
                    });

            } else if (this.allValues[index] === 'Contract') {
                const filed = {
                    filed1: 'Name',
                    filed2: 'Status',
                    filed3: 'Contract'
                };

                getAccount(filed)
                    .then(result => {
                        console.log('Contract');
                        if (result != null) {
                            this.Contracts = result;
                        }
                        
                    })
                    .catch(error => {
                    });
            } else if (this.allValues[index] === 'person') {
                const filed = {
                    filed1: 'Name',
                    filed2: 'Phone_No__c',
                    filed3: 'person'
                };
                getAccount(filed)
                    .then(result => {
                        console.log('person__c');
                        if (result != null) {
                            this.Pricebook2s = result;
                        }
                    })
                    .catch(error => {
                        this.accounts = null;
                    });
            }
        }
    }
}