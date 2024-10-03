package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ISettingsWindowMeta extends IEventDispatcher
   {
       
      
      function applySettingsS(param1:Object, param2:Boolean) : void;
      
      function autodetectQualityS() : Number;
      
      function startVOIPTestS(param1:Boolean) : Boolean;
      
      function updateCaptureDevicesS() : void;
      
      function onSettingsChangeS(param1:String, param2:Object) : void;
      
      function altVoicesPreviewS() : void;
      
      function altBulbPreviewS(param1:int) : void;
      
      function artyBulbPreviewS(param1:int) : void;
      
      function isSoundModeValidS() : Boolean;
      
      function showWarningDialogS(param1:String, param2:Object, param3:Boolean) : void;
      
      function onTabSelectedS(param1:String) : void;
      
      function onCounterTargetVisitedS(param1:String, param2:String, param3:Array) : void;
      
      function autodetectAcousticTypeS() : String;
      
      function canSelectAcousticTypeS(param1:Number) : Boolean;
      
      function openGammaWizardS(param1:int, param2:int, param3:int) : void;
      
      function openColorSettingsS() : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setCaptureDevices(param1:Number, param2:Array) : void;
      
      function as_updateVideoSettings(param1:Object) : void;
      
      function as_confirmWarningDialog(param1:Boolean, param2:String) : void;
      
      function as_showLimitedUISetting(param1:Boolean) : void;
      
      function as_ConfirmationOfApplication(param1:Boolean) : void;
      
      function as_openTab(param1:Number) : void;
      
      function as_setGraphicsPreset(param1:Number) : void;
      
      function as_isPresetApplied() : Boolean;
      
      function as_setCountersData(param1:Array) : void;
      
      function as_onSoundSpeakersPresetApply(param1:Boolean) : void;
      
      function as_disableControl(param1:String, param2:String, param3:String) : void;
      
      function as_setColorGradingTechnique(param1:String, param2:String) : void;
      
      function as_setFeedbackDataProvider(param1:Array) : void;
      
      function as_setTigerEvent(param1:Boolean) : void;
      
      function as_setDisabledTabsOverlay(param1:Array, param2:String) : void;
   }
}
