public class Scenario12_Handler {

    public static void afterInsert(List<Deal_Registration__c> newDeals) {

        Set<Id> accountIds = new Set<Id>();

        for (Deal_Registration__c d : newDeals) {
            if (d.Partner_Account__c != null) {
                accountIds.add(d.Partner_Account__c);
            }
        }

        if (accountIds.isEmpty()) return;

        Map<Id, List<User>> accountUsersMap = new Map<Id, List<User>>();

        for (User u : [
            SELECT Id, Contact.AccountId
            FROM User
            WHERE Contact.AccountId IN :accountIds
        ]) {
            if (!accountUsersMap.containsKey(u.Contact.AccountId)) {
                accountUsersMap.put(
                    u.Contact.AccountId,
                    new List<User>()
                );
            }
            accountUsersMap.get(u.Contact.AccountId).add(u);
        }

        List<Deal_Registration__Share> shares =
            new List<Deal_Registration__Share>();

        for (Deal_Registration__c d : newDeals) {

            if (d.Partner_Account__c == null ||
                !accountUsersMap.containsKey(d.Partner_Account__c)) {
                continue;
            }

            for (User u : accountUsersMap.get(d.Partner_Account__c)) {

                Deal_Registration__Share sh =
                    new Deal_Registration__Share();

                sh.ParentId = d.Id;
                sh.UserOrGroupId = u.Id;
                sh.AccessLevel = 'Edit';
                sh.RowCause = Schema.Deal_Registration__Share.RowCause.Manual;

                shares.add(sh);
            }
        }

        if (!shares.isEmpty()) {
            insert shares;
        }
    }
}