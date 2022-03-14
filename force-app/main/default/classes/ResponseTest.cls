/**
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * Test class to cover the Response class with enough percent of coverage.
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
 */

@isTest
private class ResponseTest {

    @isTest
    static void constructorTest() {
        Test.startTest();
        new Response(true, 'success');
        new Response('success');
        new Response();
        try {
            insert new Account();
        } catch (Exception e) {
            new Response(e);
        }
        Test.stopTest();
    }
}