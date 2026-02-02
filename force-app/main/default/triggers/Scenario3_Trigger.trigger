trigger Scenario3_Trigger on Account (before update) {

    if (Trigger.isBefore && Trigger.isUpdate) {
        Scenario3_Handler.beforeUpdate(Trigger.new, Trigger.oldMap);
    }

}