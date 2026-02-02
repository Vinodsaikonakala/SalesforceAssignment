trigger Scenario5_Trigger on Deal_Registration__c
    (after insert, after delete, after undelete) {

    Set<Id> accountIds = new Set<Id>();

    if (Trigger.isAfter) {

        if (Trigger.isInsert || Trigger.isUndelete) {
            for (Deal_Registration__c d : Trigger.new) {
                if (d.Partner_Account__c != null) {
                    accountIds.add(d.Partner_Account__c);
                }
            }
        }

        if (Trigger.isDelete) {
            for (Deal_Registration__c d : Trigger.old) {
                if (d.Partner_Account__c != null) {
                    accountIds.add(d.Partner_Account__c);
                }
            }
        }

        if (!accountIds.isEmpty()) {
            Scenario5_Handler.updateDealCounts(accountIds);
        }
    }
}