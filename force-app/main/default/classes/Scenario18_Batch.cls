public class Scenario18_Batch
    implements Database.Batchable<SObject> {

    private Set<Id> accountIds;

    public Scenario18_Batch(Set<Id> accIds) {
        this.accountIds = accIds;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {

        return Database.getQueryLocator(
            [
                SELECT Id, Partner_Account__c, Status__c
                FROM Deal_Registration__c
                WHERE Partner_Account__c IN :accountIds
            ]
        );
    }

    public void execute(
        Database.BatchableContext bc,
        List<Deal_Registration__c> scope
    ) {
        Set<Id> ids = new Set<Id>();

        for (Deal_Registration__c d : scope) {
            ids.add(d.Partner_Account__c);
        }

        Scenario16_Handler.recalculatePartnerStats(ids);
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Scenario18 Batch completed');
    }
}