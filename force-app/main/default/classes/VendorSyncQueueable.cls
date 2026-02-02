public class VendorSyncQueueable implements Queueable, Database.AllowsCallouts {

    private Id partnerAccountId;

    public VendorSyncQueueable(Id partnerId) {
        this.partnerAccountId = partnerId;
    }

    public void execute(QueueableContext context) {

        List<Deal_Registration__c> deals = [
            SELECT Id, Name
            FROM Deal_Registration__c
            WHERE Partner_Account__c = :partnerAccountId
            AND Status__c = 'Approved'
        ];

        if (deals.isEmpty()) {
            insertLog('No approved deals found', 'Error');
            return;
        }

        try {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://example.com/vendor-api');
            req.setMethod('POST');
            req.setBody('Sending ' + deals.size() + ' deals');

            Http http = new Http();
            HttpResponse res = http.send(req);
            insertLog('Successfully synced ' + deals.size() + ' deals', 'Success');

        } catch (Exception e) {
            insertLog('Sync failed: ' + e.getMessage(), 'Error');
        }
    }

    private void insertLog(String message, String status) {
        Sync_Log__c log = new Sync_Log__c();
        log.Message__c = message;
        log.Status__c = status;
        log.Run_Date__c = Date.today(); 
        insert log;
    }
}