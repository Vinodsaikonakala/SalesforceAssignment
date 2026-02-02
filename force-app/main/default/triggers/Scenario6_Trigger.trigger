trigger Scenario6_Trigger on Deal_Registration__c (after update) {

    if (Trigger.isAfter && Trigger.isUpdate) {
        Scenario6_Handler.afterUpdate(Trigger.new, Trigger.oldMap);
    }

}