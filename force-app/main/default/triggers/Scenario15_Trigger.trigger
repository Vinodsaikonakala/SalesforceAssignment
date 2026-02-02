trigger Scenario15_Trigger on Account (after update) {

    if (Trigger.isAfter && Trigger.isUpdate) {
        Scenario15_Handler.afterUpdate(Trigger.new);
    }

}