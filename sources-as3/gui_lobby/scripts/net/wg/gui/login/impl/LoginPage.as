package net.wg.gui.login.impl
{
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.ui.Keyboard;
   import net.wg.data.Aliases;
   import net.wg.data.ListDAAPIDataProvider;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.common.serverStats.ServerVO;
   import net.wg.gui.gameloading.LoadingLogo;
   import net.wg.gui.login.IFormBaseVo;
   import net.wg.gui.login.ILoginFormView;
   import net.wg.gui.login.impl.components.Copyright;
   import net.wg.gui.login.impl.components.CopyrightEvent;
   import net.wg.gui.login.impl.components.RssItemEvent;
   import net.wg.gui.login.impl.components.RssNewsFeed;
   import net.wg.gui.login.impl.ev.LoginEvent;
   import net.wg.gui.login.impl.ev.LoginEventTextLink;
   import net.wg.gui.login.impl.ev.LoginServerDDEvent;
   import net.wg.gui.login.impl.views.LoginFormView;
   import net.wg.gui.login.impl.views.SimpleForm;
   import net.wg.gui.login.impl.vo.FilledLoginFormVo;
   import net.wg.gui.login.impl.vo.SimpleFormVo;
   import net.wg.gui.login.impl.vo.SteamLoginFormVo;
   import net.wg.gui.login.impl.vo.SubmitDataVo;
   import net.wg.infrastructure.base.meta.ILoginPageMeta;
   import net.wg.infrastructure.base.meta.impl.LoginPageMeta;
   import net.wg.utils.IScheduler;
   import org.idmedia.as3commons.util.Map;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class LoginPage extends LoginPageMeta implements ILoginPageMeta
   {
      
      private static const VIEW_SIMPLE_FORM:String = "LoginFormUI";
      
      private static const VIEW_FILLED_LOGIN_FORM:String = "FilledLoginFormUI";
      
      private static const VIEW_CHINA_LOGIN_FORM:String = "ChinaLoginFormUI";
      
      private static const VIEW_STEAM_LOGIN_FORM:String = "SteamLoginFormUI";
      
      private static const INV_CSIS_LISTENING:String = "invCsisListening";
      
      private static const DELAY_ON_ESCAPE:int = 50;
      
      private static const DELAY_ENABLE_INPUTS:int = 200;
      
      private static const WOT_LOGO_OFFSET_Y:int = 190;
      
      private static const COPYRIGHT_MIN_BOTTOM_MARGIN:int = 3;
      
      private static const WARNING_OFFSET_Y:int = 68;
      
      private static const STAGE_RESIZED:String = "stageResized";
      
      private static const LAYOUT:String = "layout";
      
      private static const SHADOW_OFFSET_X:int = 285;
      
      private static const SHADOW_OFFSET_Y:int = 331;
      
      private static const HEALTH_NOTICE_TEXT_ALPHA:Number = 0.6;
      
      private static const HEALTH_NOTICE_OFFSET:int = 25;
      
      private static const VERSION_BOTTOM:int = 10;
       
      
      public var loginViewStack:LoginViewStack = null;
      
      public var version:TextField = null;
      
      public var wotLogo:LoadingLogo = null;
      
      public var shadowImage:Sprite = null;
      
      public var copyright:Copyright = null;
      
      public var loginWarning:TextField = null;
      
      public var rssNewsFeed:RssNewsFeed = null;
      
      public var healthNotice:TextField = null;
      
      private var _currentView:ILoginFormView = null;
      
      private var _simpleFormDataVo:SimpleFormVo = null;
      
      private var _filledLoginFormDataVo:IFormBaseVo = null;
      
      private var _keyMappings:Map = null;
      
      private var _focusInited:Boolean = false;
      
      private var _startListenCSIS:Boolean = false;
      
      private var _isInputEnabled:Boolean = true;
      
      private var _selectedServerIndex:int = 0;
      
      private var _stageDimensions:Point;
      
      private var _isChinaForm:Boolean;
      
      private var _scheduler:IScheduler = null;
      
      private var _serversDataProvider:IDataProvider;
      
      public function LoginPage()
      {
         super();
         this._serversDataProvider = new ListDAAPIDataProvider(ServerVO);
         this._scheduler = App.utils.scheduler;
         this._isChinaForm = App.globalVarsMgr.isChinaS();
         this.version.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         this.updateContentPosition();
         if(!this._stageDimensions)
         {
            this._stageDimensions = new Point();
         }
         this._stageDimensions.x = param1;
         this._stageDimensions.y = param2;
         invalidate(STAGE_RESIZED);
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         this.initFocus();
      }
      
      override protected function allowHandleInput() : Boolean
      {
         return false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         this.rssNewsFeed.addEventListener(RssItemEvent.ITEM_SIZE_INVALID,this.onRssNewsFeedItemSizeInvalidHandler);
         this.copyright.addEventListener(CopyrightEvent.TO_LEGAL,this.onCopyrightToLegalHandler);
         this.copyright.addEventListener(Event.CHANGE,this.onCopyrightChangeHandler);
         this.healthNotice.alpha = HEALTH_NOTICE_TEXT_ALPHA;
         invalidate(LAYOUT);
         this.loginViewStack.addEventListener(LoginEvent.TOKEN_RESET,this.onLoginViewStackTokenResetHandler);
         this.loginViewStack.addEventListener(LoginEvent.FOCUS_INIT,this.onLoginViewStackFocusInitHandler);
         this.loginViewStack.addEventListener(LoginEvent.ON_INPUT_CHANGE,this.onLoginViewStackOnInputChangeHandler);
         this.loginViewStack.addEventListener(LoginEvent.ON_REMEMBER_CHANGE,this.onLoginViewStackOnRememberChangeHandler);
         this.loginViewStack.addEventListener(LoginEvent.SUBMIT,this.onLoginViewStackSubmitHandler);
         this.loginViewStack.addEventListener(LoginEvent.ON_RECOVERY_LINK_CLICK,this.onLoginViewStackOnRecoveryLinkClickHandler);
         this.loginViewStack.addEventListener(LoginEvent.ON_REGISTER_LINK_CLICK,this.onLoginViewStackOnRegisterLinkClickHandler);
         this.loginViewStack.addEventListener(LoginEventTextLink.ON_TEXT_LINK_CLICK,this.onLoginViewStackOnTextLinkClickHandler);
         this.loginViewStack.addEventListener(LoginEvent.LOGIN_BY_SOCIAL,this.onLoginViewStackLoginBySocialHandler);
         this.loginViewStack.addEventListener(LoginServerDDEvent.ON_CHANGE_LISTEN_CSIS,this.onLoginViewStackOnChangeListenCsisHandler);
         this.loginViewStack.addEventListener(LoginServerDDEvent.ON_SERVER_CHANGE,this.onLoginViewStackOnServerChangeHandler);
         this.loginViewStack.addEventListener(LoginEvent.ON_CHANGE_ACCOUNT_CLICK,this.onLoginViewStackOnChangeAccountClickHandler);
         this.loginViewStack.addEventListener(LoginEvent.ON_SUBMIT_WITHOUT_TOKEN,this.onLoginViewStackOnSubmitWithoutTokenHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INV_CSIS_LISTENING))
         {
            startListenCsisUpdateS(this._startListenCSIS);
         }
         if(isInvalid(LAYOUT))
         {
            this.updateContentPosition();
         }
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         if(App.globalVarsMgr.isLoginLoadedAtFirstTimeS())
         {
            RudimentarySwfOnLoginCheckingHelper.instance.checkRudimentarySwf();
         }
         registerFlashComponentS(this.rssNewsFeed,Aliases.RSS_NEWS_FEED);
         this._keyMappings = App.utils.data.createMap([Keyboard.ESCAPE,this.onEscapeKeyPress,Keyboard.ENTER,this.onEnterKeyPress]);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         this._stageDimensions = null;
         this.wotLogo.dispose();
         this.wotLogo = null;
         this.version = null;
         this.shadowImage = null;
         this.copyright.removeEventListener(CopyrightEvent.TO_LEGAL,this.onCopyrightToLegalHandler);
         this.copyright.removeEventListener(Event.CHANGE,this.onCopyrightChangeHandler);
         this.copyright.dispose();
         this.copyright = null;
         this.loginWarning = null;
         this.healthNotice = null;
         this.rssNewsFeed.removeEventListener(RssItemEvent.ITEM_SIZE_INVALID,this.onRssNewsFeedItemSizeInvalidHandler);
         this.rssNewsFeed = null;
         this.enableInputs(false);
         if(this._keyMappings != null)
         {
            this._keyMappings.clear();
            this._keyMappings = null;
         }
         this._currentView = null;
         this._serversDataProvider.cleanUp();
         this._serversDataProvider = null;
         this._scheduler.cancelTask(onEscapeS);
         this._scheduler.cancelTask(this.enableInputs);
         this._scheduler = null;
         this._simpleFormDataVo = null;
         this._filledLoginFormDataVo = null;
         this.loginViewStack.removeEventListener(LoginEvent.TOKEN_RESET,this.onLoginViewStackTokenResetHandler);
         this.loginViewStack.removeEventListener(LoginEvent.FOCUS_INIT,this.onLoginViewStackFocusInitHandler);
         this.loginViewStack.removeEventListener(LoginEvent.ON_INPUT_CHANGE,this.onLoginViewStackOnInputChangeHandler);
         this.loginViewStack.removeEventListener(LoginEvent.ON_REMEMBER_CHANGE,this.onLoginViewStackOnRememberChangeHandler);
         this.loginViewStack.removeEventListener(LoginEvent.SUBMIT,this.onLoginViewStackSubmitHandler);
         this.loginViewStack.removeEventListener(LoginEvent.ON_RECOVERY_LINK_CLICK,this.onLoginViewStackOnRecoveryLinkClickHandler);
         this.loginViewStack.removeEventListener(LoginEvent.ON_REGISTER_LINK_CLICK,this.onLoginViewStackOnRegisterLinkClickHandler);
         this.loginViewStack.removeEventListener(LoginEventTextLink.ON_TEXT_LINK_CLICK,this.onLoginViewStackOnTextLinkClickHandler);
         this.loginViewStack.removeEventListener(LoginEvent.LOGIN_BY_SOCIAL,this.onLoginViewStackLoginBySocialHandler);
         this.loginViewStack.removeEventListener(LoginServerDDEvent.ON_CHANGE_LISTEN_CSIS,this.onLoginViewStackOnChangeListenCsisHandler);
         this.loginViewStack.removeEventListener(LoginServerDDEvent.ON_SERVER_CHANGE,this.onLoginViewStackOnServerChangeHandler);
         this.loginViewStack.removeEventListener(LoginEvent.ON_CHANGE_ACCOUNT_CLICK,this.onLoginViewStackOnChangeAccountClickHandler);
         this.loginViewStack.removeEventListener(LoginEvent.ON_SUBMIT_WITHOUT_TOKEN,this.onLoginViewStackOnSubmitWithoutTokenHandler);
         this.loginViewStack.dispose();
         this.loginViewStack = null;
         super.onDispose();
      }
      
      override protected function showSimpleForm(param1:Boolean, param2:DataProvider, param3:Boolean) : void
      {
         this._simpleFormDataVo.invalidType = LoginFormView.INV_ALL_DATA;
         this._simpleFormDataVo.isShowSocial = param1 && param2;
         this._simpleFormDataVo.showRegisterLink = param3;
         if(this._simpleFormDataVo.isShowSocial)
         {
            this._simpleFormDataVo.socialList = param2;
         }
         this.changeView(VIEW_SIMPLE_FORM);
      }
      
      override protected function setDefaultValues(param1:SimpleFormVo) : void
      {
         this._simpleFormDataVo = param1;
         this._simpleFormDataVo.invalidType = SimpleForm.INV_DEFAULT_DATA;
         this.invalidateForm();
      }
      
      override protected function showFilledLoginForm(param1:FilledLoginFormVo) : void
      {
         this._filledLoginFormDataVo = param1;
         this._filledLoginFormDataVo.invalidType = LoginFormView.INV_ALL_DATA;
         this.changeView(!!this._isChinaForm ? VIEW_CHINA_LOGIN_FORM : VIEW_FILLED_LOGIN_FORM);
      }
      
      override protected function showSteamLoginForm(param1:SteamLoginFormVo) : void
      {
         this._filledLoginFormDataVo = param1;
         this._filledLoginFormDataVo.invalidType = LoginFormView.INV_ALL_DATA;
         this.changeView(VIEW_STEAM_LOGIN_FORM);
      }
      
      public function as_doAutoLogin() : void
      {
         this.submit();
      }
      
      public function as_enable(param1:Boolean) : void
      {
         this.enableInputs(param1);
      }
      
      public function as_getServersDP() : Object
      {
         return this._serversDataProvider;
      }
      
      public function as_resetPassword() : void
      {
         this._simpleFormDataVo.pwd = Values.EMPTY_STR;
         this._simpleFormDataVo.invalidType = SimpleForm.INV_PASSWORD;
         this.invalidateForm();
      }
      
      public function as_setCapsLockState(param1:Boolean) : void
      {
         this._simpleFormDataVo.capsLockState = param1;
         this._simpleFormDataVo.invalidType = SimpleForm.INV_CAPS_LOCK;
         this.invalidateForm();
      }
      
      public function as_setCopyright(param1:String, param2:String) : void
      {
         this.copyright.updateLabel(param1,param2);
         this.updateCopyrightPos();
      }
      
      public function as_setErrorMessage(param1:String, param2:int) : void
      {
         this.setErrorMessage(param1,param2);
      }
      
      public function as_setKeyboardLang(param1:String) : void
      {
         this._simpleFormDataVo.keyboardLang = param1;
         this._simpleFormDataVo.invalidType = SimpleForm.INV_KEYBOARD_LANG;
         this.invalidateForm();
      }
      
      public function as_setLoginWarning(param1:String) : void
      {
         this.loginWarning.htmlText = param1;
         this.loginWarning.visible = true;
         this.updateLoginWarningPos();
      }
      
      public function as_setLoginWarningHide() : void
      {
         this.loginWarning.visible = false;
      }
      
      public function as_setSelectedServerIndex(param1:int) : void
      {
         this._selectedServerIndex = param1;
         if(this._currentView)
         {
            this._currentView.setSelectedServerIndex(this._selectedServerIndex);
         }
      }
      
      public function as_setVersion(param1:String) : void
      {
         assertNotNull(param1);
         this.version.text = param1;
      }
      
      public function as_showHealthNotice(param1:String) : void
      {
         this.healthNotice.text = param1;
         App.utils.commons.updateTextFieldSize(this.healthNotice);
         this.updateHealthNotice();
      }
      
      public function as_switchToAutoAndSubmit(param1:String) : void
      {
         this._simpleFormDataVo.autoLoginKey = param1;
         this._simpleFormDataVo.invalidType = SimpleForm.INV_AUTO_LOGIN_KEY;
         this.invalidateForm();
      }
      
      private function setErrorMessage(param1:String, param2:int) : void
      {
         if(this._currentView != null)
         {
            this._currentView.setErrorMessage(param1,param2);
         }
         this.initFocus();
      }
      
      private function onEscapeKeyPress() : void
      {
         this.enableInputs(false);
         this._scheduler.scheduleTask(onEscapeS,DELAY_ON_ESCAPE);
         this._scheduler.scheduleTask(this.enableInputs,DELAY_ENABLE_INPUTS,true);
      }
      
      private function onEnterKeyPress() : void
      {
         this.submit();
      }
      
      private function updateContentPosition() : void
      {
         this.loginViewStack.x = App.appWidth >> 1;
         this.loginViewStack.y = LoginFormPositionHelper.getLoginFormPosition(App.appHeight);
         this.wotLogo.x = this.loginViewStack.x;
         this.wotLogo.y = this.loginViewStack.y - WOT_LOGO_OFFSET_Y;
         this.shadowImage.x = this.loginViewStack.x - SHADOW_OFFSET_X;
         this.shadowImage.y = this.loginViewStack.y - SHADOW_OFFSET_Y;
         this.version.y = App.appHeight - VERSION_BOTTOM - this.version.height | 0;
         this.updateCopyrightPos();
         this.updateLoginWarningPos();
         this.updateRssPositions();
         invalidateSize();
      }
      
      private function updateHealthNotice() : void
      {
         this.healthNotice.x = App.appWidth - this.healthNotice.width >> 1;
         this.healthNotice.y = this.copyright.y - this.healthNotice.height - HEALTH_NOTICE_OFFSET;
      }
      
      private function updateCopyrightPos() : void
      {
         this.copyright.y = App.appHeight - COPYRIGHT_MIN_BOTTOM_MARGIN - this.copyright.getHeight();
         this.copyright.x = this.loginViewStack.x - (this.copyright.getWidth() >> 1);
         if(this._isChinaForm)
         {
            this.updateHealthNotice();
         }
      }
      
      private function updateLoginWarningPos() : void
      {
         App.utils.commons.updateTextFieldSize(this.loginWarning,true,false);
         this.loginWarning.y = this.loginViewStack.y - WARNING_OFFSET_Y;
         this.loginWarning.x = App.appWidth - this.loginWarning.width >> 1;
      }
      
      private function updateRssPositions() : void
      {
         this.rssNewsFeed.x = App.appWidth - this.rssNewsFeed.actualWidth;
         this.rssNewsFeed.y = App.appHeight;
      }
      
      private function submit() : void
      {
         var _loc1_:SubmitDataVo = null;
         if(this._currentView != null)
         {
            _loc1_ = this.getSubmitData();
            this.setErrorMessage(MENU.LOGIN_STATUS_CONNECTING,ErrorStates.NONE);
            onLoginS(_loc1_.login,_loc1_.pwd,_loc1_.host,_loc1_.isSocial);
         }
      }
      
      private function enableInputs(param1:Boolean) : void
      {
         this._isInputEnabled = param1;
         if(this._isInputEnabled)
         {
            addEventListener(InputEvent.INPUT,this.onInputHandler);
            this.initFocus();
         }
         else
         {
            removeEventListener(InputEvent.INPUT,this.onInputHandler);
         }
      }
      
      private function initFocus() : void
      {
         assertLifeCycle();
         if(!this._focusInited && this._currentView != null)
         {
            this._currentView.initFocus();
            this._focusInited = true;
         }
      }
      
      private function invalidateForm() : void
      {
         if(this._currentView != null)
         {
            if(this._currentView is SimpleForm)
            {
               this._currentView.updateVo(this._simpleFormDataVo);
            }
            else
            {
               this._currentView.updateVo(this._filledLoginFormDataVo);
            }
            this._currentView.setServersDP(this._serversDataProvider);
            this._currentView.setSelectedServerIndex(this._selectedServerIndex);
         }
      }
      
      private function changeView(param1:String) : void
      {
         this.loginViewStack.show(param1);
         this._currentView = ILoginFormView(this.loginViewStack.currentView);
         this.invalidateForm();
         this._focusInited = false;
      }
      
      private function getSubmitData() : SubmitDataVo
      {
         if(this._currentView != null)
         {
            return this._currentView.getSubmitData();
         }
         return null;
      }
      
      private function onMouseClickHandler(param1:MouseEvent) : void
      {
         if(!stage.focus)
         {
            App.utils.focusHandler.setFocus(this);
         }
      }
      
      private function onInputHandler(param1:InputEvent) : void
      {
         var _loc2_:Function = null;
         if(param1.handled || App.waiting && App.waiting.isOnStage)
         {
            return;
         }
         if(param1.details.value == InputValue.KEY_DOWN)
         {
            _loc2_ = this._keyMappings.get(param1.details.code);
            if(_loc2_ != null)
            {
               _loc2_();
               param1.handled = true;
            }
         }
      }
      
      private function onRssNewsFeedItemSizeInvalidHandler(param1:RssItemEvent) : void
      {
         this.updateRssPositions();
      }
      
      private function onLoginViewStackFocusInitHandler(param1:LoginEvent) : void
      {
         if(param1.focusTarget != null)
         {
            setFocus(param1.focusTarget);
         }
      }
      
      private function onLoginViewStackOnInputChangeHandler(param1:LoginEvent) : void
      {
         var isToken:Boolean = false;
         var simpleForm:SimpleForm = null;
         var event:LoginEvent = param1;
         if(this._isInputEnabled)
         {
            isToken = isTokenS();
            try
            {
               simpleForm = event.target as SimpleForm;
               if(simpleForm)
               {
                  simpleForm.updateInputForm(event.focusTarget,isToken);
                  if(event.focusTarget == simpleForm.login)
                  {
                     onLoginNameUpdatedS();
                  }
               }
            }
            catch(e:Error)
            {
               DebugUtils.LOG_ERROR(e.message);
            }
         }
      }
      
      private function onLoginViewStackLoginBySocialHandler(param1:LoginEvent) : void
      {
         var _loc2_:SubmitDataVo = this.getSubmitData();
         onLoginBySocialS(param1.socialId,_loc2_.host);
      }
      
      private function onLoginViewStackOnRememberChangeHandler(param1:LoginEvent) : void
      {
         onSetRememberPasswordS(param1.isRemember);
      }
      
      private function onLoginViewStackOnRegisterLinkClickHandler(param1:LoginEvent) : void
      {
         var _loc2_:SubmitDataVo = this.getSubmitData();
         onRegisterS(_loc2_.host);
      }
      
      private function onLoginViewStackOnTextLinkClickHandler(param1:LoginEventTextLink) : void
      {
         onTextLinkClickS(param1.linkId);
      }
      
      private function onLoginViewStackOnRecoveryLinkClickHandler(param1:LoginEvent) : void
      {
         onRecoveryS();
      }
      
      private function onLoginViewStackSubmitHandler(param1:LoginEvent) : void
      {
         this.submit();
      }
      
      private function onLoginViewStackTokenResetHandler(param1:LoginEvent) : void
      {
         resetTokenS();
      }
      
      private function onLoginViewStackOnChangeListenCsisHandler(param1:LoginServerDDEvent) : void
      {
         this._startListenCSIS = param1.isListenCSIS;
         invalidate(INV_CSIS_LISTENING);
      }
      
      private function onLoginViewStackOnServerChangeHandler(param1:LoginServerDDEvent) : void
      {
         this._selectedServerIndex = param1.selectedIndex;
      }
      
      private function onLoginViewStackOnChangeAccountClickHandler(param1:LoginEvent) : void
      {
         changeAccountS();
      }
      
      private function onLoginViewStackOnSubmitWithoutTokenHandler(param1:LoginEvent) : void
      {
         var _loc2_:SubmitDataVo = this.getSubmitData();
         onLoginBySocialS(param1.socialId,_loc2_.host);
      }
      
      private function onCopyrightToLegalHandler(param1:CopyrightEvent) : void
      {
         showLegalS();
      }
      
      private function onCopyrightChangeHandler(param1:Event) : void
      {
         this.updateCopyrightPos();
      }
   }
}

