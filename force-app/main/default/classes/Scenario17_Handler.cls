public class Scenario17_Handler {

    public static void afterInsert(List<Deal_Registration__c> newDeals) {

        List<Id> dealIds = new List<Id>();

        for (Deal_Registration__c d : newDeals) {
            dealIds.add(d.Id);
        }

        if (!dealIds.isEmpty()) {
            System.enqueueJob(
                new Scenario17_Queueable(dealIds)
            );
        }
    }
}