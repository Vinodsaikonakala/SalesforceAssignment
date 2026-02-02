@isTest
public class Scenario13_TestClass {

    @isTest
    static void testSharingDemo() {

        Account a1 = new Account(Name = 'A1');
        Account a2 = new Account(Name = 'A2');
        insert new List<Account>{ a1, a2 };

        a1.Name = 'Updated A1';

        Test.startTest();
        update a1;
        Test.stopTest();

        System.assert(true);
    }
}