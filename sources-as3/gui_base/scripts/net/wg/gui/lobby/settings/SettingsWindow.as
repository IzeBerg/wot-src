package net.wg.gui.lobby.settings
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import net.wg.data.constants.BaseTooltips;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.KeyProps;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.SETTINGS_DIALOGS;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.gui.components.common.CounterBase;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.IconTextButton;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.windows.WindowEvent;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.interfaces.ISettingsBase;
   import net.wg.gui.lobby.settings.components.EventSettingLabel;
   import net.wg.gui.lobby.settings.components.evnts.LimitedUIEvent;
   import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
   import net.wg.gui.lobby.settings.events.AlternativeVoiceEvent;
   import net.wg.gui.lobby.settings.events.SettingViewEvent;
   import net.wg.gui.lobby.settings.feedback.FeedbackSettings;
   import net.wg.gui.lobby.settings.vo.ColorFilerSettingsVo;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.SettingsKeyProp;
   import net.wg.gui.lobby.settings.vo.SettingsNewCountersVo;
   import net.wg.gui.lobby.settings.vo.SettingsTabNewCounterVo;
   import net.wg.gui.lobby.settings.vo.SettingsViewData;
   import net.wg.gui.lobby.settings.vo.TabsDataVo;
   import net.wg.gui.lobby.settings.vo.VisitedCounters;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataIncomeVo;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   import net.wg.gui.lobby.settings.vo.config.ControlsSettingsDataVo;
   import net.wg.infrastructure.base.meta.ISettingsWindowMeta;
   import net.wg.infrastructure.base.meta.impl.SettingsWindowMeta;
   import net.wg.infrastructure.constants.WindowViewInvalidationType;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.infrastructure.interfaces.IWindow;
   import net.wg.infrastructure.managers.counter.CounterManager;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.IAssertable;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.ICounterProps;
   import net.wg.utils.IDataUtils;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.interfaces.IUIComponent;
   import scaleform.clik.utils.Padding;
   
   public class SettingsWindow extends SettingsWindowMeta implements ISettingsWindowMeta
   {
      
      private static var _currentTab:int = 0;
      
      private static const MAX_RENDERER_Y_OFFSET:uint = 18;
      
      private static const MAX_TOOLTIP_WIDTH:uint = 3000;
      
      private static const WINDOW_PADDINGS:Padding = new Padding(35,13,19,10);
      
      private static const FIELD_DATA:String = "data";
      
      private static const FIELD_DESCR:String = "descr";
      
      private static const DISABLED_OVERLAY_LINKAGE:String = "DisabledTabsOverlayUI";
      
      private static const FIELD_CURRENT:String = "current";
      
      private static const FIELD_DEF:String = "default";
      
      private static const FIELD_KEY:String = "key";
      
      private static const FIELD_CMD:String = "cmd";
      
      private static const SETTINGS_COUNTER_CONTAINER_ID:String = "SETTINGS_COUNTER_CONTAINER_ID";
      
      private static const FIELD_VALUES:String = "values";
      
      private static const SOUND_SETTINGS_TAB_INDEX:int = 2;
      
      private static const CONTROL_SETTINGS_TAB_INDEX:int = 3;
      
      private static const NEW_COUNTER_TAB_OFFSET_Y:int = -2;
      
      private static const REFERENCE_HEIGHT:int = 900;
      
      private static const SMALL_TEXTURE_SIZE:int = 384;
      
      private static const BIG_TEXTURE_SIZE:int = 512;
      
      private static const GAMMA_TEXTURE_Y:int = 129;
      
      private static const INV_LIMITED_UI_SETTING_VISIBLE:String = "InvLimitedUISettingVisible";
       
      
      public var tabs:ButtonBarEx = null;
      
      public var tabLine:Sprite = null;
      
      public var view:ViewStack = null;
      
      public var submitBtn:SoundButtonEx = null;
      
      public var cancelBtn:SoundButtonEx = null;
      
      public var applyBtn:SoundButtonEx = null;
      
      public var eventDisableLabel:EventSettingLabel = null;
      
      private var _invalidTabs:Object;
      
      private var _invalidTabsNewCounterData:Object;
      
      private var _pythonSettingsData:SettingsDataVo = null;
      
      private var _feedbackDataProvider:DataProvider = null;
      
      private var _graphicSettings:GraphicSettings = null;
      
      private var _isFeedbackDPInstalled:Boolean = false;
      
      private var _needToUpdateGraphicSettings:Boolean = false;
      
      private var _tabToSelect:int = -1;
      
      private var _graphicsPresetToSelect:int = -1;
      
      private var _isEvent:Boolean = false;
      
      private var _disabledTabsOverlay:DisabledTabsOverlay = null;
      
      private var _settingsConfigHelper:SettingsConfigHelper;
      
      private var _countersData:Vector.<SettingsNewCountersVo> = null;
      
      private var _counterManager:ICounterManager;
      
      private var _limitedUISettingVisible:Boolean = false;
      
      public function SettingsWindow()
      {
         this._invalidTabs = {};
         this._invalidTabsNewCounterData = {};
         this._counterManager = App.utils.counterManager;
         super();
         showWindowBgForm = false;
         this._settingsConfigHelper = SettingsConfigHelper.instance;
         App.atlasMgr.registerAtlas(ATLAS_CONSTANTS.COMMON_BATTLE_LOBBY);
      }
      
      override public function setWindow(param1:IWindow) : void
      {
         super.setWindow(param1);
         if(window)
         {
            window.title = SETTINGS.TITLE;
            window.contentPadding = WINDOW_PADDINGS;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.submitBtn.label = SETTINGS.OK_BUTTON;
         this.cancelBtn.label = SETTINGS.CANCEL_BUTTON;
         this.applyBtn.label = SETTINGS.APPLY_BUTTON;
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler,false,0,true);
         this.applyBtn.addEventListener(ButtonEvent.CLICK,this.onApplyBtnClickHandler,false,0,true);
         this.submitBtn.addEventListener(ButtonEvent.CLICK,this.onSubmitBtnClickHandler,false,0,true);
         if(this.tabs)
         {
            this.tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabIndexChangeHandler);
            this.view.addEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdateHandler);
            this.view.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewViewChangedHandler);
            this.view.addEventListener(LimitedUIEvent.TURN_OFF,this.onLimitedUITurnOffHandler);
            if(this._tabToSelect != -1)
            {
               this.tabs.selectedIndex = this._tabToSelect;
            }
         }
         addEventListener(SettingViewEvent.ON_CONTROL_CHANGED,this.onOnControlChangedHandler);
         addEventListener(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,this.onOnControlNewCountersVisitedHandler);
         addEventListener(SettingViewEvent.ON_PTT_CONTROL_CHANGED,this.onOnPttControlChangedHandler);
         addEventListener(SettingViewEvent.ON_PTT_SOUND_CONTROL_CHANGED,this.onOnPttSoundControlChangedHandler);
         addEventListener(SettingViewEvent.ON_AUTO_DETECT_QUALITY,this.onOnAutoDetectQualityHandler);
         addEventListener(SettingViewEvent.ON_AUTO_DETECT_ACOUSTIC,this.onOnAutoDetectAcousticHandler);
         addEventListener(SettingViewEvent.ON_SOUND_SPEAKER_CHANGE,this.onOnSoundSpeakerChangeHandler);
         addEventListener(SettingViewEvent.ON_VIVOX_TEST,this.onOnVivoxTestHandler);
         addEventListener(SettingViewEvent.ON_UPDATE_CAPTURE_DEVICE,this.onOnUpdateCaptureDeviceHandler);
         addEventListener(AlternativeVoiceEvent.ON_TEST_ALTERNATIVE_VOICES,this.onOnTestAlternativeVoicesHandler);
         addEventListener(AlternativeVoiceEvent.ON_TEST_ARTY_BULB_VOICES,this.onOnTestArtyBulbVoicesHandler);
         addEventListener(AlternativeVoiceEvent.ON_TEST_BULB_VOICES,this.onOnTestBulbVoicesHandler);
         addEventListener(SettingViewEvent.ON_GAMMA_SETTING_OPEN,this.onOnGammaSettingOpenHandler);
         addEventListener(SettingViewEvent.ON_COLOR_SETTING_OPEN,this.onOnColorSettingOpenHandler);
         updateStage(App.appWidth,App.appHeight);
         window.addEventListener(WindowEvent.SCALE_Y_CHANGED,this.onWindowScaleYChangedHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INV_LIMITED_UI_SETTING_VISIBLE))
         {
            this.updateLimitedUISettingVisible();
         }
         if(geometry && window && isInvalid(WindowViewInvalidationType.POSITION_INVALID))
         {
            window.x = App.appWidth - window.getBackground().width >> 1;
            window.y = App.appHeight - window.getBackground().height >> 1;
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.markVisitedCounterItems(_currentTab);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         window.removeEventListener(WindowEvent.SCALE_Y_CHANGED,this.onWindowScaleYChangedHandler);
         this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
         this.applyBtn.removeEventListener(ButtonEvent.CLICK,this.onApplyBtnClickHandler);
         this.submitBtn.removeEventListener(ButtonEvent.CLICK,this.onSubmitBtnClickHandler);
         this.cancelBtn.dispose();
         this.cancelBtn = null;
         this.submitBtn.dispose();
         this.submitBtn = null;
         this.tabLine = null;
         this.applyBtn.dispose();
         this.applyBtn = null;
         this.eventDisableLabel.dispose();
         this.eventDisableLabel = null;
         if(this.view)
         {
            this.view.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdateHandler);
            this.view.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewViewChangedHandler);
            this.view.removeEventListener(LimitedUIEvent.TURN_OFF,this.onLimitedUITurnOffHandler);
            this.view.dispose();
            this.view = null;
         }
         this._counterManager.disposeCountersForContainer(SETTINGS_COUNTER_CONTAINER_ID);
         this._countersData = null;
         this._counterManager = null;
         if(this.tabs)
         {
            this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabIndexChangeHandler);
            this.tabs.dispose();
            this.tabs = null;
         }
         removeEventListener(SettingViewEvent.ON_PTT_CONTROL_CHANGED,this.onOnPttControlChangedHandler);
         removeEventListener(SettingViewEvent.ON_PTT_SOUND_CONTROL_CHANGED,this.onOnPttSoundControlChangedHandler);
         removeEventListener(SettingViewEvent.ON_CONTROL_CHANGED,this.onOnControlChangedHandler);
         removeEventListener(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,this.onOnControlNewCountersVisitedHandler);
         removeEventListener(SettingViewEvent.ON_AUTO_DETECT_QUALITY,this.onOnAutoDetectQualityHandler);
         removeEventListener(SettingViewEvent.ON_AUTO_DETECT_ACOUSTIC,this.onOnAutoDetectAcousticHandler);
         removeEventListener(SettingViewEvent.ON_SOUND_SPEAKER_CHANGE,this.onOnSoundSpeakerChangeHandler);
         removeEventListener(SettingViewEvent.ON_VIVOX_TEST,this.onOnVivoxTestHandler);
         removeEventListener(SettingViewEvent.ON_UPDATE_CAPTURE_DEVICE,this.onOnUpdateCaptureDeviceHandler);
         removeEventListener(AlternativeVoiceEvent.ON_TEST_ALTERNATIVE_VOICES,this.onOnTestAlternativeVoicesHandler);
         removeEventListener(AlternativeVoiceEvent.ON_TEST_ARTY_BULB_VOICES,this.onOnTestArtyBulbVoicesHandler);
         removeEventListener(AlternativeVoiceEvent.ON_TEST_BULB_VOICES,this.onOnTestBulbVoicesHandler);
         removeEventListener(SettingViewEvent.ON_GAMMA_SETTING_OPEN,this.onOnGammaSettingOpenHandler);
         removeEventListener(SettingViewEvent.ON_COLOR_SETTING_OPEN,this.onOnColorSettingOpenHandler);
         this._settingsConfigHelper.changesData.clear();
         this._settingsConfigHelper = null;
         this._invalidTabs = App.utils.data.cleanupDynamicObject(this._invalidTabs);
         this._invalidTabs = null;
         this._invalidTabsNewCounterData = App.utils.data.cleanupDynamicObject(this._invalidTabsNewCounterData);
         this._invalidTabsNewCounterData = null;
         this._pythonSettingsData.dispose();
         this._pythonSettingsData = null;
         this._feedbackDataProvider = null;
         if(this._disabledTabsOverlay != null)
         {
            this._disabledTabsOverlay.dispose();
            this._disabledTabsOverlay = null;
         }
         SettingsConfigHelper.instance.dispose();
         super.onDispose();
      }
      
      override protected function setCaptureDevices(param1:Number, param2:DataProvider) : void
      {
         var _loc3_:SoundSettings = this.getSoundSettings();
         if(_loc3_ != null)
         {
            _loc3_.setCaptureDevices(param1,param2);
         }
      }
      
      override protected function setCountersData(param1:Vector.<SettingsNewCountersVo>) : void
      {
         this._countersData = param1;
         this.invalidateTabsNewCountersData();
         this.updateTabsCounters();
         this.updateNewCounterForCurrentView(SettingsNewCountersForm(this.view.currentView));
      }
      
      override protected function setFeedbackDataProvider(param1:DataProvider) : void
      {
         if(this._feedbackDataProvider != param1 && param1 != null)
         {
            this._feedbackDataProvider = param1;
            this._isFeedbackDPInstalled = false;
         }
      }
      
      public function as_ConfirmationOfApplication(param1:Boolean) : void
      {
         this.updateSettingsConfig();
      }
      
      public function as_confirmWarningDialog(param1:Boolean, param2:String) : void
      {
         var _loc3_:GameSettingsContent = null;
         var _loc4_:Object = null;
         var _loc5_:SettingsControlProp = null;
         switch(param2)
         {
            case SETTINGS_DIALOGS.MINIMAP_ALPHA_NOTIFICATION:
               if(!param1)
               {
                  _loc3_ = this.getGameSettings().getContent();
                  _loc3_.minimapAlphaEnabledCheckbox.selected = false;
               }
               this.updateApplyBtnState();
               break;
            case SETTINGS_DIALOGS.SOUND_MODE_INVALID:
               if(param1)
               {
                  _loc4_ = this._settingsConfigHelper.settingsData[SettingsConfigHelper.SOUND_SETTINGS];
                  _loc5_ = SettingsControlProp(_loc4_[SettingsConfigHelper.ALTERNATIVE_VOICES]);
                  _loc5_.current = 0;
               }
               else
               {
                  this.tabs.selectedIndex = SOUND_SETTINGS_TAB_INDEX;
               }
               this.updateSettingsConfig();
               break;
            case SETTINGS_DIALOGS.CONTROLS_WRONG_NOTIFICATION:
               if(param1)
               {
                  this.updateSettingsConfig();
               }
               else
               {
                  this.tabs.selectedIndex = CONTROL_SETTINGS_TAB_INDEX;
                  this.cancelBtn.enabled = this.submitBtn.enabled = true;
                  this.updateApplyBtnState();
               }
         }
      }
      
      public function as_disableControl(param1:String, param2:String, param3:String) : void
      {
         var _loc5_:SettingsControlProp = null;
         var _loc4_:IAssertable = App.utils.asserter;
         _loc4_.assert(StringUtils.isNotEmpty(param1),"tabId" + Errors.CANT_EMPTY);
         _loc4_.assert(StringUtils.isNotEmpty(param2),"controlID" + Errors.CANT_EMPTY);
         if(StringUtils.isNotEmpty(param3))
         {
            _loc5_ = SettingsControlProp(this._settingsConfigHelper.settingsData[param1][param3][param2]);
         }
         else
         {
            _loc5_ = SettingsControlProp(this._settingsConfigHelper.settingsData[param1][param2]);
         }
         _loc4_.assertNotNull(_loc5_,"controlProp" + Errors.CANT_NULL);
         _loc5_.readOnly = true;
      }
      
      public function as_isPresetApplied() : Boolean
      {
         var _loc2_:DropdownMenu = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc1_:GraphicSettings = this.getGraphicsSettings();
         if(_loc1_)
         {
            _loc2_ = _loc1_.graphicsQualityDropDown;
            _loc3_ = _loc2_.dataProvider.requestItemAt(_loc2_.selectedIndex)[FIELD_DATA];
            _loc4_ = _loc1_.tryFindPreset();
            if(_loc3_ == _loc4_)
            {
               return true;
            }
         }
         return false;
      }
      
      public function as_onSoundSpeakersPresetApply(param1:Boolean) : void
      {
         var _loc2_:SoundSettings = this.getSoundSettings();
         if(_loc2_ != null)
         {
            _loc2_.isPresetApply(param1);
         }
      }
      
      public function as_openTab(param1:Number) : void
      {
         var _loc2_:uint = 0;
         if(this.tabs.dataProvider)
         {
            _loc2_ = this.tabs.dataProvider.length;
            this._tabToSelect = _loc2_ > param1 ? int(param1) : int(_loc2_ - 1);
         }
         else
         {
            this._tabToSelect = param1;
         }
         if(initialized && param1 != -1)
         {
            this.tabs.selectedIndex = param1;
         }
      }
      
      public function as_setColorGradingTechnique(param1:String, param2:String) : void
      {
         var _loc3_:ColorFilerSettingsVo = this._settingsConfigHelper.liveUpdateColorFilterData;
         _loc3_.colorFilterImage = param1;
         _loc3_.colorFilterName = param2;
         _loc3_.colorFilterChanged = true;
         var _loc4_:GraphicSettings = this.getGraphicsSettings();
         if(_loc4_)
         {
            _loc4_.updateDependentData();
         }
      }
      
      public function as_setData(param1:Object) : void
      {
         this._pythonSettingsData = new SettingsDataIncomeVo(param1);
         this.invalidateAllTabs();
         this.initializeCommonData(this._pythonSettingsData);
         App.utils.data.cleanupDynamicObject(param1);
      }
      
      public function as_setGraphicsPreset(param1:Number) : void
      {
         this._graphicsPresetToSelect = param1;
         var _loc2_:GraphicSettings = this.getGraphicsSettings();
         if(_loc2_)
         {
            _loc2_.setPresetAfterAutoDetect(this._graphicsPresetToSelect);
            this._graphicsPresetToSelect = -1;
         }
      }
      
      public function as_setTigerEvent(param1:Boolean) : void
      {
         this.eventDisableLabel.visible = param1;
         this._isEvent = param1;
         if(this.view && this.view.currentView is FeedbackSettings)
         {
            FeedbackSettings(this.view.currentView).setIsEvent(this._isEvent);
         }
      }
      
      public function as_showLimitedUISetting(param1:Boolean) : void
      {
         this._limitedUISettingVisible = param1;
         invalidate(INV_LIMITED_UI_SETTING_VISIBLE);
      }
      
      public function as_updateVideoSettings(param1:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:SettingsControlProp = null;
         var _loc7_:SettingsControlProp = null;
         var _loc8_:Object = null;
         var _loc9_:uint = 0;
         var _loc2_:Boolean = false;
         if(param1)
         {
            _loc4_ = this._settingsConfigHelper.liveUpdateVideoSettingsOrderData.length;
            _loc9_ = 0;
            while(_loc9_ < _loc4_)
            {
               _loc2_ = false;
               _loc5_ = this._settingsConfigHelper.liveUpdateVideoSettingsOrderData[_loc9_];
               _loc6_ = new SettingsControlProp();
               _loc8_ = param1[_loc5_];
               if(_loc8_ != null)
               {
                  if(_loc8_ is Boolean || _loc8_ is String || _loc8_ is Number)
                  {
                     _loc6_.current = _loc8_;
                     _loc2_ = true;
                  }
                  else
                  {
                     if(_loc8_.current is Object && _loc8_.current != undefined)
                     {
                        _loc6_.current = _loc8_.real != null ? _loc8_.real : _loc8_.current;
                     }
                     if(_loc8_.options != undefined)
                     {
                        _loc6_.options = App.utils.data.cloneObject(_loc8_.options);
                        _loc2_ = true;
                     }
                     else
                     {
                        _loc6_.options = [];
                     }
                  }
               }
               else if(_loc5_ == SettingsConfigHelper.DYNAMIC_RENDERER)
               {
                  _loc7_ = this._settingsConfigHelper.liveUpdateVideoSettingsData[_loc5_];
                  if(_loc7_ != null)
                  {
                     _loc7_.dispose();
                  }
                  delete this._settingsConfigHelper.liveUpdateVideoSettingsData[_loc5_];
               }
               if(_loc2_)
               {
                  this._settingsConfigHelper.liveUpdateVideoSettingsData[_loc5_] = _loc6_;
               }
               _loc9_++;
            }
         }
         var _loc3_:GraphicSettings = this.getGraphicsSettings();
         if(_loc3_)
         {
            _loc3_.updateDependentData();
            this._needToUpdateGraphicSettings = false;
         }
         else
         {
            this._needToUpdateGraphicSettings = true;
         }
      }
      
      private function updateLimitedUISettingVisible() : void
      {
         var _loc1_:GameSettings = this.getGameSettings();
         if(_loc1_)
         {
            _loc1_.setLimitedUISettingVisible(this._limitedUISettingVisible);
         }
      }
      
      private function updateNewCounterForCurrentView(param1:SettingsNewCountersForm) : void
      {
         var _loc2_:String = null;
         var _loc3_:SettingsNewCountersVo = null;
         if(this._countersData)
         {
            _loc2_ = param1.viewId;
            _loc3_ = null;
            for each(_loc3_ in this._countersData)
            {
               if(_loc3_.tabId == _loc2_)
               {
                  param1.invalidateNewCounters(_loc3_.subTabsData);
                  break;
               }
            }
         }
      }
      
      private function updateTabsCounters() : void
      {
         var _loc12_:int = 0;
         var _loc13_:String = null;
         var _loc14_:int = 0;
         var _loc1_:SettingsNewCountersVo = null;
         var _loc2_:Number = this.tabs.dataProvider.length;
         var _loc3_:IDataProvider = this.tabs.dataProvider;
         var _loc4_:TabsDataVo = null;
         var _loc5_:DisplayObject = null;
         var _loc6_:Vector.<SettingsTabNewCounterVo> = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:ICounterProps = new CounterProps(CounterProps.DEFAULT_OFFSET_X,NEW_COUNTER_TAB_OFFSET_Y);
         var _loc11_:int = 0;
         while(_loc11_ < _loc2_)
         {
            _loc4_ = TabsDataVo(_loc3_.requestItemAt(_loc11_));
            _loc9_ = 0;
            for each(_loc1_ in this._countersData)
            {
               if(_loc1_.tabId == _loc4_.linkage)
               {
                  _loc5_ = this.tabs.getButtonAt(_loc11_);
                  if(_loc5_)
                  {
                     _loc6_ = _loc1_.subTabsData;
                     _loc8_ = _loc6_.length;
                     _loc12_ = 0;
                     while(_loc12_ < _loc8_)
                     {
                        _loc7_ = _loc6_[_loc12_].counters.length;
                        _loc14_ = 0;
                        while(_loc14_ < _loc7_)
                        {
                           if(_loc6_[_loc12_].counters[_loc14_].count == CounterManager.DEF_COUNTER_NO_VIEWED_VALUE)
                           {
                              _loc9_++;
                           }
                           _loc14_++;
                        }
                        _loc12_++;
                     }
                     _loc13_ = _loc9_.toString();
                     if(_loc13_ == CounterBase.DEFAULT_EMPTY_VALUE)
                     {
                        _loc13_ = null;
                     }
                     this._counterManager.setCounter(_loc5_,_loc13_,SETTINGS_COUNTER_CONTAINER_ID,_loc10_);
                  }
               }
            }
            _loc11_++;
         }
      }
      
      private function getGraphicsSettings() : GraphicSettings
      {
         return GraphicSettings(this.tryGetView(SettingsConfigHelper.GRAPHIC_SETTINGS));
      }
      
      private function getSoundSettings() : SoundSettings
      {
         return SoundSettings(this.tryGetView(SettingsConfigHelper.SOUND_SETTINGS));
      }
      
      private function getGameSettings() : GameSettings
      {
         return GameSettings(this.tryGetView(SettingsConfigHelper.GAME_SETTINGS));
      }
      
      private function invalidateAllTabs() : void
      {
         var _loc2_:Object = null;
         this._invalidTabs = {};
         var _loc1_:Array = this._settingsConfigHelper.tabsDataProvider;
         for each(_loc2_ in _loc1_)
         {
            this._invalidTabs[_loc2_.linkage] = true;
         }
      }
      
      private function invalidateTab(param1:String) : void
      {
         this._invalidTabs[param1] = true;
      }
      
      private function isTabInvalid(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         if(this._invalidTabs.hasOwnProperty(param1) && this._invalidTabs[param1])
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      private function isNewCounterInvalid(param1:String) : Boolean
      {
         return this._invalidTabsNewCounterData.hasOwnProperty(param1) && this._invalidTabsNewCounterData[param1];
      }
      
      private function invalidateTabsNewCountersData() : void
      {
         var _loc2_:Object = null;
         App.utils.data.cleanupDynamicObject(this._invalidTabsNewCounterData);
         this._invalidTabsNewCounterData = {};
         var _loc1_:Array = this._settingsConfigHelper.tabsDataProvider;
         for each(_loc2_ in _loc1_)
         {
            this._invalidTabsNewCounterData[_loc2_.linkage] = true;
         }
      }
      
      private function updateTabIfNeeded(param1:String, param2:IViewStackContent) : void
      {
         var _loc4_:SettingsDataVo = null;
         var _loc3_:ISettingsBase = ISettingsBase(param2);
         if(this.isTabInvalid(param1))
         {
            _loc4_ = this._settingsConfigHelper.getDataItem(param1,_loc3_.needDataWithChanges());
            param2.update(new SettingsViewData(param1,_loc4_));
            this._invalidTabs[param1] = false;
         }
         if(this.isNewCounterInvalid(param1))
         {
            this._invalidTabsNewCounterData[param1] = false;
            this.updateNewCounterForCurrentView(SettingsNewCountersForm(_loc3_));
         }
         if(param1 == GameSettings.LINKAGE)
         {
            this.updateLimitedUISettingVisible();
         }
      }
      
      private function initializeCommonData(param1:SettingsDataVo) : void
      {
         var _loc2_:SettingsDataVo = null;
         var _loc3_:String = null;
         var _loc4_:IViewStackContent = null;
         this.normalize(param1);
         this._settingsConfigHelper.changesData.clear();
         this.updateApplyBtnState();
         if(this.tabs)
         {
            _loc2_ = this._settingsConfigHelper.settingsData;
            this.updateTabs();
            _loc3_ = this._settingsConfigHelper.tabsDataProvider[_currentTab].linkage;
            this.view.show(_loc3_,_loc3_);
            _loc4_ = IViewStackContent(this.view.currentView);
            _loc4_.update(new SettingsViewData(_loc3_,_loc2_[_loc3_]));
            this.updateNewCounterForCurrentView(SettingsNewCountersForm(_loc4_));
            this._invalidTabs[_loc3_] = false;
            this.tabs.validateNow();
            if(!this._isFeedbackDPInstalled && _loc4_ is FeedbackSettings)
            {
               this._isFeedbackDPInstalled = true;
               FeedbackSettings(_loc4_).setDataProvider(this._feedbackDataProvider);
            }
            if(_loc4_ is FeedbackSettings)
            {
               FeedbackSettings(_loc4_).setIsEvent(this._isEvent);
            }
         }
      }
      
      private function updateTabs() : void
      {
         var _loc2_:uint = 0;
         var _loc1_:DataProvider = new DataProvider(this._settingsConfigHelper.tabsDataProvider);
         this.tabs.dataProvider = _loc1_;
         if(this.tabs.selectedIndex == -1)
         {
            _loc2_ = _loc1_.length;
            if(_currentTab >= _loc2_)
            {
               this.tabs.selectedIndex = _currentTab = _loc2_ - 1;
            }
            else
            {
               this.tabs.selectedIndex = _currentTab;
            }
         }
      }
      
      override protected function setDisabledTabsOverlay(param1:Vector.<int>, param2:String) : void
      {
         if(this._disabledTabsOverlay == null)
         {
            this._disabledTabsOverlay = App.utils.classFactory.getComponent(DISABLED_OVERLAY_LINKAGE,DisabledTabsOverlay);
            addChild(this._disabledTabsOverlay);
            this._disabledTabsOverlay.setupTabs(this.tabs,param1,param2);
            this.updateCurrentDisabledView(this.view.currentView);
         }
      }
      
      private function updateCurrentDisabledView(param1:IUIComponent) : void
      {
         if(this._disabledTabsOverlay != null)
         {
            this._disabledTabsOverlay.updateDisabledView(param1 as DisplayObjectContainer,_currentTab);
         }
      }
      
      private function controlDefValEqNewVal(param1:Object, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Object = null;
         var _loc6_:* = null;
         if(param1 is SettingsControlProp)
         {
            _loc3_ = param2 as Array;
            if(_loc3_)
            {
               _loc4_ = SettingsControlProp(param1).current as Array;
               return _loc4_ != null ? Boolean(_loc4_.join() == _loc3_.join()) : Boolean(false);
            }
            return SettingsControlProp(param1).current == param2;
         }
         if(param1 is SettingsKeyProp)
         {
            return SettingsKeyProp(param1).key == param2;
         }
         if(!(param2 is String) && !(param2 is Number) && !(param2 is Boolean))
         {
            for(_loc6_ in param2)
            {
               _loc5_ = param1.getByKey(_loc6_);
               if(_loc5_ != null)
               {
                  if(_loc5_ is SettingsControlProp)
                  {
                     return SettingsControlProp(_loc5_).current == param2[_loc6_];
                  }
                  if(_loc5_ is SettingsKeyProp)
                  {
                     return SettingsKeyProp(_loc5_).key == param2[_loc6_];
                  }
                  return this.controlDefValEqNewVal(_loc5_,param2[_loc6_]);
               }
            }
         }
         return false;
      }
      
      private function checkChanges(param1:Boolean, param2:String, param3:Object) : void
      {
         if(param1)
         {
            this._settingsConfigHelper.changesData.tryCutChanges(param2,param3);
         }
         else
         {
            this._settingsConfigHelper.changesData.tryAddChanges(param2,param3);
         }
         this.updateApplyBtnState();
      }
      
      private function updateApplyBtnState() : void
      {
         this.applyBtn.enabled = this.hasChangesData;
      }
      
      private function tryGetView(param1:String) : MovieClip
      {
         if(!this.view)
         {
            return null;
         }
         return this.view.cachedViews[param1];
      }
      
      private function normalize(param1:SettingsDataVo) : void
      {
         var _loc8_:SettingsControlProp = null;
         var _loc9_:SettingsKeyProp = null;
         var _loc2_:SettingsDataVo = this._settingsConfigHelper.settingsData;
         var _loc3_:Vector.<String> = param1.keys;
         var _loc4_:Vector.<Object> = param1.values;
         var _loc5_:int = _loc3_.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            if(_loc4_[_loc6_])
            {
               this.normalizeInside(SettingsDataVo(_loc4_[_loc6_]),_loc2_[_loc3_[_loc6_]]);
            }
            _loc6_++;
         }
         if(_loc2_[SettingsConfigHelper.SOUND_SETTINGS][SettingsConfigHelper.PTT] && _loc2_[SettingsConfigHelper.CONTROLS_SETTINGS][SettingsConfigHelper.KEYBOARD].getByKey(SettingsConfigHelper.PUSH_TO_TALK))
         {
            _loc8_ = SettingsControlProp(_loc2_[SettingsConfigHelper.SOUND_SETTINGS][SettingsConfigHelper.PTT]);
            _loc9_ = SettingsKeyProp(_loc2_[SettingsConfigHelper.CONTROLS_SETTINGS][SettingsConfigHelper.KEYBOARD].getByKey(SettingsConfigHelper.PUSH_TO_TALK));
            _loc8_.current = _loc9_.key;
         }
         var _loc7_:SettingsDataVo = _loc2_[SettingsConfigHelper.GAME_SETTINGS];
         _loc7_[SettingsConfigHelper.ENABLE_OL_FILTER].readOnly = App.globalVarsMgr.isChinaS();
         _loc7_[SettingsConfigHelper.MINIMAP_ALPHA].readOnly = !_loc7_[SettingsConfigHelper.MINIMAP_ALPHA_ENABLED].current;
      }
      
      private function normalizeInside(param1:SettingsDataVo, param2:SettingsDataVo) : void
      {
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc3_:int = param1.keys.length;
         var _loc4_:String = Values.EMPTY_STR;
         var _loc5_:Object = null;
         var _loc7_:IDataUtils = App.utils.data;
         var _loc8_:int = 0;
         for(; _loc8_ < _loc3_; _loc8_++)
         {
            _loc4_ = param1.keys[_loc8_];
            _loc5_ = param1.values[_loc8_];
            if(_loc5_ == null)
            {
               continue;
            }
            switch(_loc4_)
            {
               case SettingsConfigHelper.PRESETS:
                  param2[_loc4_] = new SettingsDataVo(_loc7_.cloneObject(_loc5_));
                  break;
               case SettingsConfigHelper.QUALITY_ORDER:
                  if(_loc5_ is Array)
                  {
                     _loc6_ = _loc5_.length;
                     _loc9_ = 0;
                     while(_loc9_ < _loc6_)
                     {
                        param2[_loc4_].push(_loc5_[_loc9_]);
                        _loc9_++;
                     }
                  }
                  break;
               case SettingsConfigHelper.KEYBOARD_IMPORTANT_BINDS:
                  param2[_loc4_] = Vector.<String>(_loc5_);
                  break;
               case SettingsConfigHelper.KEYBOARD:
                  this.normalizeKeys(_loc5_,param2[_loc4_],param2[SettingsConfigHelper.KEYS_LAYOUT_ORDER]);
                  break;
               default:
                  this.normalizeDefault(param2,_loc4_,_loc5_);
                  break;
            }
         }
      }
      
      private function normalizeDefault(param1:SettingsDataVo, param2:String, param3:Object) : void
      {
         var _loc6_:* = null;
         var _loc7_:SettingsDataVo = null;
         var _loc4_:IDataUtils = App.utils.data;
         var _loc5_:SettingsControlProp = param1[param2] as SettingsControlProp;
         if(_loc5_)
         {
            if(param3 is Boolean || param3 is String || param3 is Number)
            {
               _loc5_.current = _loc5_.type == SettingsConfigHelper.TYPE_CHECKBOX ? Boolean(param3) : param3;
               _loc5_.prevVal = _loc5_.current;
            }
            else if(param3 is Array)
            {
               if(_loc5_.type == SettingsConfigHelper.TYPE_RANGE_SLIDER)
               {
                  _loc5_.current = param3;
               }
            }
            else if(param3 is Object && param3.current != undefined)
            {
               if(_loc5_.type == SettingsConfigHelper.TYPE_CHECKBOX)
               {
                  _loc5_.current = Boolean(param3.current);
                  _loc5_.prevVal = _loc5_.current;
                  if(param1 is ControlsSettingsDataVo)
                  {
                     this.tryToSetDefault(param3,_loc5_);
                  }
                  if(param3.hasOwnProperty(SettingsControlProp.OPTIONS_LBL))
                  {
                     _loc5_.options = _loc4_.cloneObject(param3.options);
                     for(_loc6_ in param3.options)
                     {
                        if(param3.options[_loc6_].hasOwnProperty(SettingsControlProp.ADVANCED_LBL) && param3.options[_loc6_].advanced == true)
                        {
                           _loc5_.advanced = true;
                           break;
                        }
                     }
                  }
               }
               else
               {
                  _loc5_.current = Math.max(param3.current,0);
                  _loc5_.prevVal = _loc5_.current;
                  if(param1 is ControlsSettingsDataVo)
                  {
                     this.tryToSetDefault(param3,_loc5_);
                  }
                  if(param3.options != undefined)
                  {
                     _loc5_.options = _loc4_.cloneObject(param3.options);
                  }
                  else
                  {
                     _loc5_.options = [];
                  }
               }
               if(param3.hasOwnProperty(SettingsControlProp.EXTRA_DATA_LBL))
               {
                  _loc5_.extraData = _loc4_.cloneObject(param3.extraData);
               }
            }
         }
         else if(param1[param2] != undefined)
         {
            _loc7_ = new SettingsDataVo(param3);
            App.utils.data.cleanupDynamicObject(param3);
            this.normalizeInside(_loc7_,param1[param2]);
            _loc7_.dispose();
         }
      }
      
      private function tryToSetDefault(param1:Object, param2:SettingsControlProp) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:Object = null;
         if(param1.hasOwnProperty(SettingsControlProp.DEFAULT_LBL))
         {
            _loc3_ = true;
         }
         if(param2.type == SettingsConfigHelper.TYPE_CHECKBOX)
         {
            _loc4_ = _loc3_ && Boolean(param1[FIELD_DEF]);
         }
         else
         {
            _loc4_ = !!_loc3_ ? Math.max(param1[FIELD_DEF],0) : 0;
         }
         param2.defaultValue = _loc4_;
      }
      
      private function normalizeKeys(param1:Object, param2:SettingsDataVo, param3:Vector.<String>) : void
      {
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc8_:uint = 0;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:Array = null;
         var _loc12_:Object = null;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc19_:uint = 0;
         param2.keys.splice(0,param2.keys.length);
         param2.values.splice(0,param2.values.length);
         param3.splice(0,param3.length);
         var _loc15_:Array = param1[SettingsConfigHelper.KEYS_LAYOUT];
         var _loc16_:Object = param1[SettingsConfigHelper.KEYS_TOOLTIPS];
         var _loc17_:uint = _loc15_.length;
         var _loc18_:uint = 0;
         while(_loc18_ < _loc17_)
         {
            _loc7_ = _loc15_[_loc18_];
            _loc4_ = _loc7_[FIELD_KEY];
            _loc5_ = _loc7_[FIELD_VALUES];
            _loc8_ = _loc5_.length;
            param3.push(_loc4_);
            param2.keys.push(_loc4_);
            param2.values.push(new SettingsKeyProp(_loc4_,true,_loc4_,null,NaN,NaN,null,false,_loc18_ == 0 ? Number(0) : Number(MAX_RENDERER_Y_OFFSET)));
            _loc19_ = 0;
            while(_loc19_ < _loc8_)
            {
               _loc6_ = _loc5_[_loc19_];
               _loc9_ = _loc6_[FIELD_KEY];
               _loc10_ = _loc6_[FIELD_CMD];
               _loc11_ = !!_loc6_.hasOwnProperty(FIELD_DESCR) ? _loc6_[FIELD_DESCR] : null;
               _loc12_ = param1[_loc9_];
               if(_loc12_[FIELD_CURRENT] >= 0)
               {
                  _loc13_ = _loc12_[FIELD_CURRENT];
                  _loc14_ = _loc12_[FIELD_DEF];
                  param3.push(_loc9_);
                  param2.keys.push(_loc9_);
                  param2.values.push(new SettingsKeyProp(_loc9_,false,_loc9_,_loc10_,_loc13_,_loc14_,_loc11_,true,0,_loc16_[_loc9_]));
               }
               _loc19_++;
            }
            _loc18_++;
         }
      }
      
      private function sendData(param1:Boolean) : void
      {
         var _loc6_:String = null;
         var _loc7_:GraphicSettings = null;
         this.cancelBtn.enabled = this.applyBtn.enabled = this.submitBtn.enabled = false;
         var _loc2_:SoundSettings = this.getSoundSettings();
         if(_loc2_)
         {
            _loc2_.breakSoundCheck();
         }
         var _loc3_:Boolean = this.checkControlsWrong();
         var _loc4_:Boolean = !isSoundModeValidS();
         var _loc5_:Object = this._settingsConfigHelper.changesData.getChanges();
         if(_loc3_ || _loc4_)
         {
            _loc6_ = !!_loc3_ ? SETTINGS_DIALOGS.CONTROLS_WRONG_NOTIFICATION : Values.EMPTY_STR;
            _loc6_ += !!_loc4_ ? SETTINGS_DIALOGS.SOUND_MODE_INVALID : Values.EMPTY_STR;
            showWarningDialogS(_loc6_,_loc5_,param1);
         }
         else
         {
            _loc7_ = this.getGraphicsSettings();
            if(_loc7_)
            {
               _loc7_.rewriteInitialValues();
            }
            applySettingsS(_loc5_,param1);
            if(!param1)
            {
               this.as_ConfirmationOfApplication(false);
            }
         }
      }
      
      private function checkControlsWrong() : Boolean
      {
         var _loc2_:Vector.<String> = null;
         var _loc3_:Object = null;
         var _loc4_:Vector.<Object> = null;
         var _loc5_:SettingsKeyProp = null;
         var _loc1_:ControlsSettings = ControlsSettings(this.tryGetView(SettingsConfigHelper.CONTROLS_SETTINGS));
         if(_loc1_)
         {
            return _loc1_.isControlsChanged(!this.hasChangesData);
         }
         _loc2_ = this._settingsConfigHelper.settingsData[SettingsConfigHelper.CONTROLS_SETTINGS][SettingsConfigHelper.KEYBOARD_IMPORTANT_BINDS];
         _loc3_ = this._settingsConfigHelper.settingsData[SettingsConfigHelper.CONTROLS_SETTINGS][SettingsConfigHelper.KEYBOARD];
         _loc4_ = SettingsDataVo(_loc3_).values;
         for each(_loc5_ in _loc4_)
         {
            if(_loc5_.key == KeyProps.KEY_NONE && _loc2_.indexOf(_loc5_.id) != -1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function updateSettingsConfig() : void
      {
         this._settingsConfigHelper.applyChangesToCurrentData();
         this.cancelBtn.enabled = this.submitBtn.enabled = true;
         this.updateApplyBtnState();
      }
      
      private function showSoundTestErrorTooltip(param1:IconTextButton) : void
      {
         var _loc2_:Number = param1.x;
         var _loc3_:Number = param1.y;
         var _loc4_:Point = this.localToGlobal(new Point(_loc2_,_loc3_));
         var _loc5_:ITooltipProps = new TooltipProps(BaseTooltips.TYPE_WARNING,_loc4_.x,_loc4_.y,0,0,MAX_TOOLTIP_WIDTH);
         var _loc6_:String = App.textMgr.getTextStyleById(TEXT_MANAGER_STYLES.ERROR_TEXT,App.utils.locale.makeString(TOOLTIPS.SETTINGS_DIALOG_SOUND_SOUNDMODEINVALID));
         App.toolTipMgr.show(_loc6_,_loc5_);
      }
      
      private function markVisitedCounterItems(param1:int) : void
      {
         var _loc4_:SettingsNewCountersForm = null;
         var _loc5_:Array = null;
         var _loc6_:VisitedCounters = null;
         var _loc2_:String = this._settingsConfigHelper.tabsDataProvider[_currentTab].linkage;
         var _loc3_:MovieClip = this.tryGetView(_loc2_);
         if(this.view && _loc3_)
         {
            _loc4_ = SettingsNewCountersForm(_loc3_);
            if(_loc4_)
            {
               _loc5_ = _loc4_.markVisitedCounters();
               if(_loc5_.length)
               {
                  for each(_loc6_ in _loc5_)
                  {
                     if(_loc6_.ids && _loc6_.ids.length)
                     {
                        onCounterTargetVisitedS(_loc6_.viewId,_loc6_.subViewId,_loc6_.ids);
                     }
                     _loc6_.dispose();
                  }
                  _loc5_.splice(0,_loc5_.length);
                  _loc5_ = null;
               }
            }
         }
      }
      
      private function get hasChangesData() : Boolean
      {
         return this._settingsConfigHelper.changesData.length > 0;
      }
      
      private function onOnControlNewCountersVisitedHandler(param1:SettingViewEvent) : void
      {
         var _loc2_:String = param1.viewId;
         var _loc3_:String = param1.subViewId;
         var _loc4_:Array = param1.controlValue as Array;
         if(_loc4_ && _loc4_.length)
         {
            onCounterTargetVisitedS(_loc2_,_loc3_,_loc4_);
         }
      }
      
      private function onTabIndexChangeHandler(param1:IndexEvent) : void
      {
         this.markVisitedCounterItems(_currentTab);
         _currentTab = param1.index;
         App.toolTipMgr.hide();
         var _loc2_:SoundSettings = this.getSoundSettings();
         if(_loc2_)
         {
            _loc2_.onViewChanged();
         }
         onTabSelectedS(this._settingsConfigHelper.tabsDataProvider[_currentTab].label);
         this.updateCurrentDisabledView(this.view.currentView);
      }
      
      private function onViewNeedUpdateHandler(param1:ViewStackEvent) : void
      {
         this.updateTabIfNeeded(param1.viewId,param1.view);
      }
      
      private function onViewViewChangedHandler(param1:ViewStackEvent) : void
      {
         this.updateTabIfNeeded(param1.viewId,param1.view);
         var _loc2_:IViewStackContent = param1.view;
         var _loc3_:ISettingsBase = ISettingsBase(_loc2_);
         var _loc4_:GraphicSettings = _loc3_ as GraphicSettings;
         if(_loc4_)
         {
            if(this._needToUpdateGraphicSettings)
            {
               _loc4_.updateDependentData();
               this._needToUpdateGraphicSettings = false;
            }
            if(this._graphicsPresetToSelect != -1)
            {
               _loc4_.setPresetAfterAutoDetect(this._graphicsPresetToSelect);
               this._graphicsPresetToSelect = -1;
            }
         }
         else
         {
            _loc3_.updateDependentData();
         }
         if(!this._isFeedbackDPInstalled && _loc2_ is FeedbackSettings)
         {
            this._isFeedbackDPInstalled = true;
            FeedbackSettings(_loc2_).setDataProvider(this._feedbackDataProvider);
            FeedbackSettings(_loc2_).setIsEvent(this._isEvent);
         }
      }
      
      private function onOnPttControlChangedHandler(param1:SettingViewEvent) : void
      {
         var _loc2_:SettingsControlProp = SettingsControlProp(this._settingsConfigHelper.settingsData[SettingsConfigHelper.SOUND_SETTINGS][SettingsConfigHelper.PTT]);
         _loc2_.current = param1.controlValue;
         var _loc3_:SoundSettings = this.getSoundSettings();
         if(_loc3_)
         {
            _loc3_.updatePTTControl(Number(_loc2_.current));
         }
      }
      
      private function onOnPttSoundControlChangedHandler(param1:SettingViewEvent) : void
      {
         this.invalidateTab(SettingsConfigHelper.CONTROLS_SETTINGS);
      }
      
      private function onOnControlChangedHandler(param1:SettingViewEvent) : void
      {
         var _loc11_:Object = null;
         var _loc2_:String = param1.viewId;
         var _loc3_:String = param1.subViewId;
         var _loc4_:String = param1.controlId;
         var _loc5_:Object = param1.controlValue;
         var _loc6_:SettingsDataVo = this._settingsConfigHelper.settingsData;
         var _loc7_:Object = _loc6_.getByKey(_loc2_);
         var _loc8_:String = _loc4_;
         var _loc9_:Object = _loc5_;
         if(_loc3_)
         {
            _loc7_ = _loc7_.getByKey(_loc3_);
            _loc8_ = _loc3_;
            _loc9_ = {};
            _loc9_[_loc4_] = _loc5_;
         }
         var _loc10_:Boolean = this.controlDefValEqNewVal(_loc7_.getByKey(_loc4_),_loc5_);
         onSettingsChangeS(_loc8_,_loc9_);
         this.checkChanges(_loc10_,_loc8_,_loc9_);
         if(!this._graphicSettings)
         {
            this._graphicSettings = this.getGraphicsSettings();
         }
         if(this._graphicSettings)
         {
            this._graphicSettings.onSettingsChanged();
         }
         if(_loc4_ == SettingsConfigHelper.MINIMAP_ALPHA_ENABLED && _loc5_)
         {
            _loc11_ = this._settingsConfigHelper.changesData.getChanges();
            showWarningDialogS(SETTINGS_DIALOGS.MINIMAP_ALPHA_NOTIFICATION,_loc11_,false);
         }
      }
      
      private function onOnVivoxTestHandler(param1:SettingViewEvent) : void
      {
         var _loc2_:Boolean = Boolean(param1.controlValue);
         var _loc3_:Boolean = startVOIPTestS(_loc2_);
         var _loc4_:SoundSettings = this.getSoundSettings();
         if(_loc4_)
         {
            _loc4_.setVoiceTestState(!(_loc3_ || !_loc2_));
         }
      }
      
      private function onOnAutoDetectQualityHandler(param1:SettingViewEvent) : void
      {
         var _loc2_:Number = autodetectQualityS();
         var _loc3_:GraphicSettings = this.getGraphicsSettings();
         if(_loc3_ != null)
         {
            _loc3_.setPresetAfterAutoDetect(_loc2_);
         }
      }
      
      private function onOnAutoDetectAcousticHandler(param1:SettingViewEvent) : void
      {
         var _loc2_:String = autodetectAcousticTypeS();
         var _loc3_:SoundSettings = this.getSoundSettings();
         if(_loc3_ != null)
         {
            _loc3_.updateAcousticDeviceByType(_loc2_);
         }
      }
      
      private function onOnSoundSpeakerChangeHandler(param1:SettingViewEvent) : void
      {
         var _loc2_:Boolean = canSelectAcousticTypeS(Number(param1.controlValue));
         var _loc3_:SoundSettings = this.getSoundSettings();
         if(_loc3_ != null)
         {
            _loc3_.isCanSelectAcousticType(_loc2_);
         }
      }
      
      private function onOnUpdateCaptureDeviceHandler(param1:SettingViewEvent) : void
      {
         updateCaptureDevicesS();
      }
      
      private function onOnTestAlternativeVoicesHandler(param1:AlternativeVoiceEvent) : void
      {
         var _loc2_:SoundSettings = null;
         if(isSoundModeValidS())
         {
            altVoicesPreviewS();
         }
         else
         {
            _loc2_ = this.getSoundSettings();
            this.showSoundTestErrorTooltip(_loc2_.testAlternativeVoicesButton);
         }
      }
      
      private function onOnTestBulbVoicesHandler(param1:AlternativeVoiceEvent) : void
      {
         var _loc2_:SoundSettings = null;
         if(isSoundModeValidS())
         {
            altBulbPreviewS(param1.id);
         }
         else
         {
            _loc2_ = this.getSoundSettings();
            this.showSoundTestErrorTooltip(_loc2_.bulbVoicesButton);
         }
      }
      
      private function onOnTestArtyBulbVoicesHandler(param1:AlternativeVoiceEvent) : void
      {
         var _loc2_:SoundSettings = null;
         if(isSoundModeValidS())
         {
            artyBulbPreviewS(param1.id);
         }
         else
         {
            _loc2_ = this.getSoundSettings();
            this.showSoundTestErrorTooltip(_loc2_.artyBulbVoicesButton);
         }
      }
      
      private function onCancelBtnClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:SoundSettings = this.getSoundSettings();
         if(_loc2_)
         {
            _loc2_.breakSoundCheck();
         }
         onWindowCloseS();
      }
      
      private function onApplyBtnClickHandler(param1:ButtonEvent) : void
      {
         this.sendData(false);
      }
      
      private function onSubmitBtnClickHandler(param1:ButtonEvent) : void
      {
         this.sendData(true);
      }
      
      private function onWindowScaleYChangedHandler(param1:WindowEvent) : void
      {
         invalidate(WindowViewInvalidationType.POSITION_INVALID);
      }
      
      private function onOnGammaSettingOpenHandler(param1:SettingViewEvent) : void
      {
         var _loc2_:Boolean = App.appHeight < REFERENCE_HEIGHT;
         var _loc3_:int = !!_loc2_ ? int(SMALL_TEXTURE_SIZE) : int(BIG_TEXTURE_SIZE);
         var _loc4_:int = App.appWidth - _loc3_ >> 1;
         openGammaWizardS(_loc4_,GAMMA_TEXTURE_Y,_loc3_);
      }
      
      private function onOnColorSettingOpenHandler(param1:SettingViewEvent) : void
      {
         openColorSettingsS();
      }
      
      private function onLimitedUITurnOffHandler(param1:LimitedUIEvent) : void
      {
         var _loc2_:Object = this._settingsConfigHelper.changesData.getChanges();
         showWarningDialogS(SETTINGS_DIALOGS.LIMITED_UI_OFF_NOTIFICATION,_loc2_,true);
      }
   }
}
