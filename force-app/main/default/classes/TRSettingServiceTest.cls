/**
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * Trigger Setting Apex Test
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 * @created             14-12-2021             <evgeniy.kravchuk@synebo.io>
 * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
 */
@isTest
public with sharing class TRSettingServiceTest {

    @isTest 
    static void getSettingsTest() {
        TRSettingService.TRSetting trActive = TRSettingService.getInstance().getSettings('TestTRActive');
        TRSettingService.TRSetting trInactive = TRSettingService.getInstance().getSettings('TestTRInactive');
        TRSettingService.TRSetting noTR = TRSettingService.getInstance().getSettings('noTR');

        System.assert(trActive.isActive());
        System.assert(trActive.isMethodActive('methodActive'));
        System.assert(!trActive.isMethodActive('methodInactive'));
        System.assert(trActive.isMethodActive('noMethod'));

        System.assert(!trInactive.isActive());
        System.assert(!trInactive.isMethodActive('noMethod'));

        System.assert(noTR.isActive());
        System.assert(noTR.isMethodActive('noMethod'));
    }
}