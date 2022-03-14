/**
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * Here is the main trigger filtration by event types.
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
 */

// Test: SObjectNameTRTest
public with sharing class SObjectNameTRHandler {

    public static void handleTrigger(List<SObjectName> newList, Map<Id, SObjectName> oldMap, System.TriggerOperation triggerEvent) {
        System.debug('SObjectNameTRHandler.handleTrigger...');
        TRSettingService.TRSetting sobjectTR = TRSettingService.getInstance().getSettings('SObjectName');

        switch on triggerEvent {
            when BEFORE_INSERT {
                System.debug('TR SObjectName BEFORE_INSERT');
                if (sobjectTR.isMethodActive('someMethodFirst')) {
                    SObjectNameTRDispatcher.someMethodFirst(newList, null);
                }
            }
            when BEFORE_UPDATE {
                System.debug('TR SObjectName BEFORE_UPDATE');
                if (sobjectTR.isMethodActive('someMethodFirst')) {
                    SObjectNameTRDispatcher.someMethodFirst(newList, oldMap);
                }
            }
            when AFTER_INSERT {
                System.debug('TR SObjectName AFTER_INSERT');
                if (sobjectTR.isMethodActive('someMethodSecond')) {
                    SObjectNameTRDispatcher.someMethodSecond(newList, null);
                }
            }
            when AFTER_UPDATE {
                System.debug('TR SObjectName AFTER_UPDATE');
                if (sobjectTR.isMethodActive('someMethodSecond')) {
                    SObjectNameTRDispatcher.someMethodSecond(newList, oldMap);
                }
            }
        }
    }
}