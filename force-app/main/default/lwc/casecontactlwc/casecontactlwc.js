import { LightningElement, track } from 'lwc';
import createContactAndCase from '@salesforce/apex/ContactCaseController.createContactAndCase';

export default class ContactCaseCreator extends LightningElement {

    firstName = '';
    lastName = '';
    email = '';
    subject = '';
    description = '';

    @track caseRecord;
    isCaseCreated = false;
    showCaseDetails = false;

    handleFirstName(event) {
        this.firstName = event.target.value;
    }

    handleLastName(event) {
        this.lastName = event.target.value;
    }

    handleEmail(event) {
        this.email = event.target.value;
    }

    handleSubject(event) {
        this.subject = event.target.value;
    }

    handleDescription(event) {
        this.description = event.target.value;
    }

    handleSave() {
        createContactAndCase({
            firstName: this.firstName,
            lastName: this.lastName,
            email: this.email,
            subject: this.subject,
            description: this.description
        })
        .then(result => {
            this.caseRecord = result;
            this.isCaseCreated = true;
            this.showCaseDetails = false;
            alert('Contact and Case created successfully!');
        })
        .catch(error => {
            console.error(error);
            alert('Error while creating record');
        });
    }

    showCase() {
        this.showCaseDetails = true;
    }
}