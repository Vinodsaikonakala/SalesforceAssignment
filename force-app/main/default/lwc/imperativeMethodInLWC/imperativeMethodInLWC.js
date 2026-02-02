import { LightningElement, track } from 'lwc';
import getAccounts from '@salesforce/apex/imperativeCallMethod.getAccounts';

export default class ImperativeMethodInLWC extends LightningElement {

    @track keywordSearch = '';
    @track accounts = [];

    columns = [
        { label: 'Account Name', fieldName: 'Name', type: 'text' },
        { label: 'Industry', fieldName: 'Industry', type: 'text' },
        { label: 'Phone', fieldName: 'Phone', type: 'phone' },
        { label: 'Website', fieldName: 'Website', type: 'url' }
    ];

    handleKeywordSearch(event) {
        this.keywordSearch = event.target.value;
    }

    handleKeywordSearchClick() {
        getAccounts({ keyword: this.keywordSearch })
            .then(result => {
                this.accounts = result || [];
            })
            .catch(error => {
                console.error('Error fetching accounts:', error);
                this.accounts = [];
            });
    }
}