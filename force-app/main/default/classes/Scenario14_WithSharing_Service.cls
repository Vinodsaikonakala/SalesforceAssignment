public with sharing class Scenario14_WithSharing_Service {

    public static Set<Id> getAccessibleAccountIds(Set<Id> accountIds) {

        Set<Id> visibleIds = new Set<Id>();

        for (Account acc : [
            SELECT Id
            FROM Account
            WHERE Id IN :accountIds
        ]) {
            visibleIds.add(acc.Id);
        }

        return visibleIds;
    }
}