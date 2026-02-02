trigger Scenario18_Trigger on Deal_Registration__c (after insert, after update) {

    if (Trigger.isAfter) {
        Scenario18_Handler.collectAccounts(Trigger.new);
    }

}