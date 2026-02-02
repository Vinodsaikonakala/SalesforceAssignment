trigger Scenario10_Trigger on Deal_Registration__c (after update) {

    if (Trigger.isAfter && Trigger.isUpdate) {
        Scenario10_Handler.afterUpdate(Trigger.new, Trigger.oldMap);
    }

}