trigger Scenario11_Trigger on Deal_Registration__c (before insert) {

    if (Trigger.isBefore && Trigger.isInsert) {
        Scenario11_Handler.beforeInsert(Trigger.new);
    }

}