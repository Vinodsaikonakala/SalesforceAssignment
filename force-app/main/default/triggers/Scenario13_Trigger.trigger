trigger Scenario13_Trigger on Account (after update) {

    if (Trigger.isAfter && Trigger.isUpdate) {
        Scenario13_Handler.afterUpdate(Trigger.new);
    }

}