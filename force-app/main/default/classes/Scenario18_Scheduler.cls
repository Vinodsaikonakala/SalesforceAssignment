public class Scenario18_Scheduler
    implements Schedulable {

    public void execute(SchedulableContext sc) {
        Database.executeBatch(
            new Scenario18_Batch(new Set<Id>()), 200
        );
    }
}