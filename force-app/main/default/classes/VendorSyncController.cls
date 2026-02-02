public with sharing class VendorSyncController {

    @AuraEnabled
    public static String syncDeals(Id partnerAccountId) {

        if (partnerAccountId == null) {
            throw new AuraHandledException('Partner Account Id is required');
        }

        System.enqueueJob(new VendorSyncQueueable(partnerAccountId));
        return 'Sync job started successfully';
    }

    @AuraEnabled(cacheable=true)
    public static List<Sync_Log__c> getLogs() {

        return [
            SELECT Id, Message__c, Status__c, Run_Date__c
            FROM Sync_Log__c
            ORDER BY Run_Date__c DESC
            LIMIT 5
        ];
    }
}