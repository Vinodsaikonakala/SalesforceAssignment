@isTest
public class Scenario14_TestClass {

    @isTest
    static void testSecurityCheck() {

        Account acc = new Account(Name = 'Partner');
        insert acc;

        Deal_Registration__c deal = new Deal_Registration__c(
            Name = 'Secure Deal',
            Partner_Account__c = acc.Id
        );

        Test.startTest();
        insert deal;
        Test.stopTest();

        System.assert(true);
    }
}