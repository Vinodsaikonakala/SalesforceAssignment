@isTest
public class Scenario10_TestClass {

    @isTest
    static void testRejectionLogCreated() {

        Deal_Registration__c deal = new Deal_Registration__c(
            Name = 'Test Deal',
            Status__c = 'Submitted'
        );
        insert deal;
        
        deal.Status__c = 'Rejected';

        Test.startTest();
        update deal;
        Test.stopTest();

        Rejection_Log__c log = [
            SELECT Deal__c, Rejected_Date__c
            FROM Rejection_Log__c
            WHERE Deal__c = :deal.Id
            LIMIT 1
        ];

        System.assertEquals(deal.Id, log.Deal__c);
        System.assertEquals(Date.today(), log.Rejected_Date__c);
    }
}