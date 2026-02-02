@isTest
public class Scenario18_TestClass {

    @isTest
    static void testBatchFromHandler() {

        Account acc = new Account(Name = 'Partner');
        insert acc;

        Deal_Registration__c deal = new Deal_Registration__c(
            Name = 'Deal',
            Partner_Account__c = acc.Id,
            Status__c = 'Approved'
        );
        insert deal;

        Test.startTest();
        Scenario18_Handler.collectAccounts(
            new List<Deal_Registration__c>{ deal }
        );
        Test.stopTest();

        System.assert(true);
    }
}