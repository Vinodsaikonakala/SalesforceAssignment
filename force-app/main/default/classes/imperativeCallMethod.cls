public with sharing class imperativeCallMethod {

    @AuraEnabled(cacheable=false)
    public static List<Account> getAccounts(String keyword) {
        keyword = '%' + keyword + '%';
        return [
            SELECT Id, Name, Industry, Phone, Website
            FROM Account
            WHERE Name LIKE :keyword
            LIMIT 50
        ];
    }
}