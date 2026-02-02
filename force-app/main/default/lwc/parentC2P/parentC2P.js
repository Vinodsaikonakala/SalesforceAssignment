import { LightningElement } from 'lwc';

export default class CounterParent extends LightningElement {
    count = 0;

    handleAdd() {
        this.count++;
    }

    handleSubtract() {
        this.count--;
    }
}