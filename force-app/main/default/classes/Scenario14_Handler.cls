public class Scenario14_Handler {

    public static void beforeInsert(List<Deal_Registration__c> newDeals) {

        Set<Id> partnerAccountIds = new Set<Id>();

        for (Deal_Registration__c d : newDeals) {
            if (d.Partner_Account__c != null) {
                partnerAccountIds.add(d.Partner_Account__c);
            }
        }

        if (partnerAccountIds.isEmpty()) return;

        Set<Id> accessibleAccounts =
            Scenario14_WithSharing_Service.getAccessibleAccountIds(
                partnerAccountIds
            );

        for (Deal_Registration__c d : newDeals) {

            if (d.Partner_Account__c != null &&
                !accessibleAccounts.contains(d.Partner_Account__c)) {

                d.addError(
                    'You do not have access to this Partner Account.'
                );
            }
        }
    }
}