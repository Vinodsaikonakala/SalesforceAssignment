public class Scenario17_Queueable
    implements Queueable, Database.AllowsCallouts {

    private List<Id> dealIds;

    public Scenario17_Queueable(List<Id> dealIds) {
        this.dealIds = dealIds;
    }

    public void execute(QueueableContext context) {

        List<Deal_Registration__c> deals = [
            SELECT Id, Name, Status__c
            FROM Deal_Registration__c
            WHERE Id IN :dealIds
        ];

        for (Deal_Registration__c d : deals) {
            System.debug(
                'Async Processing Deal: ' + d.Name
            );
        }

    }
}