import net.wg.data.constants.LobbyMetrics;

class LoginFormPositionHelper
{
   
   private static const POS_Y_SCREEN_HEIGHT_768:int = 461;
   
   private static const POS_Y_SCREEN_HEIGHT_1080:int = 700;
   
   private static const POS_Y_SCREEN_HEIGHT_1440:int = 848;
   
   private static const POS_Y_SCREEN_HEIGHT_2160:int = 1240;
   
   private static const POSITION_BY_RESOLUTION:Object = {};
   
   private static const SCREEN_HEIGHT:Vector.<int> = new <int>[LobbyMetrics.MIN_STAGE_HEIGHT,LobbyMetrics.STAGE_HEIGHT_1080,LobbyMetrics.STAGE_HEIGHT_1440,LobbyMetrics.STAGE_HEIGHT_2160];
   
   private static const ERROR_INVALID_LOGINFORM_SETTINGS:String = "Invalid settings for loginForm! See LoginFormPositionHelper!";
   
   {
      POSITION_BY_RESOLUTION[LobbyMetrics.MIN_STAGE_HEIGHT] = POS_Y_SCREEN_HEIGHT_768;
      POSITION_BY_RESOLUTION[LobbyMetrics.STAGE_HEIGHT_1080] = POS_Y_SCREEN_HEIGHT_1080;
      POSITION_BY_RESOLUTION[LobbyMetrics.STAGE_HEIGHT_1440] = POS_Y_SCREEN_HEIGHT_1440;
      POSITION_BY_RESOLUTION[LobbyMetrics.STAGE_HEIGHT_2160] = POS_Y_SCREEN_HEIGHT_2160;
   }
   
