/**
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * Use Dispatcher class to keep inner methods filtration by Users, Profiles, Record Types, specific fields values, changes
 * fields etc. Add a comment section with a short description, filter details and who is responsible for development.
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
 */

// Test: SObjectNameTRTest
public with sharing class SObjectNameTRDispatcher {

    /*
     * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
     * Short description of the logic
     * 
     * Event                BEFORE_INSERT, BEFORE_UPDATE
     * User                 *
     * Profile              *
     * Record Type          SomeRTDevName
     * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
     * @created             29-03-2021                     <evgeniy.kravchuk@synebo.io>
     * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
     */
    public static void someMethodFirst(List<SObjectName> newList, Map<Id, SObjectName> oldMap) {
        System.debug('LOG SObjectName someMethodFirst ... start');
        Id someRTId = SObjectNameTRUtil.SOBJECTNAME_RT_MAP.get('SomeRTDevName').getRecordTypeId();
        List<SObjectName> sobjects = new List<SObjectName>();
        Set<Id> someIds = new Set<Id>();

        for (SObjectName sobject_i : newList) {
            if (sobject_i.RecordTypeId == someRTId &&
                    sobject_i.SomeLookup != null &&
                    (oldMap == null ||
                    oldMap.get(sobject_i.Id).SomeLookup != sobject_i.SomeLookup)) {
                sobjects.add(sobject_i);
                someIds.add(sobject_i.SomeLookup);
            }
        }
        System.debug('sobjects: size: ' + sobjects.size() + ' value: ' + sobjects);
        System.debug('someIds: size: ' + someIds.size() + ' value: ' + someIds);

        if (!sobjects.isEmpty()) {
            SObjectNameTRService.someMethodFirst(sobjects, someIds);
        }
    }

    /*
     * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
     * Short description of the logic
     * 
     * Event            AFTER_INSERT, AFTER_UPDATE
     * User             *
     * Profile          SomeProfileName
     * Record Type      *
     * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
     * @created             28-03-2021                     <your.name@synebo.io>
     * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
     * @modified            29-03-2021                     <your.name@synebo.io>
     * @description         an additional check that the SomeFieldSecond is changed was added to the main filtration
     * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
     */
    public static void someMethodSecond(List<SObjectName> newList, Map<Id, SObjectName> oldMap) {
        System.debug('LOG SObjectName someMethodSecond ... start');
        List<SObjectName> sobjects = new List<SObjectName>();

        for (SObjectName sobject_i : newList) {
            if (UserInfo.getProfileId() == SObjectNameTRUtil.SOME_PROFILE_ID &&
                    sobject_i.SomeFieldFirst != null && 
                    (oldMap == null ||
                    oldMap.get(sobject_i.Id).SomeFieldFirst != sobject_i.SomeFieldFirst ||
                    oldMap.get(sobject_i.Id).SomeFieldSecond != sobject_i.SomeFieldSecond)) {
                sobjects.add(sobject_i);
            }
        }
        System.debug('sobjects: size: ' + sobjects.size() + ' value: ' + sobjects);

        if (!sobjects.isEmpty()) {
            SObjectNameTRService.someMethodSecond(sobjects);
        }
    }
}