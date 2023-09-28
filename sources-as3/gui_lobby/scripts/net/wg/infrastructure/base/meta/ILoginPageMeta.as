package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ILoginPageMeta extends IEventDispatcher
   {
       
      
      function onLoginS(param1:String, param2:String, param3:String, param4:Boolean) : void;
      
      function onRegisterS(param1:String) : void;
      
      function onRecoveryS() : void;
      
      function onTextLinkClickS(param1:String) : void;
      
      function onLoginBySocialS(param1:String, param2:String) : void;
      
      function onSetRememberPasswordS(param1:Boolean) : void;
      
      function onLoginNameUpdatedS() : void;
      
      function isTokenS() : Boolean;
      
      function resetTokenS() : void;
      
      function onEscapeS() : void;
      
      function isCSISUpdateOnRequestS() : Boolean;
      
      function startListenCsisUpdateS(param1:Boolean) : void;
      
      function showLegalS() : void;
      
      function changeAccountS() : void;
      
      function onVideoLoadedS() : void;
      
      function musicFadeOutS() : void;
      
      function videoLoadingFailedS() : void;
      
      function switchBgModeS() : void;
      
      function setMuteS(param1:Boolean) : void;
      
      function as_setDefaultValues(param1:Object) : void;
      
      function as_setErrorMessage(param1:String, param2:int) : void;
      
      function as_setVersion(param1:String) : void;
      
      function as_setCopyright(param1:String, param2:String) : void;
      
      function as_setLoginWarning(param1:String) : void;
      
      function as_showWallpaper(param1:Boolean, param2:String, param3:Boolean, param4:Boolean) : void;
      
      function as_showLoginVideo(param1:String, param2:Number, param3:Boolean) : void;
      
      function as_setLoginWarningHide() : void;
      
      function as_setCapsLockState(param1:Boolean) : void;
      
      function as_setKeyboardLang(param1:String) : void;
      
      function as_pausePlayback() : void;
      
      function as_resumePlayback() : void;
      
      function as_doAutoLogin() : void;
      
      function as_enable(param1:Boolean) : void;
      
      function as_switchToAutoAndSubmit(param1:String) : void;
      
      function as_showSimpleForm(param1:Boolean, param2:Array, param3:Boolean) : void;
      
      function as_showFilledLoginForm(param1:Object) : void;
      
      function as_showSteamLoginForm(param1:Object) : void;
      
      function as_resetPassword() : void;
      
      function as_getServersDP() : Object;
      
      function as_setSelectedServerIndex(param1:int) : void;
      
      function as_showHealthNotice(param1:String) : void;
   }
}
