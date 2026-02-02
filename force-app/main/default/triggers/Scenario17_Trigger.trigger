trigger Scenario17_Trigger on Deal_Registration__c (after insert) {

    if (Trigger.isAfter && Trigger.isInsert) {
        Scenario17_Handler.afterInsert(Trigger.new);
    }

}