@isTest
public class Scenario15_TestClass {

    @isTest
    static void testNormalizePartnerTier() {

        Account acc = new Account(
            Name = 'Partner',
            Is_Partner__c = true
        );
        insert acc;

        acc.Name = 'Updated Name';
        update acc;

        Account updated = [
            SELECT Partner_Tier__c
            FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals('Standard', updated.Partner_Tier__c);
    }
}