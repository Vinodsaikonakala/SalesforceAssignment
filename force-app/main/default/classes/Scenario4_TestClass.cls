@isTest
public class Scenario4_TestClass {

    @isTest
    static void testPartnerRegionCopiedToDeal() {

        Account acc = new Account(
            Name = 'Partner Acc',
            Is_Partner__c = true,
            Partner_Region__c = 'South'
        );
        insert acc;

        Deal_Registration__c deal = new Deal_Registration__c(
            Name = 'Test Deal',
            Partner_Account__c = acc.Id
        );

        Test.startTest();
        insert deal;
        Test.stopTest();

        Deal_Registration__c result = [
            SELECT Partner_Region__c
            FROM Deal_Registration__c
            WHERE Id = :deal.Id
        ];

        System.assertEquals('South', result.Partner_Region__c);
    }

    @isTest
    static void testNoErrorWhenNoAccount() {

        Deal_Registration__c deal = new Deal_Registration__c(
            Name = 'No Account Deal'
        );

        insert deal;

        System.assert(true);
    }
}