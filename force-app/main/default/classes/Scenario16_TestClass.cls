@isTest
public class Scenario16_TestClass {

    @isTest
    static void testPartnerSummary() {

        Account acc = new Account(Name = 'Partner');
        insert acc;

        Deal_Registration__c d1 = new Deal_Registration__c(
            Name = 'D1',
            Partner_Account__c = acc.Id,
            Status__c = 'Approved',
            Amount__c = 1000
        );

        Deal_Registration__c d2 = new Deal_Registration__c(
            Name = 'D2',
            Partner_Account__c = acc.Id,
            Status__c = 'Submitted',
            Amount__c = 500
        );

        Test.startTest();
        insert new List<Deal_Registration__c>{ d1, d2 };
        Test.stopTest();

        Account updated = [
            SELECT Total_Deals__c,
                   Approved_Deals__c,
                   Total_Deal_Amount__c
            FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals(2, updated.Total_Deals__c);
        System.assertEquals(1, updated.Approved_Deals__c);
        System.assertEquals(1500, updated.Total_Deal_Amount__c);
    }
}