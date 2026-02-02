import { LightningElement, track } from 'lwc';

export default class ParentComponent extends LightningElement {

    @track parentMessage = '';

    handleChange(event) {
        this.parentMessage = event.target.value;
    }
}