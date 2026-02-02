@isTest
public class Scenario2_TestClass {

    @testSetup
    static void setupQueue() {

        Group q = new Group(
            Name = 'Partner Manager Queue',
            Type = 'Queue'
        );
        insert q;

        QueueSobject qs = new QueueSobject(
            QueueId = q.Id,
            SobjectType = 'Task'
        );
        insert qs;
    }

    @isTest
    static void testTaskCreatedForPartner() {

        Account acc = new Account(
            Name = 'Partner Acc',
            Is_Partner__c = true
        );

        Test.startTest();
        insert acc;
        Test.stopTest();

        Task t = [
            SELECT Subject, WhatId, OwnerId
            FROM Task
            WHERE WhatId = :acc.Id
            LIMIT 1
        ];

        System.assertEquals('Review New Partner', t.Subject);
        System.assertEquals(acc.Id, t.WhatId);
    }

    @isTest
    static void testNoTaskForNonPartner() {

        Account acc = new Account(
            Name = 'Normal Acc',
            Is_Partner__c = false
        );

        insert acc;

        Integer cnt = [
            SELECT COUNT()
            FROM Task
            WHERE WhatId = :acc.Id
        ];

        System.assertEquals(0, cnt);
    }
}