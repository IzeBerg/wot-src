package net.wg.gui.lobby.settings
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ACOUSTICS;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.data.Aliases;
   import net.wg.gui.lobby.settings.components.KeyInput;
   import net.wg.gui.lobby.settings.components.SoundDeviceTabButton;
   import net.wg.gui.lobby.settings.components.evnts.KeyInputEvents;
   import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
   import net.wg.gui.lobby.settings.events.AlternativeVoiceEvent;
   import net.wg.gui.lobby.settings.events.SettingViewEvent;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.SettingsKeyProp;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICommons;
   import net.wg.utils.ICounterProps;
   import net.wg.utils.IUtils;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.events.SliderEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class SoundSettings extends SoundSettingsBase implements IPopOverCaller
   {
      
      private static const VOICE_TEST_DURATION:Number = 10;
      
      private static const VOICE_TEST_UPDATE_RATE:Number = 0.1;
      
      private static const COMMON_TAB_INDEX:int = 0;
      
      private static const VIVOX_TAB_INDEX:int = 1;
      
      private static const SPECIAL_TAB_INDEX:int = 2;
      
      private static const ENABLE_ALPHA:Number = 1;
      
      private static const DISABLE_ALPHA:Number = 0.5;
      
      private static const SOUND_COUNTER_CONTAINER_ID:String = "SOUND_COUNTER_CONTAINER_ID";
      
      private static const COUNTER_CHECKBOX_OFFSET_X:Number = -17;
      
      private static const BULB_VOICES_NULL_ERROR:String = "_existsBulbVoices";
      
      private static const ARTY_BULB_VOICES_NULL_ERROR:String = "_existsArtyBulbVoices";
       
      
      private var _isVoiceTestStarted:Boolean = false;
      
      private var _vivoxTestTimeLeft:Number = 0;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _existsBulbVoices:Array = null;
      
      private var _existsArtyBulbVoices:Array = null;
      
      private var _masterVolumeSelected:Boolean = false;
      
      private var _typeAcousticsSelected:Boolean = false;
      
      private var _isAcousticsAlertVisible:Boolean = false;
      
      public function SoundSettings()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override public function toString() : String
      {
         return "[WG SoundSettings " + name + "]";
      }
      
      override public function updateDependentData() : void
      {
         this.updatesPttKeyList();
      }
      
      override protected function getCounterProps(param1:String) : ICounterProps
      {
         if(param1 == SettingsConfigHelper.TYPE_CHECKBOX)
         {
            return new CounterProps(COUNTER_CHECKBOX_OFFSET_X,CounterProps.DEFAULT_OFFSET_Y,TextFormatAlign.LEFT,false,Linkages.COUNTER_LINE_UI);
         }
         return super.getCounterProps(param1);
      }
      
      override protected function getContainerId() : String
      {
         return SOUND_COUNTER_CONTAINER_ID;
      }
      
      override protected function configUI() : void
      {
         soundSpeakersTestButton.addEventListener(ButtonEvent.CLICK,this.onSoundSpeakersTestButtonClickHandler);
         btnVivoxTest.addEventListener(ButtonEvent.CLICK,this.onBtnVivoxTestClickHandler);
         btnCaptureDevicesUpdate.addEventListener(ButtonEvent.CLICK,this.onBtnCaptureDevicesUpdateClickHandler);
         PTTKeyInput.addEventListener(KeyInputEvents.DISABLE_OVER,this.onPTTKeyInputDisableOverHandler);
         PTTKeyInput.addEventListener(KeyInputEvents.DISABLE_OUT,this.onPTTKeyInputDisableOutHandler);
         PTTKeyInput.addEventListener(KeyInputEvents.DISABLE_PRESS,this.onPTTKeyInputDisablePressHandler);
         PTTKeyInput.addEventListener(KeyInputEvents.CHANGE,this.onPTTKeyInputChangeHandler);
         PTTKeyInput.alertMessageAlias = TOOLTIPS.SETTING_WINDOW_CONTROLS_KEY_INPUT_PTT_WARNING;
         this.updatesPttKeyList();
         testAlternativeVoicesButton.addEventListener(ButtonEvent.CLICK,this.onTestAlternativeVoicesButtonClickHandler);
         testAlternativeVoicesButton.addEventListener(MouseEvent.MOUSE_OVER,this.onTestAlternativeVoicesButtonMouseOverHandler);
         testAlternativeVoicesButton.addEventListener(MouseEvent.MOUSE_OUT,this.onTestAlternativeVoicesButtonMouseOutHandler);
         bulbVoicesButton.addEventListener(ButtonEvent.CLICK,this.onTestBulbVoicesButtonClickHandler);
         bulbVoicesButton.addEventListener(MouseEvent.MOUSE_OVER,this.onTestBulbVoicesButtonMouseOverHandler);
         bulbVoicesButton.addEventListener(MouseEvent.MOUSE_OUT,this.onTestBulbVoicesButtonMouseOutHandler);
         artyBulbVoicesButton.addEventListener(ButtonEvent.CLICK,this.onArtyBulbVoicesButtonClickHandler);
         artyBulbVoicesButton.addEventListener(MouseEvent.MOUSE_OVER,this.onArtyBulbVoicesButtonMouseOverHandler);
         artyBulbVoicesButton.addEventListener(MouseEvent.MOUSE_OUT,this.onArtyBulbVoicesButtonMouseOutHandler);
         enableVoIPCheckbox.enabled = App.voiceChatMgr.getYY();
         tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabsIndexChangeHandler);
         super.configUI();
      }
      
      override protected function setData(param1:SettingsDataVo) : void
      {
         var _loc9_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:DisplayObject = null;
         var _loc15_:Boolean = false;
         var _loc16_:KeyInput = null;
         this.controlsUnsubscribe();
         super.setData(param1);
         var _loc2_:SettingsControlProp = SettingsControlProp(param1.getByKey(SettingsConfigHelper.VOICE_CHAT_SUPPORTED));
         var _loc3_:Boolean = _loc2_.current;
         var _loc4_:Array = [{"label":SETTINGS.SOUNDS_TABCOMMON}];
         var _loc5_:Boolean = App.voiceChatMgr.getYY();
         if(_loc3_ || _loc5_)
         {
            _loc4_.push({"label":SETTINGS.SOUNDS_TABVIVOX});
            enableVoIPCheckbox.visible = true;
            this.showHideVoiceSettings(_loc3_);
         }
         tabs.dataProvider = new DataProvider(_loc4_);
         tabs.visible = _loc4_.length > 1;
         var _loc6_:Vector.<String> = param1.keys;
         var _loc7_:Vector.<Object> = param1.values;
         var _loc8_:int = _loc6_.length;
         var _loc10_:SettingsControlProp = null;
         var _loc14_:int = 0;
         while(_loc14_ < _loc8_)
         {
            _loc9_ = _loc6_[_loc14_];
            _loc10_ = SettingsControlProp(_loc7_[_loc14_]);
            _loc11_ = _loc10_.type;
            _loc12_ = _loc9_ + _loc11_;
            _loc13_ = this[_loc12_] as DisplayObject;
            if(_loc13_)
            {
               _loc15_ = _loc10_.current != null;
               if(SettingsConfigHelper.TYPE_CHECKBOX == _loc11_)
               {
                  this.prepareCheckbox(CheckBox(_loc13_),_loc9_,_loc15_,_loc10_);
               }
               else if(SettingsConfigHelper.TYPE_SLIDER == _loc11_)
               {
                  this.prepareSlider(Slider(_loc13_),_loc9_,_loc15_,_loc10_);
               }
               else if(SettingsConfigHelper.TYPE_DROPDOWN == _loc11_)
               {
                  if(_loc9_ == SettingsConfigHelper.BULB_VOICES)
                  {
                     this._existsBulbVoices = _loc10_.extraData as Array;
                     App.utils.asserter.assertNotNull(this._existsBulbVoices,BULB_VOICES_NULL_ERROR + Errors.CANT_NULL);
                  }
                  else if(_loc9_ == SettingsConfigHelper.ARTY_BULB_VOICES)
                  {
                     this._existsArtyBulbVoices = _loc10_.extraData as Array;
                     App.utils.asserter.assertNotNull(this._existsArtyBulbVoices,ARTY_BULB_VOICES_NULL_ERROR + Errors.CANT_NULL);
                  }
                  this.prepareDropdown(DropdownMenu(_loc13_),_loc15_,_loc10_);
               }
               else if(SettingsConfigHelper.TYPE_KEYINPUT == _loc11_)
               {
                  _loc16_ = KeyInput(_loc13_);
                  _loc16_.key = Number(_loc10_.current);
                  _loc16_.validateNow();
               }
               else if(SettingsConfigHelper.TYPE_BUTTON_BAR == _loc11_)
               {
                  this.prepareButtonBar(ButtonBarEx(_loc13_),_loc9_,_loc15_,_loc10_);
               }
               trySetLabel(_loc9_);
            }
            else if(!_loc10_.readOnly)
            {
               App.utils.asserter.assert(false,_loc12_ + Errors.WASNT_FOUND);
            }
            _loc14_++;
         }
         this.updateMasterVolumeEnabled();
         this.updateVoiceChatEnabled();
      }
      
      override protected function onDispose() : void
      {
         this.breakSoundCheck();
         this.forceFinishVivoxTest();
         btnCaptureDevicesUpdate.removeEventListener(ButtonEvent.CLICK,this.onBtnCaptureDevicesUpdateClickHandler);
         soundSpeakersTestButton.removeEventListener(ButtonEvent.CLICK,this.onSoundSpeakersTestButtonClickHandler);
         btnVivoxTest.removeEventListener(ButtonEvent.CLICK,this.onBtnVivoxTestClickHandler);
         testAlternativeVoicesButton.removeEventListener(ButtonEvent.CLICK,this.onTestAlternativeVoicesButtonClickHandler);
         testAlternativeVoicesButton.removeEventListener(MouseEvent.MOUSE_OVER,this.onTestAlternativeVoicesButtonMouseOverHandler);
         testAlternativeVoicesButton.removeEventListener(MouseEvent.MOUSE_OUT,this.onTestAlternativeVoicesButtonMouseOutHandler);
         bulbVoicesButton.removeEventListener(ButtonEvent.CLICK,this.onTestBulbVoicesButtonClickHandler);
         bulbVoicesButton.removeEventListener(MouseEvent.MOUSE_OVER,this.onTestBulbVoicesButtonMouseOverHandler);
         bulbVoicesButton.removeEventListener(MouseEvent.MOUSE_OUT,this.onTestBulbVoicesButtonMouseOutHandler);
         artyBulbVoicesButton.removeEventListener(ButtonEvent.CLICK,this.onArtyBulbVoicesButtonClickHandler);
         artyBulbVoicesButton.removeEventListener(MouseEvent.MOUSE_OVER,this.onArtyBulbVoicesButtonMouseOverHandler);
         artyBulbVoicesButton.removeEventListener(MouseEvent.MOUSE_OUT,this.onArtyBulbVoicesButtonMouseOutHandler);
         PTTKeyInput.removeEventListener(KeyInputEvents.DISABLE_OVER,this.onPTTKeyInputDisableOverHandler);
         PTTKeyInput.removeEventListener(KeyInputEvents.DISABLE_OUT,this.onPTTKeyInputDisableOutHandler);
         PTTKeyInput.removeEventListener(KeyInputEvents.DISABLE_PRESS,this.onPTTKeyInputDisablePressHandler);
         PTTKeyInput.removeEventListener(KeyInputEvents.CHANGE,this.onPTTKeyInputChangeHandler);
         this.controlsUnsubscribe();
         this._toolTipMgr = null;
         this._existsBulbVoices = null;
         this._existsArtyBulbVoices = null;
         tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabsIndexChangeHandler);
         super.onDispose();
      }
      
      public function breakSoundCheck() : void
      {
         if(this._isVoiceTestStarted)
         {
            dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_VIVOX_TEST,viewId,null,Values.EMPTY_STR,false));
         }
      }
      
      public function getHitArea() : DisplayObject
      {
         return soundSpeakersTestButton;
      }
      
      public function getTargetButton() : DisplayObject
      {
         return soundSpeakersTestButton;
      }
      
      public function isCanSelectAcousticType(param1:Boolean) : void
      {
         if(param1)
         {
            this.applyNewSoundSpeakers(soundSpeakersDropDown.selectedIndex);
            soundDeviceAlert.visible = this._isAcousticsAlertVisible = !param1;
         }
      }
      
      public function isPresetApply(param1:Boolean) : void
      {
         var _loc2_:SettingsControlProp = null;
         if(param1)
         {
            this.applyNewSoundSpeakers(soundSpeakersDropDown.selectedIndex);
            soundDeviceAlert.visible = this._isAcousticsAlertVisible = true;
         }
         else
         {
            _loc2_ = SettingsControlProp(data[SettingsConfigHelper.SOUND_SPEAKERS]);
            soundSpeakersDropDown.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropdownIndexChangeHandler);
            soundSpeakersDropDown.selectedIndex = Number(_loc2_.changedVal);
            soundSpeakersDropDown.addEventListener(ListEvent.INDEX_CHANGE,this.onDropdownIndexChangeHandler);
         }
      }
      
      public function onViewChanged() : void
      {
         this.breakSoundCheck();
      }
      
      public function setCaptureDevices(param1:Number, param2:DataProvider) : void
      {
         captureDeviceDropDown.dataProvider = param2;
         captureDeviceDropDown.selectedIndex = param1;
         var _loc3_:String = SettingsConfigHelper.instance.getControlIdByControlNameAndType(captureDeviceDropDown.name,SettingsConfigHelper.TYPE_DROPDOWN);
         var _loc4_:SettingsControlProp = SettingsControlProp(data[_loc3_]);
         if(param2.length != _loc4_.options.length)
         {
            _loc4_.current = -1;
         }
         _loc4_.options = param2;
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,_loc3_,param1));
         this.updateVoiceChatEnabled();
      }
      
      public function setVoiceTestState(param1:Boolean) : void
      {
         if(this._isVoiceTestStarted == param1)
         {
            return;
         }
         this._isVoiceTestStarted = param1;
         voiceAnimation.speak(this._isVoiceTestStarted);
         btnVivoxTest.enabled = btnCaptureDevicesUpdate.enabled = !this._isVoiceTestStarted;
         if(this._isVoiceTestStarted)
         {
            this._vivoxTestTimeLeft = VOICE_TEST_DURATION;
            App.utils.scheduler.scheduleRepeatableTask(this.voiceTimerTest,VOICE_TEST_UPDATE_RATE * Time.MILLISECOND_IN_SECOND,VOICE_TEST_DURATION / VOICE_TEST_UPDATE_RATE + 1);
         }
         else
         {
            this.forceFinishVivoxTest();
         }
      }
      
      public function updateAcousticDeviceByType(param1:String) : void
      {
         var _loc2_:IDataProvider = soundSpeakersDropDown.dataProvider;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc2_.requestItemAt(_loc4_);
            if(_loc5_.hasOwnProperty(SettingsConfigHelper.SOUND_SPEAKERS_ID_FIELD) && _loc5_[SettingsConfigHelper.SOUND_SPEAKERS_ID_FIELD] == param1)
            {
               this.updateAcousticDeviceLabel(_loc5_);
               soundSpeakersTestButton.enabled = true;
               break;
            }
            _loc4_++;
         }
      }
      
      public function updatePTTControl(param1:Number) : void
      {
         PTTKeyInput.key = param1;
      }
      
      private function updatesPttKeyList() : void
      {
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc11_:Object = null;
         var _loc1_:SettingsConfigHelper = SettingsConfigHelper.instance;
         var _loc2_:SettingsDataVo = _loc1_.getDataItem(SettingsConfigHelper.CONTROLS_SETTINGS,true);
         var _loc3_:SettingsDataVo = SettingsDataVo(_loc2_.getByKey(SettingsConfigHelper.KEYBOARD));
         var _loc4_:Vector.<Object> = _loc3_.values;
         var _loc5_:Array = this.copyItemsInUpperCase(SettingsConfigHelper.pttKeyRange);
         var _loc8_:IUtils = App.utils;
         var _loc9_:ICommons = _loc8_.commons;
         var _loc10_:String = _loc8_.toUpperOrLowerCase(_loc9_.keyToString(PTTKeyInput.key).keyCommand,true);
         for each(_loc11_ in _loc4_)
         {
            _loc7_ = _loc8_.toUpperOrLowerCase(_loc9_.keyToString(SettingsKeyProp(_loc11_).key).keyCommand,true);
            if(_loc7_ != _loc10_)
            {
               _loc6_ = _loc5_.indexOf(_loc8_.toUpperOrLowerCase(_loc7_,true));
               if(_loc6_ >= 0)
               {
                  _loc5_.splice(_loc6_,1);
               }
            }
         }
         PTTKeyInput.keys = _loc5_;
      }
      
      private function copyItemsInUpperCase(param1:Array) : Array
      {
         var _loc3_:String = null;
         var _loc2_:Array = [];
         for each(_loc3_ in param1)
         {
            _loc2_.push(App.utils.toUpperOrLowerCase(_loc3_,true));
         }
         return _loc2_;
      }
      
      private function controlsUnsubscribe() : void
      {
         var _loc1_:String = null;
         var _loc2_:IEventDispatcher = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         if(data && data.keys)
         {
            _loc3_ = data.keys.length;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc1_ = data.keys[_loc5_];
               _loc4_ = SettingsControlProp(data.values[_loc5_]).type;
               _loc2_ = this[_loc1_ + _loc4_] as IEventDispatcher;
               if(_loc2_)
               {
                  if(_loc4_ == SettingsConfigHelper.TYPE_CHECKBOX)
                  {
                     _loc2_.removeEventListener(Event.SELECT,this.onCheckboxSelectHandler);
                  }
                  else if(_loc4_ == SettingsConfigHelper.TYPE_SLIDER)
                  {
                     _loc2_.removeEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChangeHandler);
                  }
                  else if(_loc4_ == SettingsConfigHelper.TYPE_DROPDOWN)
                  {
                     _loc2_.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropdownIndexChangeHandler);
                  }
                  else if(_loc4_ == SettingsConfigHelper.TYPE_BUTTON_BAR)
                  {
                     _loc2_.removeEventListener(IndexEvent.INDEX_CHANGE,this.onButtonBarIndexChangeHandler);
                  }
               }
               _loc5_++;
            }
         }
      }
      
      private function prepareButtonBar(param1:ButtonBarEx, param2:String, param3:Boolean, param4:SettingsControlProp) : void
      {
         param1.dataProvider = new DataProvider(param4.options);
         param1.selectedIndex = int(param4.current);
         param1.addEventListener(IndexEvent.INDEX_CHANGE,this.onButtonBarIndexChangeHandler);
         param1.enabled = param3;
         if(param2 == SettingsConfigHelper.SOUND_DEVICE)
         {
            this.updateSoundSpeakersDependencies(param1.selectedIndex,true);
         }
      }
      
      private function prepareDropdown(param1:DropdownMenu, param2:Boolean, param3:SettingsControlProp) : void
      {
         param1.dataProvider = new DataProvider(param3.options);
         param1.selectedIndex = int(param3.current);
         param1.addEventListener(ListEvent.INDEX_CHANGE,this.onDropdownIndexChangeHandler);
         param1.enabled = param2;
      }
      
      private function prepareSlider(param1:Slider, param2:String, param3:Boolean, param4:SettingsControlProp) : void
      {
         param1.value = Number(param4.current);
         param1.addEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChangeHandler);
         var _loc5_:LabelControl = this[param2 + SettingsConfigHelper.TYPE_VALUE] as LabelControl;
         if(_loc5_ && param4.hasValue)
         {
            _loc5_.text = param4.current.toString();
         }
         param1.enabled = param3;
      }
      
      private function prepareCheckbox(param1:CheckBox, param2:String, param3:Boolean, param4:SettingsControlProp) : void
      {
         var _loc5_:Boolean = false;
         param1.selected = param4.current;
         param1.addEventListener(Event.SELECT,this.onCheckboxSelectHandler);
         if(param2 == SettingsConfigHelper.ENABLE_VO_IP)
         {
            param1.enabled = param3 && SettingsControlProp(data[SettingsConfigHelper.VOICE_CHAT_SUPPORTED]).current;
         }
         else if(param2 == SettingsConfigHelper.MASTER_VOLUME_TOGGLE)
         {
            param1.infoIcoType = !!param1.selected ? Values.EMPTY_STR : InfoIcon.TYPE_WARNING;
            param1.toolTip = !!param1.selected ? Values.EMPTY_STR : TOOLTIPS.MASTERVOLUMETOGGLEOFF;
         }
         else if(param2 == SettingsConfigHelper.SOUND_QUALITY)
         {
            param1.visible = SettingsControlProp(data[SettingsConfigHelper.SOUND_QUALITY_VISIBLE]).current;
            _loc5_ = param1.selected && param1.visible;
            param1.infoIcoType = !!_loc5_ ? InfoIcon.TYPE_WARNING : Values.EMPTY_STR;
            param1.toolTip = !!_loc5_ ? TOOLTIPS.SOUNDQUALITYON : Values.EMPTY_STR;
            if(param1.visible)
            {
               param1.enabled = param3 && SettingsControlProp(data[SettingsConfigHelper.MASTER_VOLUME_TOGGLE]).current;
            }
         }
         else
         {
            param1.enabled = param3;
         }
      }
      
      private function voiceTimerTest() : void
      {
         this._vivoxTestTimeLeft -= VOICE_TEST_UPDATE_RATE;
         if(this._vivoxTestTimeLeft > 0)
         {
            voiceAnimationText.text = this._vivoxTestTimeLeft.toFixed(1);
         }
         else
         {
            dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_VIVOX_TEST,viewId,null,Values.EMPTY_STR,false));
         }
      }
      
      private function forceFinishVivoxTest() : void
      {
         App.utils.scheduler.cancelTask(this.voiceTimerTest);
         this._vivoxTestTimeLeft = 0;
         voiceAnimationText.text = Values.EMPTY_STR;
         btnVivoxTest.enabled = btnCaptureDevicesUpdate.enabled = !this._isVoiceTestStarted;
         voiceAnimation.speak(this._isVoiceTestStarted);
      }
      
      private function updateMasterVolumeEnabled() : void
      {
         this._masterVolumeSelected = masterVolumeToggleCheckbox.selected;
         masterVolumeToggleCheckbox.infoIcoType = !!this._masterVolumeSelected ? Values.EMPTY_STR : InfoIcon.TYPE_WARNING;
         masterVolumeToggleCheckbox.toolTip = !!this._masterVolumeSelected ? Values.EMPTY_STR : TOOLTIPS.MASTERVOLUMETOGGLEOFF;
         masterVolumeLabel.enabled = this._masterVolumeSelected;
         masterVolumeSlider.enabled = this._masterVolumeSelected;
         masterVolumeValue.enabled = this._masterVolumeSelected;
         guiVolumeLabel.enabled = this._masterVolumeSelected;
         guiVolumeSlider.enabled = this._masterVolumeSelected;
         guiVolumeValue.enabled = this._masterVolumeSelected;
         vehiclesVolumeLabel.enabled = this._masterVolumeSelected;
         vehiclesVolumeSlider.enabled = this._masterVolumeSelected;
         vehiclesVolumeValue.enabled = this._masterVolumeSelected;
         voiceNotificationVolumeLabel.enabled = this._masterVolumeSelected;
         voiceNotificationVolumeSlider.enabled = this._masterVolumeSelected;
         voiceNotificationVolumeValue.enabled = this._masterVolumeSelected;
         effectsVolumeLabel.enabled = this._masterVolumeSelected;
         effectsVolumeSlider.enabled = this._masterVolumeSelected;
         effectsVolumeValue.enabled = this._masterVolumeSelected;
         ambientVolumeLabel.enabled = this._masterVolumeSelected;
         ambientVolumeSlider.enabled = this._masterVolumeSelected;
         ambientVolumeValue.enabled = this._masterVolumeSelected;
         musicVolumeLabel.enabled = this._masterVolumeSelected;
         musicVolumeSlider.enabled = this._masterVolumeSelected;
         musicVolumeValue.enabled = this._masterVolumeSelected;
         musicHangarLabel.enabled = this._masterVolumeSelected;
         musicHangarSlider.enabled = this._masterVolumeSelected;
         musicHangarValue.enabled = this._masterVolumeSelected;
         if(soundDeviceButtonBar != null)
         {
            soundDeviceButtonBar.enabled = this._masterVolumeSelected;
         }
         bassBoostCheckbox.enabled = this._masterVolumeSelected;
         nightModeCheckbox.enabled = this._masterVolumeSelected;
         testAlternativeVoicesButton.enabled = this._masterVolumeSelected;
         commonForm.bulbIcon.alpha = !!this._masterVolumeSelected ? Number(ENABLE_ALPHA) : Number(DISABLE_ALPHA);
         bulbVoicesLabel.enabled = this._masterVolumeSelected;
         bulbVoicesDropDown.enabled = this._masterVolumeSelected;
         bulbVoicesButton.enabled = this._masterVolumeSelected && this._existsBulbVoices[bulbVoicesDropDown.selectedIndex];
         commonForm.bulbIcon.enabled = this._masterVolumeSelected;
         artyBulbVoicesIcon.alpha = !!this._masterVolumeSelected ? Number(ENABLE_ALPHA) : Number(DISABLE_ALPHA);
         artyBulbVoicesIcon.enabled = this._masterVolumeSelected;
         artyBulbVoicesLabel.enabled = this._masterVolumeSelected;
         artyBulbVoicesDropDown.enabled = this._masterVolumeSelected;
         artyBulbVoicesButton.enabled = this._masterVolumeSelected && this._existsArtyBulbVoices[artyBulbVoicesDropDown.selectedIndex];
         commonForm.alternativeVoicesIcon.alpha = !!this._masterVolumeSelected ? Number(ENABLE_ALPHA) : Number(DISABLE_ALPHA);
         commonForm.alternativeVoicesIcon.enabled = this._masterVolumeSelected;
         alternativeVoicesDropDown.enabled = this._masterVolumeSelected;
         alternativeVoicesLabel.enabled = this._masterVolumeSelected;
         soundQualityCheckbox.enabled = this._masterVolumeSelected;
         subtitlesCheckbox.enabled = this._masterVolumeSelected;
         soundSpeakersTestButton.enabled = this._masterVolumeSelected;
         this.updateSoundSpeakersDropDown();
      }
      
      private function updateVoiceChatEnabled() : void
      {
         this.breakSoundCheck();
         var _loc1_:Boolean = enableVoIPCheckbox.selected && SettingsControlProp(data[SettingsConfigHelper.VOICE_CHAT_SUPPORTED]).current;
         btnCaptureDevicesUpdate.enabled = _loc1_;
         masterVivoxVolumeLabel.enabled = _loc1_;
         masterVivoxVolumeSlider.enabled = _loc1_;
         masterFadeVivoxVolumeLabel.enabled = _loc1_;
         masterFadeVivoxVolumeSlider.enabled = _loc1_;
         var _loc2_:Boolean = _loc1_ && captureDeviceDropDown.dataProvider.length > 0;
         captureDeviceLabel.enabled = _loc2_;
         captureDeviceDropDown.enabled = _loc2_;
         micVivoxVolumeLabel.enabled = _loc2_;
         micVivoxVolumeSlider.enabled = _loc2_;
         btnVivoxTest.enabled = _loc2_;
         micVivoxVolumeValue.enabled = _loc1_;
         masterFadeVivoxVolumeValue.enabled = _loc1_;
         masterVivoxVolumeValue.enabled = _loc1_;
      }
      
      private function showHideVoiceSettings(param1:Boolean) : void
      {
         voiceConnectFieldSet.visible = param1;
         PTTLabel.visible = param1;
         PTTKeyInput.visible = param1;
         captureDeviceLabel.visible = param1;
         captureDeviceDropDown.visible = param1;
         btnCaptureDevicesUpdate.visible = param1;
         btnVivoxTest.visible = param1;
         voiceAnimation.visible = param1;
         voiceAnimationText.text = !!param1 ? voiceAnimationText.text : Values.EMPTY_STR;
         masterVivoxVolumeLabel.visible = param1;
         masterVivoxVolumeSlider.visible = param1;
         masterVivoxVolumeValue.visible = param1;
         micVivoxVolumeLabel.visible = param1;
         micVivoxVolumeSlider.visible = param1;
         micVivoxVolumeValue.visible = param1;
         masterFadeVivoxVolumeLabel.visible = param1;
         masterFadeVivoxVolumeSlider.visible = param1;
         masterFadeVivoxVolumeValue.visible = param1;
      }
      
      private function hideTooltip() : void
      {
         this._toolTipMgr.hide();
      }
      
      private function updateAcousticDeviceLabel(param1:Object) : void
      {
         if(param1 && param1.hasOwnProperty(SettingsConfigHelper.SOUND_SPEAKERS_TOOLTIP_FIELD) && param1.hasOwnProperty(SettingsConfigHelper.SOUND_SPEAKERS_ID_FIELD))
         {
            this.updateSoundDeviceLabel(ACOUSTICS.TYPE_ACOUSTICS,param1[SettingsConfigHelper.SOUND_SPEAKERS_TOOLTIP_FIELD],param1[SettingsConfigHelper.SOUND_SPEAKERS_ID_FIELD]);
         }
      }
      
      private function updateSoundDeviceLabel(param1:String, param2:String, param3:String) : void
      {
         soundDeviceButtonBar.updateDataById(param1,param2,param3);
      }
      
      private function applyNewSoundSpeakers(param1:Number) : void
      {
         var _loc2_:SettingsControlProp = SettingsControlProp(data[SettingsConfigHelper.SOUND_SPEAKERS]);
         _loc2_.changedVal = param1;
         var _loc3_:Object = _loc2_.options[param1];
         this.updateAcousticDeviceLabel(_loc3_);
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,SettingsConfigHelper.SOUND_SPEAKERS,param1));
      }
      
      private function updateSoundSpeakersDependencies(param1:Number, param2:Boolean) : void
      {
         var _loc3_:SettingsControlProp = SettingsControlProp(data[SettingsConfigHelper.SOUND_DEVICE]);
         var _loc4_:String = _loc3_.options[param1][SettingsConfigHelper.SOUND_DEVICE_ID_FIELD];
         this._typeAcousticsSelected = _loc4_ == ACOUSTICS.TYPE_ACOUSTICS;
         this.updateSoundSpeakersDropDown();
         if(this._typeAcousticsSelected)
         {
            if(param2)
            {
               this._isAcousticsAlertVisible = _loc3_.options[param1][SettingsConfigHelper.SOUND_DEVICE_ALERT_FIELD];
            }
            soundDeviceAlert.visible = this._isAcousticsAlertVisible;
         }
         else
         {
            soundDeviceAlert.visible = _loc3_.options[param1][SettingsConfigHelper.SOUND_DEVICE_ALERT_FIELD];
         }
      }
      
      private function updateSoundSpeakersDropDown() : void
      {
         soundSpeakersDropDown.enabled = this._masterVolumeSelected && this._typeAcousticsSelected;
      }
      
      private function onBtnVivoxTestClickHandler(param1:ButtonEvent) : void
      {
         if(this._isVoiceTestStarted)
         {
            return;
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_VIVOX_TEST,viewId,null,Values.EMPTY_STR,true));
      }
      
      private function onPTTKeyInputDisablePressHandler(param1:KeyInputEvents) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onPTTKeyInputDisableOutHandler(param1:KeyInputEvents) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onPTTKeyInputChangeHandler(param1:KeyInputEvents) : void
      {
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,SettingsConfigHelper.CONTROLS_SETTINGS,SettingsConfigHelper.KEYBOARD,SettingsConfigHelper.PUSH_TO_TALK,param1.keyCode));
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_PTT_SOUND_CONTROL_CHANGED,SettingsConfigHelper.CONTROLS_SETTINGS,SettingsConfigHelper.KEYBOARD,SettingsConfigHelper.PUSH_TO_TALK,param1.keyCode));
      }
      
      private function onPTTKeyInputDisableOverHandler(param1:KeyInputEvents) : void
      {
         this._toolTipMgr.showComplex(TOOLTIPS.SETTINGS_DIALOG_SOUND_PTTKEY,null);
      }
      
      private function onTestAlternativeVoicesButtonMouseOutHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
      
      private function onTestAlternativeVoicesButtonMouseOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(TOOLTIPS.SETTINGS_DIALOG_SOUND_ALTERNATIVEVOICES);
      }
      
      private function onTestAlternativeVoicesButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new AlternativeVoiceEvent(AlternativeVoiceEvent.ON_TEST_ALTERNATIVE_VOICES));
      }
      
      private function onTestBulbVoicesButtonMouseOutHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
      
      private function onTestBulbVoicesButtonMouseOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(TOOLTIPS.SETTINGS_DIALOG_SOUND_ALTERNATIVEVOICES);
      }
      
      private function onTestBulbVoicesButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new AlternativeVoiceEvent(AlternativeVoiceEvent.ON_TEST_BULB_VOICES,bulbVoicesDropDown.selectedIndex));
      }
      
      private function onArtyBulbVoicesButtonMouseOutHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
      
      private function onArtyBulbVoicesButtonMouseOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(TOOLTIPS.SETTINGS_DIALOG_SOUND_ALTERNATIVEVOICES);
      }
      
      private function onArtyBulbVoicesButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new AlternativeVoiceEvent(AlternativeVoiceEvent.ON_TEST_ARTY_BULB_VOICES,artyBulbVoicesDropDown.selectedIndex));
      }
      
      private function onBtnCaptureDevicesUpdateClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_UPDATE_CAPTURE_DEVICE,viewId));
      }
      
      private function onSoundSpeakersTestButtonClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:SoundDeviceTabButton = SoundDeviceTabButton(soundDeviceButtonBar.selectedButton);
         App.popoverMgr.show(this,Aliases.ACOUSTIC_POPOVER,_loc2_.speakerId);
      }
      
      private function onCheckboxSelectHandler(param1:Event) : void
      {
         var _loc2_:CheckBox = CheckBox(param1.target);
         var _loc3_:String = SettingsConfigHelper.instance.getControlIdByControlNameAndType(_loc2_.name,SettingsConfigHelper.TYPE_CHECKBOX);
         if(_loc3_ == SettingsConfigHelper.ENABLE_VO_IP)
         {
            this.updateVoiceChatEnabled();
         }
         else if(_loc3_ == SettingsConfigHelper.MASTER_VOLUME_TOGGLE)
         {
            this.updateMasterVolumeEnabled();
         }
         else if(_loc3_ == SettingsConfigHelper.SOUND_QUALITY)
         {
            _loc2_.toolTip = _loc2_.selected && _loc2_.visible ? TOOLTIPS.SOUNDQUALITYON : Values.EMPTY_STR;
            _loc2_.infoIcoType = _loc2_.selected && _loc2_.visible ? InfoIcon.TYPE_WARNING : Values.EMPTY_STR;
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,_loc3_,_loc2_.selected));
      }
      
      private function onSliderValueChangeHandler(param1:SliderEvent) : void
      {
         var _loc2_:Slider = Slider(param1.target);
         var _loc3_:String = SettingsConfigHelper.instance.getControlIdByControlNameAndType(_loc2_.name,SettingsConfigHelper.TYPE_SLIDER);
         var _loc4_:SettingsControlProp = SettingsControlProp(data[_loc3_]);
         var _loc5_:LabelControl = this[_loc3_ + SettingsConfigHelper.TYPE_VALUE] as LabelControl;
         if(_loc5_ && _loc4_.hasValue)
         {
            _loc5_.text = _loc2_.value.toString();
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,_loc3_,_loc2_.value));
      }
      
      private function onDropdownIndexChangeHandler(param1:ListEvent) : void
      {
         var _loc4_:SettingsControlProp = null;
         var _loc5_:Object = null;
         var _loc6_:Boolean = false;
         var _loc2_:DropdownMenu = DropdownMenu(param1.target);
         var _loc3_:String = SettingsConfigHelper.instance.getControlIdByControlNameAndType(_loc2_.name,SettingsConfigHelper.TYPE_DROPDOWN);
         if(_loc3_ == SettingsConfigHelper.BULB_VOICES)
         {
            bulbVoicesButton.enabled = this._existsBulbVoices[bulbVoicesDropDown.selectedIndex];
         }
         else if(_loc3_ == SettingsConfigHelper.ARTY_BULB_VOICES)
         {
            artyBulbVoicesButton.enabled = this._existsArtyBulbVoices[artyBulbVoicesDropDown.selectedIndex];
         }
         if(_loc3_ == SettingsConfigHelper.SOUND_SPEAKERS)
         {
            _loc4_ = SettingsControlProp(data[SettingsConfigHelper.SOUND_SPEAKERS]);
            _loc5_ = _loc4_.options[_loc2_.selectedIndex];
            _loc6_ = _loc5_[SettingsConfigHelper.SOUND_SPEAKERS_IS_AUTODETECT_FIELD];
            if(_loc6_)
            {
               soundSpeakersTestButton.enabled = false;
               soundDeviceButtonBar.updateDataById(ACOUSTICS.TYPE_ACOUSTICS,Values.EMPTY_STR,Values.EMPTY_STR);
               dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_AUTO_DETECT_ACOUSTIC,viewId));
               dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,_loc3_,_loc2_.selectedIndex));
               _loc4_.changedVal = _loc2_.selectedIndex;
               soundDeviceAlert.visible = this._isAcousticsAlertVisible = false;
            }
            else
            {
               dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_SOUND_SPEAKER_CHANGE,viewId,null,_loc3_,_loc2_.selectedIndex));
            }
         }
         else
         {
            dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,_loc3_,_loc2_.selectedIndex));
         }
      }
      
      private function onButtonBarIndexChangeHandler(param1:IndexEvent) : void
      {
         var _loc2_:ButtonBarEx = ButtonBarEx(param1.target);
         var _loc3_:String = SettingsConfigHelper.instance.getControlIdByControlNameAndType(_loc2_.name,SettingsConfigHelper.TYPE_BUTTON_BAR);
         if(_loc3_ == SettingsConfigHelper.SOUND_DEVICE)
         {
            this.updateSoundSpeakersDependencies(_loc2_.selectedIndex,false);
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,_loc3_,_loc2_.selectedIndex));
      }
      
      private function onTabsIndexChangeHandler(param1:IndexEvent) : void
      {
         commonForm.visible = false;
         vivoxForm.visible = false;
         specialForm.visible = false;
         switch(param1.index)
         {
            case COMMON_TAB_INDEX:
               commonForm.visible = true;
               break;
            case VIVOX_TAB_INDEX:
               vivoxForm.visible = true;
               break;
            case SPECIAL_TAB_INDEX:
               specialForm.visible = true;
         }
      }
   }
}
