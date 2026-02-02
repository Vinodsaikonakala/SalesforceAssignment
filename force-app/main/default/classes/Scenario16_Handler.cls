public class Scenario16_Handler {

    public static void recalculatePartnerStats(
        Set<Id> accountIds
    ) {

        if (accountIds.isEmpty()) return;

        Map<Id, Integer> totalCountMap = new Map<Id, Integer>();

        for (AggregateResult ar : [
            SELECT Partner_Account__c accId,
                   COUNT(Id) totalCnt
            FROM Deal_Registration__c
            WHERE Partner_Account__c IN :accountIds
            GROUP BY Partner_Account__c
        ]) {
            totalCountMap.put(
                (Id) ar.get('accId'),
                (Integer) ar.get('totalCnt')
            );
        }

        Map<Id, Integer> approvedCountMap = new Map<Id, Integer>();

        for (AggregateResult ar : [
            SELECT Partner_Account__c accId,
                   COUNT(Id) approvedCnt
            FROM Deal_Registration__c
            WHERE Partner_Account__c IN :accountIds
            AND Status__c = 'Approved'
            GROUP BY Partner_Account__c
        ]) {
            approvedCountMap.put(
                (Id) ar.get('accId'),
                (Integer) ar.get('approvedCnt')
            );
        }

        Map<Id, Decimal> amountMap = new Map<Id, Decimal>();

        for (AggregateResult ar : [
            SELECT Partner_Account__c accId,
                   SUM(Amount__c) totalAmt
            FROM Deal_Registration__c
            WHERE Partner_Account__c IN :accountIds
            GROUP BY Partner_Account__c
        ]) {
            amountMap.put(
                (Id) ar.get('accId'),
                (Decimal) ar.get('totalAmt')
            );
        }

        List<Account> accsToUpdate = new List<Account>();

        for (Id accId : accountIds) {

            Account acc = new Account(Id = accId);

            acc.Total_Deals__c =
                totalCountMap.containsKey(accId)
                ? totalCountMap.get(accId) : 0;

            acc.Approved_Deals__c =
                approvedCountMap.containsKey(accId)
                ? approvedCountMap.get(accId) : 0;

            acc.Total_Deal_Amount__c =
                amountMap.containsKey(accId)
                ? amountMap.get(accId) : 0;

            accsToUpdate.add(acc);
        }

        if (!accsToUpdate.isEmpty()) {
            update accsToUpdate;
        }
    }
}