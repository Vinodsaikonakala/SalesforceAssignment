trigger Scenario1_Trigger on Account (before insert) {
    Scenario1_Handler.beforeInsert(Trigger.new);
}