@isTest
public class Scenario5_TestClass {

    @isTest
    static void testDealCountInsertAndDelete() {

        Account acc = new Account(
            Name = 'Partner',
            Is_Partner__c = true
        );
        insert acc;

        Deal_Registration__c d1 = new Deal_Registration__c(
            Name = 'Deal 1',
            Partner_Account__c = acc.Id
        );
        Deal_Registration__c d2 = new Deal_Registration__c(
            Name = 'Deal 2',
            Partner_Account__c = acc.Id
        );

        Test.startTest();
        insert new List<Deal_Registration__c>{ d1, d2 };
        Test.stopTest();

        Account a1 = [
            SELECT Registered_Deals__c
            FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals(2, a1.Registered_Deals__c);

        Test.startTest();
        delete d1;
        Test.stopTest();

        Account a2 = [
            SELECT Registered_Deals__c
            FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals(1, a2.Registered_Deals__c);
    }
}