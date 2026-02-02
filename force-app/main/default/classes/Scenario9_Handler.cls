public class Scenario9_Handler {

    public static void afterInsert(List<Deal_Registration__c> newDeals) {

        Set<Id> accountIds = new Set<Id>();

        for (Deal_Registration__c d : newDeals) {
            if (d.Partner_Account__c != null) {
                accountIds.add(d.Partner_Account__c);
            }
        }

        if (accountIds.isEmpty()) return;

        List<Account> accountsToUpdate = [
            SELECT Id, Last_Deal_Date__c
            FROM Account
            WHERE Id IN :accountIds
        ];
        for (Account acc : accountsToUpdate) {
            acc.Last_Deal_Date__c = Date.today();
        }
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}