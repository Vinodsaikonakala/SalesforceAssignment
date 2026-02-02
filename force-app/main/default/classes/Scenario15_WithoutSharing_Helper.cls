public without sharing class Scenario15_WithoutSharing_Helper {

    public static void normalizePartnerTier(Set<Id> accountIds) {

        List<Account> accs = [
            SELECT Id, Partner_Tier__c
            FROM Account
            WHERE Id IN :accountIds
        ];

        for (Account a : accs) {
            if (a.Partner_Tier__c == null) {
                a.Partner_Tier__c = 'Standard';
            }
        }

        if (!accs.isEmpty()) {
            update accs;
        }
    }
}