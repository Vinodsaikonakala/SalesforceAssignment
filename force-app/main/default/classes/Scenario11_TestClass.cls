@isTest
public class Scenario11_TestClass {

    @testSetup
    static void setupConfig() {

        Deal_Limit_Config__c cs = new Deal_Limit_Config__c(
            Name = 'OrgDefaults',
            Max_Open_Deals__c = 1
        );
        insert cs;
    }

    @isTest
    static void testLimitExceeded() {

        Account acc = new Account(Name = 'Partner');
        insert acc;

        Deal_Registration__c d1 = new Deal_Registration__c(
            Name = 'Deal1',
            Partner_Account__c = acc.Id,
            Status__c = 'Submitted'
        );
        insert d1;

        Deal_Registration__c d2 = new Deal_Registration__c(
            Name = 'Deal2',
            Partner_Account__c = acc.Id,
            Status__c = 'Submitted'
        );

        Test.startTest();
        Database.SaveResult sr = Database.insert(d2, false);
        Test.stopTest();

        System.assertEquals(false, sr.isSuccess());
    }
}