   function LoginFormPositionHelper()
   {
      super();
   }
   
   public static function getLoginFormPosition(param1:int) : int
   {
      var _loc3_:int = 0;
      var _loc4_:int = 0;
      var _loc6_:int = 0;
      var _loc7_:Number = NaN;
      var _loc8_:int = 0;
      var _loc2_:int = 0;
      var _loc5_:uint = SCREEN_HEIGHT.length;
      while(_loc2_ < _loc5_ - 1)
      {
         _loc3_ = SCREEN_HEIGHT[_loc2_];
         _loc4_ = SCREEN_HEIGHT[_loc2_ + 1];
         if(_loc3_ <= param1 && param1 <= _loc4_)
         {
            break;
         }
         _loc2_++;
      }
      if(!POSITION_BY_RESOLUTION[SCREEN_HEIGHT[_loc2_]])
      {
         DebugUtils.LOG_ERROR(ERROR_INVALID_LOGINFORM_SETTINGS);
         return 0;
      }
      if(_loc2_ < SCREEN_HEIGHT.length - 1)
      {
         _loc7_ = 1 - (_loc4_ - param1) / (_loc4_ - SCREEN_HEIGHT[_loc2_]);
         _loc6_ = POSITION_BY_RESOLUTION[_loc3_] + (POSITION_BY_RESOLUTION[_loc4_] - POSITION_BY_RESOLUTION[_loc3_]) * _loc7_;
      }
      else
      {
         _loc8_ = SCREEN_HEIGHT[SCREEN_HEIGHT.length - 1];
         _loc7_ = POSITION_BY_RESOLUTION[_loc8_] / _loc8_;
         _loc6_ = _loc7_ * param1;
      }
      return _loc6_;
   }
}
