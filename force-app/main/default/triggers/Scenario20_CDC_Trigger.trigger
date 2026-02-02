trigger Scenario20_CDC_Trigger
on Deal_Registration__ChangeEvent (after insert) {

    for (Deal_Registration__ChangeEvent evt : Trigger.new) {

        System.debug('CDC Event Received');

        // ✅ Correct way to access record Ids
        List<Id> recordIds = evt.ChangeEventHeader.getRecordIds();
        System.debug('Record Ids: ' + recordIds);

        // ✅ Correct way to access change type
        String changeType = evt.ChangeEventHeader.getChangeType();
        System.debug('Change Type: ' + changeType);
    }
}