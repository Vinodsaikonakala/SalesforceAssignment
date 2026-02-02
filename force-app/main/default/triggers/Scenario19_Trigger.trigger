trigger Scenario19_Trigger on Deal_Registration__c (after update) {

    if (Trigger.isAfter && Trigger.isUpdate) {
        Scenario19_Handler.afterUpdate(
            Trigger.new, Trigger.oldMap
        );
    }

}