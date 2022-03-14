/**
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * As always, prepare data in the test setup method and then work with it in each method to cover the logic.
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
 */

@isTest
private class LC_ClassNameTest {

    @TestSetup
    static void makeData() {
        // to do: prepare data
    }

    @isTest
    static void exceptionTest() {
        LC_ClassNameController controller = new LC_ClassNameController();

        Test.startTest();
        try {
            controller.executeAction(new Map<String, Object>{'actionName' => 'wrong'});
        } catch (Exception e) {
            System.assertEquals('UNKNOWN ACTION: wrong', e.getMessage());
        }
        Test.stopTest();
    }

    @isTest
    static void someMethod1Test() {
        LC_ClassNameController controller = new LC_ClassNameController();
        SObject record = [SELECT Id FROM SObject LIMIT 1];

        Test.startTest();
        controller.executeAction(new Map<String, Object>{'actionName' => 'wrong', 'recordId' => record.Id});
        Test.stopTest();
    }

    @isTest
    static void someMethod2Test() {
        LC_ClassNameController controller = new LC_ClassNameController();

        Test.startTest();
        controller.executeAction(new Map<String, Object>{'actionName' => 'wrong', 'someVariable' => 'someVariable'});
        Test.stopTest();
    }
}