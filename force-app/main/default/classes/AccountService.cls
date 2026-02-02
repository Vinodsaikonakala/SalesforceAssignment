public class AccountService {
    public static List<Account> getAllAccounts() {
        return [SELECT Id, Name FROM Account];
    }
}