import { LightningElement, wire } from 'lwc';
import getDeals from '@salesforce/apex/DealController.getDeals';
import getPartnerAccounts from '@salesforce/apex/DealController.getPartnerAccounts';

import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

const COLUMNS = [
    { label: 'Deal Name', fieldName: 'Name' },
    { label: 'Status', fieldName: 'Status__c' },
    {
        label: 'Expected Amount',
        fieldName: 'Expected_Amount__c',
        type: 'number',
        editable: true
    },
    {
        label: 'Close Date',
        fieldName: 'Close_Date__c',
        type: 'date',
        editable: true
    }
];

export default class PartnerDealConsole extends LightningElement {

    columns = COLUMNS;
    deals;
    draftValues = [];

    selectedPartner = null;
    selectedStatus = null;

    wiredDealsResult;
    partnerOptions = [];

    statusOptions = [
        { label: 'All', value: null },
        { label: 'Draft', value: 'Draft' },
        { label: 'Approved', value: 'Approved' },
        { label: 'Rejected', value: 'Rejected' }
    ];

    @wire(getPartnerAccounts)
    wiredPartners({ data, error }) {
        if (data) {
            this.partnerOptions = [
                { label: 'All', value: null },
                ...data.map(acc => ({
                    label: acc.Name,
                    value: acc.Id
                }))
            ];
        } else if (error) {
            console.error('Error loading partners', error);
        }
    }

    @wire(getDeals, {
        partnerId: '$selectedPartner',
        status: '$selectedStatus'
    })
    wiredDeals(result) {
        this.wiredDealsResult = result;
        if (result.data) {
            this.deals = result.data;
        } else if (result.error) {
            console.error('Error loading deals', result.error);
        }
    }

    handlePartnerChange(event) {
        this.selectedPartner = event.detail.value;
    }

    handleStatusChange(event) {
        this.selectedStatus = event.detail.value;
    }

    async handleSave(event) {

        const records = event.detail.draftValues.map(draft => {
            return { fields: { ...draft } };
        });

        try {
            await Promise.all(
                records.map(record => updateRecord(record))
            );

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Deals updated successfully',
                    variant: 'success'
                })
            );

            this.draftValues = [];
            await refreshApex(this.wiredDealsResult);

        } catch (error) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        }
    }
}