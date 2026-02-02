@isTest
public class Scenario1_TestClass {

    @testSetup
    static void setupCustomSetting() {

        Partner_Config__c cs = new Partner_Config__c(
            Name = 'OrgDefaults',
            Default_Partner_Tier__c = 'Gold'
        );
        insert cs;
    }

    @isTest
    static void testPartnerGetsDefaultTier() {

        Account acc = new Account(
            Name = 'Partner Account',
            Is_Partner__c = true
        );

        Test.startTest();
        insert acc;
        Test.stopTest();

        Account result =
            [SELECT Partner_Tier__c
             FROM Account
             WHERE Id = :acc.Id];

        System.assertEquals(
            'Gold',
            result.Partner_Tier__c,
            'Partner Tier should be defaulted from Custom Setting'
        );
    }

    @isTest
    static void testNonPartnerNotUpdated() {

        Account acc = new Account(
            Name = 'Normal Account',
            Is_Partner__c = false
        );

        insert acc;

        Account result =
            [SELECT Partner_Tier__c
             FROM Account
             WHERE Id = :acc.Id];

        System.assertEquals(
            null,
            result.Partner_Tier__c,
            'Non-partner account should not get Partner Tier'
        );
    }

    @isTest
    static void testBulkInsert() {

        List<Account> accList = new List<Account>();

        for (Integer i = 0; i < 200; i++) {
            accList.add(new Account(
                Name = 'Partner ' + i,
                Is_Partner__c = true
            ));
        }

        Test.startTest();
        insert accList;
        Test.stopTest();

        Integer cnt =
            [SELECT COUNT()
             FROM Account
             WHERE Partner_Tier__c = 'Gold'];

        System.assertEquals(
            200,
            cnt,
            'All partner accounts should get default tier in bulk insert'
        );
    }
}