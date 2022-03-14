/**
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * The Service class is our main logic keeper. It's useful to use singleton pattern here to call some initial logic once and
 * then work with it through all the methods. Custom wrappers with their inner logic also stay here.
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
 */

// Test: LC_ClassNameTest
public without sharing class LC_ClassNameService {

    public class LC_ClassNameException extends Exception {}

    private static LC_ClassNameService instance;

    private User currentUser;
    private SObject currentRecord;

    public static LC_ClassNameService getInstance() {
        return getInstance(null);
    }

    public static LC_ClassNameService getInstance(String recordId) {
        if (instance == null) {
            instance = new LC_ClassNameService(recordId);
        }
        return instance;
    }

    private LC_ClassNameService(String recordId) {
        this.currentRecord = LC_ClassNameUtil.obtainRecordDetails(recordId);
        this.currentUser = LC_ClassNameUtil.obtainUserDetails();

        // to do: initial logic
    }

    public void someMethod1() {

        // to do: action's main logic

    }

    public SomeWrapper getCurrentUser() {
        return new SomeWrapper(this.currentUser.Id,this.currentUser.Name);
    }

    public class SomeWrapper {
        @AuraEnabled
        public String id {get;set;}
        @AuraEnabled
        public String name {get;set;}

        public SomeWrapper(String id, String name) {
            this.id = id;
            this.name = name;
            // to do: wrapper's logic
        }
    }
}