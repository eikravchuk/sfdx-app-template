/**
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * Keep all static obtain methods, hardcoded values, constants etc. in the Util class. Please, notice that we're using the same
 * exception class through single logical chain Controller - Service - Util.
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
 */

// Test: LC_ClassNameTest
public without sharing class LC_ClassNameUtil {

    public class LC_ClassNameException extends Exception {}

    public static User obtainUserDetails() {
        List<User> currentUserList = [
            SELECT Id,
                   Name
              FROM User
             WHERE Id =: UserInfo.getUserId()
             LIMIT 1];

        if (currentUserList.isEmpty()) {
            throw new LC_ClassNameException('Error message');
        }

        return currentUserList.get(0);
    }

    public static User obtainRecordDetails(String recordId) {
        User record;

        List<User> recordList = [
            SELECT Id
                 , Name
              FROM User
             WHERE Id =: recordId
             LIMIT 1];

        if (!recordList.isEmpty()) {
            record = recordList.get(0);
        }

        return record;
    }
}