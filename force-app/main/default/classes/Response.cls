/**
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * Use this class everywhere to pass response from backend to frontend.
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
 */

// Test: ResponseTest
global class Response {

    @AuraEnabled
    public Object responseObj {get;set;}
    @AuraEnabled
    public Boolean isSuccess {get;set;}

    public Response() {}

    public Response(Boolean isSuccess, Object responseObj) {
        this.isSuccess = isSuccess;
        this.responseObj = responseObj;
    }

    public Response(Boolean isSuccess, String message) {
        this.isSuccess = isSuccess;
        this.responseObj = message;
    }

    public Response(Object responseObj) {
        this(true, responseObj);
    }

    public Response(Exception e) {
        this(false, e instanceof System.DmlException ? e.getDmlMessage(0) : e.getMessage());
    }
}