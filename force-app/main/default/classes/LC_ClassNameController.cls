/**
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * Controller class is our main entrypoint to appropriate logic. Here we keep a filtration between different method based on
 * accepted params map. Each method calls its service method and wrap received response in expected Response class.
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
 */

// Test: LC_ClassNameTest
public without sharing class LC_ClassNameController implements LC_IController {

    public class LC_ClassNameException extends Exception {}

    public Response executeAction(Map<String, Object> params) {
        String actionName = (String) params.get('actionName');
        switch on actionName {
            when 'someMethod1' {
                return this.someMethod1(
                    (String) params.get('recordId')
                );
            }
            when 'getCurrentUser' {
                return this.getCurrentUser();
            }
            when else {
                throw new LC_ClassNameException('UNKNOWN ACTION: ' + actionName);
            }
        }
    }

    private Response someMethod1(String recordId) {
        System.debug('LC_ClassNameController.someMethod1...');
        LC_ClassNameService.getInstance(recordId).someMethod1();

        return new Response('success');
    }

    private Response getCurrentUser() {
        System.debug('LC_ClassNameController.getCurrentUser...');

        return new Response(LC_ClassNameService.getInstance().getCurrentUser());
    }
}