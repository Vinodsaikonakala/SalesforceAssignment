trigger Scenario2_Trigger on Account (after insert) {

    if (Trigger.isAfter && Trigger.isInsert) {
        Scenario2_Handler.afterInsert(Trigger.new);
    }

}