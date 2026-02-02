import { LightningElement, api, wire } from 'lwc';
import syncDeals from '@salesforce/apex/VendorSyncController.syncDeals';
import getLogs from '@salesforce/apex/VendorSyncController.getLogs';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

export default class SyncDealsWithVendor extends LightningElement {

    @api recordId;
    isLoading = false;
    logs;

    wiredLogsResult;

    @wire(getLogs)
    wiredLogs(result) {
        this.wiredLogsResult = result;
        if (result.data) {
            this.logs = result.data;
        }
    }

    handleSync() {
        this.isLoading = true;

        syncDeals({ partnerAccountId: this.recordId })
            .then(result => {
                this.showToast('Success', result, 'success');
                return refreshApex(this.wiredLogsResult);
            })
            .catch(error => {
                this.showToast(
                    'Error',
                    error.body.message,
                    'error'
                );
            })
            .finally(() => {
                this.isLoading = false;
            });
    }

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant
            })
        );
    }
}