public class Scenario2_Handler {

    public static void afterInsert(List<Account> newAccounts) {

        if (newAccounts == null || newAccounts.isEmpty()) return;

        List<Group> queues = [
            SELECT Id
            FROM Group
            WHERE Type = 'Queue'
            AND Name = 'Partner Manager Queue'
            LIMIT 1
        ];

        if (queues.isEmpty()) {
            System.debug('Partner Manager Queue not found. Task creation skipped.');
            return;
        }

        Id queueId = queues[0].Id;

        List<Task> tasksToInsert = new List<Task>();

        for (Account acc : newAccounts) {

            if (acc.Is_Partner__c == true) {

                Task t = new Task();
                t.Subject = 'Review New Partner';
                t.WhatId = acc.Id;          
                t.OwnerId = queueId;        
                t.ActivityDate = Date.today().addDays(2);
                t.Status = 'Not Started';
                t.Priority = 'Normal';

                tasksToInsert.add(t);
            }
        }

        if (!tasksToInsert.isEmpty()) {
            insert tasksToInsert;
        }
    }
}