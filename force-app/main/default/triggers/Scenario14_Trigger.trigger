trigger Scenario14_Trigger on Deal_Registration__c (before insert) {

    if (Trigger.isBefore && Trigger.isInsert) {
        Scenario14_Handler.beforeInsert(Trigger.new);
    }

}