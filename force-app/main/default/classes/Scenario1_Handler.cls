public class Scenario1_Handler {

    public static void beforeInsert(List<Account> newAccounts) {

        Partner_Config__c config = Partner_Config__c.getOrgDefaults();

        if (config == null || String.isBlank(config.Default_Partner_Tier__c)) {
            return;
        }

        for (Account acc : newAccounts) {
            if (acc.Is_Partner__c == true && acc.Partner_Tier__c == null) {
                acc.Partner_Tier__c = config.Default_Partner_Tier__c;
            }
        }
    }
}