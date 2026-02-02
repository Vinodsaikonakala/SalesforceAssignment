trigger Scenario12_Trigger on Deal_Registration__c (after insert) {

    if (Trigger.isAfter && Trigger.isInsert) {
        Scenario12_Handler.afterInsert(Trigger.new);
    }

}