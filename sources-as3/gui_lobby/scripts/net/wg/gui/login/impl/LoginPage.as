package net.wg.gui.login.impl
{
   import fl.motion.easing.Cubic;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.wg.data.Aliases;
   import net.wg.data.ListDAAPIDataProvider;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Locales;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.common.BaseLogoView;
   import net.wg.gui.components.common.serverStats.ServerVO;
   import net.wg.gui.components.common.video.PlayerStatus;
   import net.wg.gui.components.common.video.SimpleVideoPlayer;
   import net.wg.gui.components.common.video.VideoPlayerStatusEvent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.interfaces.ISparksManager;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
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
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.motion.Tween;
   
   public class LoginPage extends LoginPageMeta implements ILoginPageMeta
   {
      
      private static const SPARK_ZONE:Rectangle = new Rectangle(100,0,-200,-100);
      
      private static const SPARK_QUANTITY:uint = 150;
      
      private static const VIEW_SIMPLE_FORM:String = "LoginFormUI";
      
      private static const VIEW_FILLED_LOGIN_FORM:String = "FilledLoginFormUI";
      
      private static const VIEW_CHINA_LOGIN_FORM:String = "ChinaLoginFormUI";
      
      private static const VIEW_STEAM_LOGIN_FORM:String = "SteamLoginFormUI";
      
      private static const INV_CSIS_LISTENING:String = "invCsisListening";
      
      private static const DELAY_ON_ESCAPE:Number = 50;
      
      private static const DELAY_ENABLE_INPUTS:Number = 200;
      
      private static const FREE_SPACE_FACTOR:Number = 0.6;
      
      private static const WOT_LOGO_OFFSET_Y:Number = 190;
      
      private static const AGE_RATING_OFFSET_X:Number = 30;
      
      private static const AGE_RATING_OFFSET_Y:Number = 80;
      
      private static const COPYRIGHT_OFFSET_Y:Number = 44;
      
      private static const WARNING_OFFSET_Y:Number = 68;
      
      private static const STAGE_RESIZED:String = "stageResized";
      
      private static const LAYOUT:String = "layout";
      
      private static const SOUND_BUTTON_OFFSET_X:int = 78;
      
      private static const MODE_BUTTON_OFFSET_X:int = 38;
      
      private static const MODE_BUTTON_OFFSET_Y:int = 20;
      
      private static const SHADOW_OFFSET_X:int = 285;
      
      private static const SHADOW_OFFSET_Y:int = 331;
      
      private static const VIDEO_ORIG_WIDTH:int = 1920;
      
      private static const VIDEO_ORIG_HEIGHT:int = 1080;
      
      private static const TWEEN_DURATION:int = 1500;
      
      private static const MAX_VIDEO_LOADING_ATTEMPTS:int = 3;
      
      private static const BG_IMAGE_WIDTH:int = 1920;
      
      private static const BG_IMAGE_HEIGHT:int = 1200;
      
      private static const HEALTH_NOTICE_TEXT_ALPHA:Number = 0.6;
      
      private static const HEALTH_NOTICE_OFFSET:int = 25;
      
      private static const LOGO_OFFSET_Y_2k:int = -78;
      
      private static const LOGO_OFFSET_Y_4k:int = -54;
      
      private static const FREE_SPACE_BORDER_FACTOR:Number = 0.17;
       
      
      public var bgImage:UILoaderAlt = null;
      
      public var videoPlayer:SimpleVideoPlayer;
      
      public var bgModeButton:ISoundButtonEx;
      
      public var soundButton:ISoundButtonEx;
      
      public var sparksMc:Sprite = null;
      
      public var loginViewStack:LoginViewStack = null;
      
      public var version:TextField = null;
      
      public var wotLogo:BaseLogoView = null;
      
      public var shadowVideo:Sprite = null;
      
      public var shadowImage:Sprite = null;
      
      public var vignette:Sprite = null;
      
      public var bottomShadow:Sprite = null;
      
      public var copyrightSmall:TextField = null;
      
      public var copyright:Copyright = null;
      
      public var loginWarning:TextField = null;
      
      public var rssNewsFeed:RssNewsFeed = null;
      
      public var blackScreen:Sprite = null;
      
      public var healthNotice:TextField = null;
      
      public var ageRating:BaseLogoView = null;
      
      private var _currentView:ILoginFormView = null;
      
      private var _simpleFormDataVo:SimpleFormVo = null;
      
      private var _filledLoginFormDataVo:IFormBaseVo = null;
      
      private var _sparksManager:ISparksManager = null;
      
      private var _useWallpaper:Boolean = false;
      
      private var _keyMappings:Map = null;
      
      private var _focusInited:Boolean = false;
      
      private var _startListenCSIS:Boolean = false;
      
      private var _isInputEnabled:Boolean = true;
      
      private var _isInFocus:Boolean = true;
      
      private var _selectedServerIndex:Number = 0;
      
      private var _stageDimensions:Point;
      
      private var _isVideoLoaded:Boolean = false;
      
      private var _showSwitcher:Boolean = true;
      
      private var _isWGC:Boolean = true;
      
      private var _isChinaForm:Boolean;
      
      private var _tween:Tween;
      
      private var _scheduler:IScheduler = null;
      
      private var _serversDataProvider:IDataProvider;
      
      public function LoginPage()
      {
         super();
         this._serversDataProvider = new ListDAAPIDataProvider(ServerVO);
         this._scheduler = App.utils.scheduler;
         this._isChinaForm = App.globalVarsMgr.isChinaS();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         this.updateContentPosition();
         if(this._sparksManager != null)
         {
            this._sparksManager.resetZone(this.getSparkZone());
         }
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
         this.videoPlayer.maxAttemptsCount = MAX_VIDEO_LOADING_ATTEMPTS;
         this.videoPlayer.isLoop = true;
         this.rssNewsFeed.addEventListener(RssItemEvent.ITEM_SIZE_INVALID,this.onRssNewsFeedItemSizeInvalidHandler);
         this.ageRating.visible = false;
         var _loc1_:String = App.globalVarsMgr.getLocaleOverrideS();
         if(_loc1_)
         {
            this.wotLogo.setLocale(_loc1_);
            if(_loc1_ == Locales.CHINA)
            {
               this.ageRating.visible = true;
               this.ageRating.setLocale(_loc1_);
            }
         }
         this.copyright.addEventListener(CopyrightEvent.TO_LEGAL,this.onCopyrightToLegalHandler);
         this.copyright.addEventListener(Event.CHANGE,this.onCopyrightChangeHandler);
         this.healthNotice.alpha = HEALTH_NOTICE_TEXT_ALPHA;
         invalidate(LAYOUT);
         this.soundButton.addEventListener(ButtonEvent.CLICK,this.onSoundButtonClickHandler);
         this.bgModeButton.addEventListener(ButtonEvent.CLICK,this.onSwitchModeButtonClickHandler);
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
         this.bgModeButton.focusable = false;
         this.soundButton.focusable = false;
      }
      
      private function onMouseClickHandler(param1:MouseEvent) : void
      {
         if(!stage.focus)
         {
            App.utils.focusHandler.setFocus(this);
         }
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
         if(this._stageDimensions && isInvalid(STAGE_RESIZED))
         {
            this.imitateNoBorderScaleMode(this._stageDimensions.x,this._stageDimensions.y);
         }
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.shadowVideo.visible = false;
         this.shadowImage.visible = false;
         this.soundButton.visible = false;
         this.bgModeButton.visible = false;
         this.copyrightSmall.visible = true;
         this.copyright.visible = false;
         this.blackScreen.alpha = 0;
         this.bgImage.addEventListener(UILoaderEvent.COMPLETE,this.onBgImageCompleteHandler,false,0,true);
         this.bgImage.source = RES_LOGIN.MAPS_LOGIN_LOGIN_BG;
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
         this.removeTween();
         this.bgImage.removeEventListener(UILoaderEvent.COMPLETE,this.onBgImageCompleteHandler);
         this.bgImage.dispose();
         this.bgImage = null;
         this.bgModeButton.removeEventListener(ButtonEvent.CLICK,this.onSwitchModeButtonClickHandler);
         this.bgModeButton.dispose();
         this.bgModeButton = null;
         this.soundButton.removeEventListener(ButtonEvent.CLICK,this.onSoundButtonClickHandler);
         this.soundButton.dispose();
         this.soundButton = null;
         this.removeVideoPlayerEvents();
         this.videoPlayer.dispose();
         this.videoPlayer = null;
         this._stageDimensions = null;
         this.wotLogo.dispose();
         this.wotLogo = null;
         this.ageRating.dispose();
         this.ageRating = null;
         this.version = null;
         this.sparksMc = null;
         this.shadowVideo = null;
         this.shadowImage = null;
         this.bottomShadow = null;
         this.blackScreen = null;
         this.vignette = null;
         this.copyright.removeEventListener(CopyrightEvent.TO_LEGAL,this.onCopyrightToLegalHandler);
         this.copyright.removeEventListener(Event.CHANGE,this.onCopyrightChangeHandler);
         this.copyright.dispose();
         this.copyright = null;
         this.copyrightSmall = null;
         this.loginWarning = null;
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
         this.destroySparks();
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
      
      override protected function onSetFocus(param1:InteractiveObject) : void
      {
         this._isInFocus = true;
         this.videoPlayer.resumePlayback();
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
      
      public function as_pausePlayback() : void
      {
         this.videoPlayer.pausePlayback();
      }
      
      public function as_resetPassword() : void
      {
         this._simpleFormDataVo.pwd = Values.EMPTY_STR;
         this._simpleFormDataVo.invalidType = SimpleForm.INV_PASSWORD;
         this.invalidateForm();
      }
      
      public function as_resumePlayback() : void
      {
         if(this._isInFocus)
         {
            this.videoPlayer.resumePlayback();
         }
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
         this.copyrightSmall.htmlText = param1;
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
      
      public function as_showLoginVideo(param1:String, param2:Number, param3:Boolean) : void
      {
         if(!this.videoPlayer.hasEventListener(VideoPlayerStatusEvent.ERROR))
         {
            this.videoPlayer.addEventListener(VideoPlayerStatusEvent.ERROR,this.onVideoPlayerErrorHandler);
            this.videoPlayer.addEventListener(VideoPlayerStatusEvent.STATUS_CHANGED,this.onVideoPlayerStatusChangedHandler);
         }
         this._isWGC = false;
         this.soundButton.visible = true;
         this.bgModeButton.visible = true;
         this.copyrightSmall.visible = false;
         this.copyright.visible = true;
         this.videoPlayer.bufferTime = param2;
         if(this.videoPlayer.source != param1)
         {
            this.videoPlayer.source = param1;
            this._isVideoLoaded = false;
         }
         else
         {
            this.fadeInBg();
            this.videoPlayer.resumePlayback();
         }
         this.shadowImage.visible = false;
         this.shadowVideo.visible = true;
         this.videoPlayer.visible = true;
         this.vignette.visible = true;
         this.bgModeButton.selected = false;
         this.soundButton.selected = param3;
         this.destroySparks();
         this.updateButtonsTooltips();
      }
      
      public function as_showWallpaper(param1:Boolean, param2:String, param3:Boolean, param4:Boolean) : void
      {
         this.removeVideoPlayerEvents();
         this.soundButton.visible = true;
         this.bgModeButton.visible = true;
         this._showSwitcher = param3;
         this._isWGC = false;
         this.shadowImage.visible = true;
         this.shadowVideo.visible = false;
         this.copyrightSmall.visible = false;
         this.copyright.visible = true;
         if(this.bgImage.source != param2)
         {
            this.bgImage.source = param2;
         }
         else
         {
            this.fadeInBg();
         }
         this._useWallpaper = param1;
         if(!this._useWallpaper)
         {
            this.bgImage.autoSize = true;
         }
         this.videoPlayer.visible = false;
         this.vignette.visible = false;
         this.soundButton.selected = param4;
         this.bgModeButton.selected = true;
         this.bgModeButton.visible = this._showSwitcher;
         this.createSparks();
         this.updateButtonsTooltips();
      }
      
      public function as_switchToAutoAndSubmit(param1:String) : void
      {
         this._simpleFormDataVo.autoLoginKey = param1;
         this._simpleFormDataVo.invalidType = SimpleForm.INV_AUTO_LOGIN_KEY;
         this.invalidateForm();
      }
      
      private function updateButtonsTooltips() : void
      {
         this.bgModeButton.tooltip = !!this.bgModeButton.selected ? TOOLTIPS.LOGIN_BGMODEBUTTON_ON : TOOLTIPS.LOGIN_BGMODEBUTTON_OFF;
         this.soundButton.tooltip = !!this.soundButton.selected ? TOOLTIPS.LOGIN_SOUNDBUTTON_ON : TOOLTIPS.LOGIN_SOUNDBUTTON_OFF;
      }
      
      private function removeVideoPlayerEvents() : void
      {
         this.videoPlayer.removeEventListener(VideoPlayerStatusEvent.ERROR,this.onVideoPlayerErrorHandler);
         this.videoPlayer.removeEventListener(VideoPlayerStatusEvent.STATUS_CHANGED,this.onVideoPlayerStatusChangedHandler);
      }
      
      private function imitateNoBorderScaleMode(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = Math.max(param1 / VIDEO_ORIG_WIDTH,param2 / VIDEO_ORIG_HEIGHT);
         this.videoPlayer.video.width = VIDEO_ORIG_WIDTH * _loc3_ >> 0;
         this.videoPlayer.video.height = VIDEO_ORIG_HEIGHT * _loc3_ >> 0;
         this.videoPlayer.x = param1 - this.videoPlayer.video.width >> 1;
         this.videoPlayer.y = param2 - this.videoPlayer.video.height >> 1;
      }
      
      private function onFadeOutTweenFinished() : void
      {
         if(this.videoPlayer.status == PlayerStatus.PLAYING)
         {
            this.videoPlayer.pausePlayback();
         }
         switchBgModeS();
         this.updateContentPosition();
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
         this._isInFocus = false;
         if(this.videoPlayer.status == PlayerStatus.PLAYING)
         {
            this.videoPlayer.pausePlayback();
         }
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
         this.ageRating.x = App.appWidth - AGE_RATING_OFFSET_X;
         this.ageRating.y = AGE_RATING_OFFSET_Y;
         this.shadowImage.x = this.loginViewStack.x - SHADOW_OFFSET_X;
         this.shadowImage.y = this.loginViewStack.y - SHADOW_OFFSET_Y;
         this.shadowVideo.x = this.loginViewStack.x;
         this.shadowVideo.y = this.loginViewStack.y;
         this.bgModeButton.x = App.appWidth - MODE_BUTTON_OFFSET_X;
         this.bgModeButton.y = MODE_BUTTON_OFFSET_Y;
         this.soundButton.x = App.appWidth - (!!this._showSwitcher ? SOUND_BUTTON_OFFSET_X : MODE_BUTTON_OFFSET_X);
         this.soundButton.y = MODE_BUTTON_OFFSET_Y;
         this.vignette.width = App.appWidth;
         this.vignette.height = App.appHeight;
         this.blackScreen.width = App.appWidth;
         this.blackScreen.height = App.appHeight;
         this.bottomShadow.x = App.appWidth >> 1;
         this.bottomShadow.y = App.appHeight;
         this.updateCopyrightPos();
         this.updateLoginWarningPos();
         this.updateRssPositions();
         this.updateWallpaperPosition();
         invalidateSize();
      }
      
      private function updateHealthNotice() : void
      {
         this.healthNotice.x = App.appWidth - this.healthNotice.width >> 1;
         this.healthNotice.y = this.copyright.y - this.healthNotice.height - HEALTH_NOTICE_OFFSET;
      }
      
      private function updateCopyrightPos() : void
      {
         App.utils.commons.updateTextFieldSize(this.copyrightSmall,true,false);
         this.copyrightSmall.y = this.copyright.y = App.appHeight - COPYRIGHT_OFFSET_Y;
         this.copyright.x = this.loginViewStack.x - (this.copyright.getWidth() >> 1);
         this.copyrightSmall.x = this.loginViewStack.x - (this.copyrightSmall.width >> 1);
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
      
      private function updateWallpaperPosition() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this._useWallpaper)
         {
            if(this.bgImage)
            {
               _loc1_ = App.appWidth / BG_IMAGE_WIDTH;
               _loc2_ = App.appHeight / BG_IMAGE_HEIGHT;
               _loc3_ = 1;
               if(_loc1_ > _loc2_)
               {
                  _loc3_ = _loc2_;
               }
               else
               {
                  _loc3_ = _loc1_;
               }
               this.bgImage.scaleX = this.bgImage.scaleY = _loc3_;
               this.bgImage.x = App.appWidth - this.bgImage.width >> 1;
               this.bgImage.y = App.appHeight - this.bgImage.height >> 1;
            }
         }
         else
         {
            this.bgImage.scaleX = this.bgImage.scaleY = 1;
            this.bgImage.x = App.appWidth - this.bgImage.width >> 1;
            this.bgImage.y = App.appHeight - this.bgImage.height >> 1;
         }
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
      
      private function fadeInBg() : void
      {
         if(!this._isWGC)
         {
            this.blackScreen.alpha = 1;
            this.removeTween();
            this._tween = new Tween(TWEEN_DURATION,this.blackScreen,{"alpha":0},{
               "paused":false,
               "ease":Cubic.easeOut,
               "onComplete":this.onFadeInTweenFinished
            });
         }
      }
      
      private function onFadeInTweenFinished() : void
      {
         if(this.bgModeButton)
         {
            this.bgModeButton.enabled = true;
         }
      }
      
      private function removeTween() : void
      {
         if(this._tween != null)
         {
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      private function destroySparks() : void
      {
         if(this._sparksManager != null)
         {
            this._sparksManager.dispose();
            this._sparksManager = null;
         }
         if(this.sparksMc != null)
         {
            removeChild(this.sparksMc);
            this.sparksMc = null;
         }
      }
      
      private function getSparkZone() : Rectangle
      {
         return new Rectangle(SPARK_ZONE.x,SPARK_ZONE.y,stage.width + SPARK_ZONE.right,stage.height + SPARK_ZONE.bottom);
      }
      
      private function createSparks() : void
      {
         if(this._sparksManager == null)
         {
            if(this.sparksMc == null)
            {
               this.sparksMc = new Sprite();
               this.sparksMc.mouseEnabled = false;
               this.sparksMc.mouseChildren = false;
               addChild(this.sparksMc);
            }
            this._sparksManager = ISparksManager(App.utils.classFactory.getObject(Linkages.SPARKS_MGR));
            this._sparksManager.zone = this.getSparkZone();
            this._sparksManager.scope = this.sparksMc;
            this._sparksManager.sparkQuantity = SPARK_QUANTITY;
            this._sparksManager.createSparks();
         }
      }
      
      private function onSoundButtonClickHandler(param1:ButtonEvent) : void
      {
         setMuteS(this.soundButton.selected);
         this.updateButtonsTooltips();
      }
      
      private function onSwitchModeButtonClickHandler(param1:Event) : void
      {
         musicFadeOutS();
         this.bgModeButton.enabled = false;
         this.updateButtonsTooltips();
         this.removeTween();
         this._tween = new Tween(TWEEN_DURATION,this.blackScreen,{"alpha":1},{
            "paused":false,
            "ease":Cubic.easeOut,
            "onComplete":this.onFadeOutTweenFinished
         });
      }
      
      private function onVideoPlayerStatusChangedHandler(param1:VideoPlayerStatusEvent) : void
      {
         if(!this._isVideoLoaded && this.videoPlayer.status == PlayerStatus.PLAYING)
         {
            this._isVideoLoaded = true;
            onVideoLoadedS();
            this.videoPlayer.seek(0);
            this.fadeInBg();
         }
      }
      
      private function onVideoPlayerErrorHandler(param1:VideoPlayerStatusEvent) : void
      {
         DebugUtils.LOG_ERROR("Video " + this.videoPlayer.source + " loading failed!");
         videoLoadingFailedS();
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
                  doUpdateS();
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
      
      private function onBgImageCompleteHandler(param1:UILoaderEvent) : void
      {
         this.bgImage.updateLoaderSize();
         this.updateWallpaperPosition();
         this.removeTween();
         this.fadeInBg();
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
         DebugUtils.LOG_ERROR("Invalid settings for loginForm! See LoginFormPositionHelper!");
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
