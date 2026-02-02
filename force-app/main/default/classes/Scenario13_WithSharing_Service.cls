public with sharing class Scenario13_WithSharing_Service {

    public static Integer getVisibleAccountCount() {
        return [SELECT COUNT() FROM Account];
    }
}