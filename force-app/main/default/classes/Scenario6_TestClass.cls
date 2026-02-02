@isTest
public class Scenario6_TestClass {

    @isTest
    static void testOpportunityCreatedWhenApproved() {

        Account partner = new Account(
            Name = 'Partner',
            Is_Partner__c = true
        );
        insert partner;

        Account customer = new Account(
            Name = 'Customer'
        );
        insert customer;

        Deal_Registration__c deal = new Deal_Registration__c(
            Name = 'Test Deal',
            Status__c = 'Submitted',
            Partner_Account__c = partner.Id,
            End_Customer_Account__c = customer.Id
        );
        insert deal;

        deal.Status__c = 'Approved';

        Test.startTest();
        update deal;
        Test.stopTest();

        Opportunity opp = [
            SELECT StageName, AccountId
            FROM Opportunity
            WHERE AccountId = :customer.Id
            LIMIT 1
        ];

        System.assertEquals('Qualification', opp.StageName);
        System.assertEquals(customer.Id, opp.AccountId);
    }

    @isTest
    static void testNoOpportunityWhenStatusNotApproved() {

        Account customer = new Account(Name = 'Cust');
        insert customer;

        Deal_Registration__c deal = new Deal_Registration__c(
            Name = 'Deal',
            Status__c = 'Submitted',
            End_Customer_Account__c = customer.Id
        );
        insert deal;

        deal.Status__c = 'In Review';
        update deal;

        Integer cnt = [SELECT COUNT() FROM Opportunity];

        System.assertEquals(0, cnt);
    }
}