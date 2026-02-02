public class Scenario20_Handler {

    public static void processEvents(
        List<Deal_Registration__ChangeEvent> events
    ) {

        for (Deal_Registration__ChangeEvent evt : events) {

            List<Id> recordIds =
                evt.ChangeEventHeader.getRecordIds();

            String changeType =
                evt.ChangeEventHeader.getChangeType();

            System.debug(
                'Processing CDC → RecordIds: ' +
                recordIds + ' | Type: ' + changeType
            );
        }
    }
}