/**
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * As always, prepare data in the test setup method and then work with it in each method to cover the logic.
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
 */

@isTest
public with sharing class SObjectNameTRTest {

    @TestSetup
    static void makeData() {
        // to do: prepare data
    }

    @isTest
    static void someMethodFirstTest() {
        Test.startTest();
        // to do: cover the method
        Test.stopTest();
    }

    @isTest
    static void someMethodSecondTest() {
        Test.startTest();
        // to do: cover the method
        Test.stopTest();
    }
}