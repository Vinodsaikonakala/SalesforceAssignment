public class Scenario18_Handler {

    public static void collectAccounts(List<Deal_Registration__c> deals) {

        Set<Id> accIds = new Set<Id>();

        for (Deal_Registration__c d : deals) {
            if (d.Partner_Account__c != null) {
                accIds.add(d.Partner_Account__c);
            }
        }

        if (!accIds.isEmpty()) {
            Database.executeBatch(
                new Scenario18_Batch(accIds), 200
            );
        }
    }
}