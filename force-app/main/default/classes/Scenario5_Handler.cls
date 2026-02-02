public class Scenario5_Handler {

    public static void updateDealCounts(Set<Id> accountIds) {

        if (accountIds.isEmpty()) return;

        Map<Id, Integer> dealCountMap = new Map<Id, Integer>();

        for (AggregateResult ar : [
            SELECT Partner_Account__c accId, COUNT(Id) dealCount
            FROM Deal_Registration__c
            WHERE Partner_Account__c IN :accountIds
            GROUP BY Partner_Account__c
        ]) {
            dealCountMap.put(
                (Id) ar.get('accId'),
                (Integer) ar.get('dealCount')
            );
        }

        List<Account> accountsToUpdate = new List<Account>();

        for (Id accId : accountIds) {

            Integer count =
                dealCountMap.containsKey(accId)
                ? dealCountMap.get(accId)
                : 0;

            accountsToUpdate.add(new Account(
                Id = accId,
                Registered_Deals__c = count
            ));
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}