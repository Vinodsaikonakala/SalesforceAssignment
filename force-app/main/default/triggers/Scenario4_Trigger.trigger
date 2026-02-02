trigger Scenario4_Trigger on Deal_Registration__c (before insert) {

    if (Trigger.isBefore && Trigger.isInsert) {
        Scenario4_Handler.beforeInsert(Trigger.new);
    }

}