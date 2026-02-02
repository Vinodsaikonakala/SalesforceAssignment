@isTest
public class Scenario7_TestClass {

    @isTest
    static void testPreventSecondPrimary() {

        Account acc = new Account(
            Name = 'Partner',
            Is_Partner__c = true
        );
        insert acc;

        Contact c1 = new Contact(
            LastName = 'Primary',
            AccountId = acc.Id,
            Primary_Partner_Contact__c = true
        );
        insert c1;

        Contact c2 = new Contact(
            LastName = 'Second',
            AccountId = acc.Id,
            Primary_Partner_Contact__c = true
        );

        Test.startTest();
        Database.SaveResult sr = Database.insert(c2, false);
        Test.stopTest();

        System.assertEquals(false, sr.isSuccess());
        System.assert(
            sr.getErrors()[0].getMessage().contains('Only one Primary')
        );
    }

    @isTest
    static void testAllowNonPrimaryContacts() {

        Account acc = new Account(Name = 'Partner');
        insert acc;

        Contact c1 = new Contact(
            LastName = 'C1',
            AccountId = acc.Id,
            Primary_Partner_Contact__c = false
        );
        Contact c2 = new Contact(
            LastName = 'C2',
            AccountId = acc.Id,
            Primary_Partner_Contact__c = false
        );

        insert new List<Contact>{ c1, c2 };

        System.assertEquals(2,
            [SELECT COUNT() FROM Contact WHERE AccountId = :acc.Id]);
    }

    @isTest
    static void testUpdateToPrimaryBlocked() {

        Account acc = new Account(Name = 'Partner');
        insert acc;

        Contact c1 = new Contact(
            LastName = 'Primary',
            AccountId = acc.Id,
            Primary_Partner_Contact__c = true
        );
        Contact c2 = new Contact(
            LastName = 'Second',
            AccountId = acc.Id,
            Primary_Partner_Contact__c = false
        );
        insert new List<Contact>{ c1, c2 };
        c2.Primary_Partner_Contact__c = true;

        Test.startTest();
        Database.SaveResult sr = Database.update(c2, false);
        Test.stopTest();

        System.assertEquals(false, sr.isSuccess());
    }
}