import { LightningElement } from 'lwc';

export default class CounterChild extends LightningElement {

    handleAdd() {
        this.dispatchEvent(new CustomEvent('add'));
    }

    handleSubtract() {
        this.dispatchEvent(new CustomEvent('subtract'));
    }
}