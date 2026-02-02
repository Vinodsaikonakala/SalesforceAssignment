public without sharing class Scenario13_WithoutSharing_Service {

    public static Integer getAllAccountCount() {
        return [SELECT COUNT() FROM Account];
    }
}