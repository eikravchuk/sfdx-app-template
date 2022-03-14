/**
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * Create a trigger using this template. Single trigger per SObject. Add all trigger events. Wrap the handler execution in an
 * additional check if the trigger for this SObject active (based on metadata settings).
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
 */

// Test: SObjectNameTRTest
trigger SObjectNameTR on SObjectName (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    TRSettingService.TRSetting sobjectTR = TRSettingService.getInstance().getSettings('SObjectName');
    if (sobjectTR.isActive()) {
        SObjectNameTRHandler.handleTrigger(Trigger.new, Trigger.oldMap, Trigger.operationType);
    }
}