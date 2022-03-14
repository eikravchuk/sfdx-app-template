/**
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * Keep in a Service class the main logic that will be executed after Dispatcher has filtered data and pass them forward.
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
 */

// Test: SObjectNameTRTest
public with sharing class SObjectNameTRService {

    public static void someMethodFirst(List<SObjectName> sobjects, Set<Id> someIds) {

        // to do: main logic without update

        System.debug('LOG SObjectName someMethodFirst ... logic has been executed');
    }

    public static void someMethodSecond(List<SObjectName> sobjects) {
        List<SObjectName> sobjectsToUpdate = new List<SObjectName>();

        // to do: main logic with update

        System.debug('sobjectsToUpdate: size: ' + sobjectsToUpdate.size() + ' value: ' + sobjectsToUpdate);
        if (!sobjectsToUpdate.isEmpty()) {
            update sobjectsToUpdate;
            System.debug('LOG SObjectName someMethodSecond ... logic has been executed');
        }
    }
}