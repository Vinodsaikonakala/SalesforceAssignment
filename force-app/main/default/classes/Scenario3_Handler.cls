public class Scenario3_Handler {

    public static void beforeUpdate(
        List<Account> newAccounts,
        Map<Id, Account> oldMap
    ) {

        for (Account acc : newAccounts) {

            Account oldAcc = oldMap.get(acc.Id);

            Boolean tierChanged =
                acc.Partner_Tier__c != oldAcc.Partner_Tier__c;

            if (acc.Partner_Status__c == 'Suspended' && tierChanged) {

                acc.Partner_Tier__c.addError(
                    'Cannot change Partner Tier when Partner Status is Suspended.'
                );
            }
        }
    }
}