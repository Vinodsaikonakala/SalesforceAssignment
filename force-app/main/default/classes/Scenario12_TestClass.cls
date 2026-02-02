@isTest
public class Scenario12_TestClass {

    @isTest
    static void testDealSharing() {

        Account acc = new Account(
            Name = 'Partner Account',
            Is_Partner__c = true
        );
        insert acc;

        Contact con = new Contact(
            LastName = 'Partner User',
            AccountId = acc.Id,
            Email = 'testuser@example.com'
        );
        insert con;

        Profile p = [
            SELECT Id
            FROM Profile
            WHERE Name = 'Standard User'
            LIMIT 1
        ];

        User u = new User(
            Alias = 'ptest',
            Email = 'ptest@example.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Partner',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            TimeZoneSidKey = 'Asia/Kolkata',
            ProfileId = p.Id,
            Username = 'ptest' + System.currentTimeMillis() + '@example.com',
            ContactId = con.Id
        );
        insert u;

        Deal_Registration__c deal = new Deal_Registration__c(
            Name = 'Test Deal',
            Partner_Account__c = acc.Id
        );

        Test.startTest();
        insert deal;
        Test.stopTest();

        List<Deal_Registration__Share> shares = [
            SELECT Id, UserOrGroupId
            FROM Deal_Registration__Share
            WHERE ParentId = :deal.Id
        ];

        System.assert(shares.size() > 0,
            'Deal should be shared with partner user');
    }
}