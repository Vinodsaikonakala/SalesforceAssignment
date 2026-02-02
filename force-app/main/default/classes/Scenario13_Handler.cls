public class Scenario13_Handler {

    public static void afterUpdate(List<Account> accounts) {

        Integer withSharingCount =
            Scenario13_WithSharing_Service.getVisibleAccountCount();

        Integer withoutSharingCount =
            Scenario13_WithoutSharing_Service.getAllAccountCount();

        System.debug('With Sharing Count = ' + withSharingCount);
        System.debug('Without Sharing Count = ' + withoutSharingCount);
    }
}