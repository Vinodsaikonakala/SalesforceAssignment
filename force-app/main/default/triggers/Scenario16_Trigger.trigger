trigger Scenario16_Trigger on Deal_Registration__c
    (after insert, after update) {

    Set<Id> accountIds = new Set<Id>();

    for (Deal_Registration__c d : Trigger.new) {
        if (d.Partner_Account__c != null) {
            accountIds.add(d.Partner_Account__c);
        }
    }

    if (!accountIds.isEmpty()) {
        Scenario16_Handler.recalculatePartnerStats(accountIds);
    }
}