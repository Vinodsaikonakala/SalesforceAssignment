@isTest
public class Scenario3_TestClass {

    @isTest
    static void testBlockTierChangeWhenSuspended() {

        Account acc = new Account(
            Name = 'Partner',
            Is_Partner__c = true,
            Partner_Status__c = 'Suspended',
            Partner_Tier__c = 'Gold'
        );
        insert acc;

        acc.Partner_Tier__c = 'Silver';

        Test.startTest();
        Database.SaveResult sr = Database.update(acc, false);
        Test.stopTest();

        System.assertEquals(false, sr.isSuccess());
        System.assert(
            sr.getErrors()[0].getMessage().contains('Suspended')
        );
    }

    @isTest
    static void testAllowChangeWhenNotSuspended() {

        Account acc = new Account(
            Name = 'Partner',
            Is_Partner__c = true,
            Partner_Status__c = 'Active',
            Partner_Tier__c = 'Gold'
        );
        insert acc;

        acc.Partner_Tier__c = 'Silver';
        update acc;

        Account updated =
            [SELECT Partner_Tier__c FROM Account WHERE Id = :acc.Id];

        System.assertEquals('Silver', updated.Partner_Tier__c);
    }
}