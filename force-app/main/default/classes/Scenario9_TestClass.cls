@isTest
public class Scenario9_TestClass {

    @isTest
    static void testLastDealDateUpdated() {

        Account acc = new Account(
            Name = 'Partner',
            Is_Partner__c = true
        );
        insert acc;

        Deal_Registration__c deal = new Deal_Registration__c(
            Name = 'Test Deal',
            Partner_Account__c = acc.Id
        );

        Test.startTest();
        insert deal;
        Test.stopTest();

        Account updated = [
            SELECT Last_Deal_Date__c
            FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals(Date.today(), updated.Last_Deal_Date__c);
    }
}