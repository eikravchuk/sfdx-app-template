/**
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * Trigger Setting Apex Service class to determine if a trigger or its method is active or not
 * 
 * Test                 TRSettingServiceTest
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 * @created             14-12-2021             <evgeniy.kravchuk@synebo.io>
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
 */
public with sharing class TRSettingService {

    private static TRSettingService instance;

    private Map<String, TRSetting> settingMap;
    private Map<String, Map<String, TRMethodSetting>> methodsMap;

    /** INSTANCE */
    public static TRSettingService getInstance() {
        if (instance == null) {
            instance = new TRSettingService();
        }
        return instance;
    }

    /** CONSTRUCTOR */
    private TRSettingService() {
        this.obtainMethodSettings();
        this.obtainSettings();
    }

    /** METHODS */
    public TRSetting getSettings(String sobjectName) {
        if (this.settingMap.containsKey(sobjectName)) {
            return this.settingMap.get(sobjectName);
        }
        return new TRSetting(true);
    }

    private void obtainMethodSettings() {
        this.methodsMap = new Map<String, Map<String, TRMethodSetting>>();

        for (TR_Method_Setting__mdt mdt_i : TR_Method_Setting__mdt.getAll().values()) {
            if (!this.methodsMap.containsKey(mdt_i.TR_Setting__c)) {
                this.methodsMap.put(mdt_i.TR_Setting__c, new Map<String, TRMethodSetting>());
            }
            this.methodsMap.get(mdt_i.TR_Setting__c).put(mdt_i.MethodName__c, new TRMethodSetting(mdt_i));
        }
    }

    private void obtainSettings() {
        this.settingMap = new Map<String, TRSetting>();

        for (TR_Setting__mdt mdt_i : TR_Setting__mdt.getAll().values()) {
            this.settingMap.put(mdt_i.SObjectName__c, new TRSetting(mdt_i, this.methodsMap.get(mdt_i.Id)));
        }
    }

    /** WRAPPERS */
    public class TRSetting {
        public Map<String, TRMethodSetting> methods;
        public String sobjectName;
        public Boolean isActive;

        public TRSetting(TR_Setting__mdt mdt, Map<String, TRMethodSetting> methods) {
            this.sobjectName = mdt.SObjectName__c;
            this.isActive = mdt.IsActive__c;
            this.methods = methods == null
                ? new Map<String, TRMethodSetting>()
                : methods;
        }

        public TRSetting(Boolean isActive) {
            this.isActive = isActive;
            this.methods = new Map<String, TRMethodSetting>();
        }

        public Boolean isActive() {
            return this.isActive;
        }

        public Boolean isMethodActive(String methodName) {
            if (!this.isActive) {
                return false;
            }
            if (!methods.containsKey(methodName)) {
                return true;
            }
            return methods.get(methodName).isActive;
        }
    }

    public class TRMethodSetting {
        public String methodName;
        public Boolean isActive;

        public TRMethodSetting (TR_Method_Setting__mdt mdt) {
            this.methodName = mdt.MethodName__c;
            this.isActive = mdt.IsActive__c;
        }
    }
}