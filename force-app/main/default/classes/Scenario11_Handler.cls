public class Scenario11_Handler {

    public static void beforeInsert(List<Deal_Registration__c> newDeals) {

        Deal_Limit_Config__c config =
            Deal_Limit_Config__c.getOrgDefaults();

        if (config == null || config.Max_Open_Deals__c == null) return;

        Integer maxAllowed = Integer.valueOf(config.Max_Open_Deals__c);

        Set<Id> accountIds = new Set<Id>();

        for (Deal_Registration__c d : newDeals) {
            if (d.Partner_Account__c != null) {
                accountIds.add(d.Partner_Account__c);
            }
        }

        if (accountIds.isEmpty()) return;
        Map<Id, Integer> openDealCountMap = new Map<Id, Integer>();

        for (AggregateResult ar : [
            SELECT Partner_Account__c accId, COUNT(Id) cnt
            FROM Deal_Registration__c
            WHERE Partner_Account__c IN :accountIds
            AND Status__c != 'Closed'
            AND Status__c != 'Rejected'
            GROUP BY Partner_Account__c
        ]) {
            openDealCountMap.put(
                (Id) ar.get('accId'),
                (Integer) ar.get('cnt')
            );
        }

        Map<Id, Integer> incomingCount = new Map<Id, Integer>();

        for (Deal_Registration__c d : newDeals) {
            if (d.Partner_Account__c != null) {
                incomingCount.put(
                    d.Partner_Account__c,
                    (incomingCount.containsKey(d.Partner_Account__c)
                        ? incomingCount.get(d.Partner_Account__c) : 0) + 1
                );
            }
        }

        for (Deal_Registration__c d : newDeals) {

            if (d.Partner_Account__c == null) continue;

            Integer existing =
                openDealCountMap.containsKey(d.Partner_Account__c)
                ? openDealCountMap.get(d.Partner_Account__c)
                : 0;

            Integer incoming =
                incomingCount.get(d.Partner_Account__c);

            if ((existing + incoming) > maxAllowed) {
                d.addError(
                    'Maximum open deals limit exceeded for this Partner.'
                );
            }
        }
    }
}