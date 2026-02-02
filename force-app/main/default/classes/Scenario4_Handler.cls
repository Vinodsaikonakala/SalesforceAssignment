public class Scenario4_Handler {

    public static void beforeInsert(List<Deal_Registration__c> newDeals) {

        Set<Id> accountIds = new Set<Id>();

        for (Deal_Registration__c deal : newDeals) {
            if (deal.Partner_Account__c != null) {
                accountIds.add(deal.Partner_Account__c);
            }
        }

        if (accountIds.isEmpty()) return;

        Map<Id, Account> accMap = new Map<Id, Account>([
            SELECT Id, Partner_Region__c
            FROM Account
            WHERE Id IN :accountIds
        ]);

        for (Deal_Registration__c deal : newDeals) {
            if (deal.Partner_Account__c != null &&
                accMap.containsKey(deal.Partner_Account__c)) {

                deal.Partner_Region__c =
                    accMap.get(deal.Partner_Account__c).Partner_Region__c;
            }
        }
    }
}