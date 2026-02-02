public class Scenario6_Handler {

    public static void afterUpdate(
        List<Deal_Registration__c> newDeals,
        Map<Id, Deal_Registration__c> oldMap
    ) {

        List<Opportunity> oppsToInsert = new List<Opportunity>();

        for (Deal_Registration__c deal : newDeals) {

            Deal_Registration__c oldDeal = oldMap.get(deal.Id);

            Boolean statusJustApproved =
                deal.Status__c == 'Approved' &&
                oldDeal.Status__c != 'Approved';

            if (statusJustApproved &&
                deal.End_Customer_Account__c != null) {

                Opportunity opp = new Opportunity();
                opp.Name = 'Deal Opportunity - ' + deal.Name;
                opp.StageName = 'Qualification';
                opp.CloseDate = Date.today().addDays(30);
                opp.AccountId = deal.End_Customer_Account__c;

                oppsToInsert.add(opp);
            }
        }

        if (!oppsToInsert.isEmpty()) {
            insert oppsToInsert;
        }
    }
}