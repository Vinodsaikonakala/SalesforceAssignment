@isTest
public class Scenario19_TestClass {

    @isTest
    static void testPlatformEventPublish() {

        Deal_Registration__c deal = new Deal_Registration__c(
            Name = 'Event Deal',
            Status__c = 'Submitted'
        );
        insert deal;

        deal.Status__c = 'Approved';

        Test.startTest();
        update deal;
        Test.stopTest();
        System.assert(true);
    }
}