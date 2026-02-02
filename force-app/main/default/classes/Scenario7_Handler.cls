public class Scenario7_Handler {

    public static void beforeInsertUpdate(
        List<Contact> newContacts,
        Map<Id, Contact> oldMap
    ) {

        Set<Id> accountIds = new Set<Id>();
        for (Contact c : newContacts) {

            Boolean becomingPrimary =
                c.Primary_Partner_Contact__c == true &&
                (oldMap == null ||
                 oldMap.get(c.Id).Primary_Partner_Contact__c == false);

            if (becomingPrimary && c.AccountId != null) {
                accountIds.add(c.AccountId);
            }
        }

        if (accountIds.isEmpty()) return;
        Map<Id, Contact> primaryByAccount = new Map<Id, Contact>();

        for (Contact existing : [
            SELECT Id, AccountId
            FROM Contact
            WHERE Primary_Partner_Contact__c = true
            AND AccountId IN :accountIds
        ]) {
            primaryByAccount.put(existing.AccountId, existing);
        }

        for (Contact c : newContacts) {

            if (c.Primary_Partner_Contact__c == true &&
                c.AccountId != null &&
                primaryByAccount.containsKey(c.AccountId)) {
                if (oldMap != null &&
                    primaryByAccount.get(c.AccountId).Id == c.Id) {
                    continue;
                }

                c.Primary_Partner_Contact__c.addError(
                    'Only one Primary Partner Contact is allowed per Partner Account.'
                );
            }
        }
    }
}