trigger DealVendorTrigger on Deal_Registration__c (after update) {

    List<Id> submittedDeals = new List<Id>();

    for (Deal_Registration__c d : Trigger.new) {
        Deal_Registration__c old = Trigger.oldMap.get(d.Id);

        if (
            d.Status__c == 'Submitted_to_Vendor' &&
            old.Status__c != 'Submitted_to_Vendor'
        ) {
            submittedDeals.add(d.Id);
        }
    }

    if (!submittedDeals.isEmpty()) {
        System.enqueueJob(new DealVendorQueueable(submittedDeals));
    }
}