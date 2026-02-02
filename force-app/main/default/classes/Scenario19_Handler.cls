public class Scenario19_Handler {

    public static void afterUpdate(
        List<Deal_Registration__c> newDeals,
        Map<Id, Deal_Registration__c> oldMap
    ) {

        List<Deal_Approved_Event__e> events =
            new List<Deal_Approved_Event__e>();

        for (Deal_Registration__c deal : newDeals) {

            Deal_Registration__c oldDeal = oldMap.get(deal.Id);

            Boolean justApproved =
                deal.Status__c == 'Approved' &&
                oldDeal.Status__c != 'Approved';

            if (justApproved) {

                Deal_Approved_Event__e evt =
                    new Deal_Approved_Event__e();

                evt.Deal_Id__c = String.valueOf(deal.Id);
                evt.Partner_Account_Id__c =
                    String.valueOf(deal.Partner_Account__c);
                evt.Status__c = deal.Status__c;

                events.add(evt);
            }
        }

        if (!events.isEmpty()) {
            EventBus.publish(events);
        }
    }
}