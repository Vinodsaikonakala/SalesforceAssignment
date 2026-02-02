public class DealVendorQueueable implements Queueable, Database.AllowsCallouts {

    private List<Id> dealIds;

    public DealVendorQueueable(List<Id> ids) {
        this.dealIds = ids;
    }

    public void execute(QueueableContext context) {

        List<Deal_Registration__c> deals = [
            SELECT Id, Name
            FROM Deal_Registration__c
            WHERE Id IN :dealIds
        ];

        List<Deal_Registration__c> dealsToUpdate = new List<Deal_Registration__c>();
        List<Deal_Integration_Log__c> logs = new List<Deal_Integration_Log__c>();

        for (Deal_Registration__c deal : deals) {

            try {
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://example.com/vendor');
                req.setMethod('POST');
                req.setBody('{"dealName":"' + deal.Name + '"}');

                Http http = new Http();
                HttpResponse res = http.send(req);

                String mockResponse =
                    '{"status":"ACCEPTED","externalId":"VND-' + deal.Id + '"}';

                Map<String, Object> result =
                    (Map<String, Object>) JSON.deserializeUntyped(mockResponse);

                deal.Vendor_Status__c = (String) result.get('status');
                deal.Vendor_Deal_Id__c = (String) result.get('externalId');
                dealsToUpdate.add(deal);

                logs.add(new Deal_Integration_Log__c(
                    Deal__c = deal.Id,
                    Status__c = 'Success',
                    Message__c = 'Vendor sync successful'
                ));

            } catch (Exception e) {

                logs.add(new Deal_Integration_Log__c(
                    Deal__c = deal.Id,
                    Status__c = 'Error',
                    Message__c = e.getMessage()
                ));
            }
        }

        if (!dealsToUpdate.isEmpty()) {
            update dealsToUpdate;
        }

        if (!logs.isEmpty()) {
            insert logs;
        }
    }
}