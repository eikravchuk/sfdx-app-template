/**
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * Use a Util class to keep static necessary variables (constant, hardcoded values) and methods (some generic query etc).
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
 */

// Test: SObjectNameTRTest
public with sharing class SObjectNameTRUtil {

    public static final Map<String, Schema.RecordTypeInfo> SOBJECTNAME_RT_MAP = Schema.SObjectType.SObjectName.getRecordTypeInfosByDeveloperName();
    public static final String SOME_PROFILE_ID = System.Label.SomeProfileId;
}