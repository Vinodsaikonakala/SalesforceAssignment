public with sharing class DealController {

    @AuraEnabled(cacheable=true)
    public static List<Deal_Registration__c> getDeals(
        Id partnerId,
        String status
    ) {

        String query =
            'SELECT Id, Name, Status__c, ' +
            'Expected_Amount__c, Close_Date__c, Partner_Account__c ' +
            'FROM Deal_Registration__c WHERE Id != null';

        // ✅ Inject Partner Id safely
        if (partnerId != null) {
            query += ' AND Partner_Account__c = \'' + String.escapeSingleQuotes(partnerId) + '\'';
        }

        // ✅ Inject Status safely
        if (String.isNotBlank(status)) {
            query += ' AND Status__c = \'' + String.escapeSingleQuotes(status) + '\'';
        }

        query += ' ORDER BY CreatedDate DESC LIMIT 50';

        System.debug('Final SOQL => ' + query);

        return Database.query(query);
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getPartnerAccounts() {

        return [
            SELECT Id, Name
            FROM Account
            WHERE Is_Partner__c = true
            ORDER BY Name
        ];
    }
}