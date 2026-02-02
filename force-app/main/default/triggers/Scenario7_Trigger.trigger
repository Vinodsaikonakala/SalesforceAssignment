trigger Scenario7_Trigger on Contact (before insert, before update) {

    if (Trigger.isBefore) {

        if (Trigger.isInsert) {
            Scenario7_Handler.beforeInsertUpdate(Trigger.new, null);
        }

        if (Trigger.isUpdate) {
            Scenario7_Handler.beforeInsertUpdate(Trigger.new, Trigger.oldMap);
        }
    }
}