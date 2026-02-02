public class Scenario10_Handler {

    public static void afterUpdate(
        List<Deal_Registration__c> newDeals,
        Map<Id, Deal_Registration__c> oldMap
    ) {

        List<Rejection_Log__c> logsToInsert =
            new List<Rejection_Log__c>();

        for (Deal_Registration__c deal : newDeals) {

            Deal_Registration__c oldDeal = oldMap.get(deal.Id);

            Boolean justRejected =
                deal.Status__c == 'Rejected' &&
                oldDeal.Status__c != 'Rejected';

            if (justRejected) {

                Rejection_Log__c log = new Rejection_Log__c();
                log.Deal__c = deal.Id;
                log.Rejected_Date__c = Date.today();

                logsToInsert.add(log);
            }
        }

        if (!logsToInsert.isEmpty()) {
            insert logsToInsert;
        }
    }
}