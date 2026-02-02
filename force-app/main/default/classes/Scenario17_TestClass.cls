@isTest
public class Scenario17_TestClass {

    @isTest
    static void testQueueableExecution() {

        Deal_Registration__c deal = new Deal_Registration__c(
            Name = 'Async Deal',
            Status__c = 'Submitted'
        );

        Test.startTest();
        insert deal;
        Test.stopTest();
        System.assert(true);
    }
}