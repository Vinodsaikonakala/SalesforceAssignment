trigger Scenario9_Trigger on Deal_Registration__c (after insert) {

    if (Trigger.isAfter && Trigger.isInsert) {
        Scenario9_Handler.afterInsert(Trigger.new);
    }

}