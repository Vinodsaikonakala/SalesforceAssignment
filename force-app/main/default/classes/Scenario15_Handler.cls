public class Scenario15_Handler {

    public static void afterUpdate(List<Account> newAccounts) {

        Set<Id> accIds = new Set<Id>();

        for (Account a : newAccounts) {
            if (a.Is_Partner__c == true) {
                accIds.add(a.Id);
            }
        }

        if (!accIds.isEmpty()) {
            Scenario15_WithoutSharing_Helper.normalizePartnerTier(accIds);
        }
    }
}