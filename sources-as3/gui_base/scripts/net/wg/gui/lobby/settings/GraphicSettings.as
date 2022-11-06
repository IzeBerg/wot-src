package net.wg.gui.lobby.settings
{
   import flash.events.Event;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.RangeSlider;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.settings.components.RadioButtonBar;
   import net.wg.gui.lobby.settings.components.SettingsStepSlider;
   import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
   import net.wg.gui.lobby.settings.events.SettingViewEvent;
   import net.wg.gui.lobby.settings.vo.ColorFilerSettingsVo;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterProps;
   import net.wg.utils.IDataUtils;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.events.SliderEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class GraphicSettings extends GraphicSettingsBase
   {
      
      private static const CURRENT_STR:String = "current";
      
      private static const DATA_STR:String = "data";
      
      private static const SUPPORTED_STR:String = "supported";
      
      private static const POSTFIX_STR:String = "%";
      
      private static const OPTIONS_STR:String = "options";
      
      private static const CONTROL_ERROR_MESSAGE:String = "ERROR can\'t find control:";
      
      private static const SET_DATA_ISSUE_MESSAGE:String = "TRY SET DATA USE PRESET FOR CONTROL:";
      
      private static const HIGH_QUALITY:Vector.<String> = Vector.<String>(["ULTRA","MAX"]);
      
      private static const SD:String = "_SD";
      
      private static const GRAPHIC_COUNTER_CONTAINER_ID:String = "GRAPHIC_COUNTER_CONTAINER_ID";
      
      private static const TABS_COUNTERS_PROPS:CounterProps = new CounterProps(CounterProps.DEFAULT_OFFSET_X,4);
      
      private static const VALUE_TESSELLATION_SUPPORTED:int = 3;
      
      private static const SCREEN_SETTINGS:String = "ScreenSettings";
      
      private static const ADVANCED_GRAPHIC_SETTINGS:String = "AdvancedGraphicSettings";
       
      
      private var _graphicsQualityDataProv:Object = null;
      
      private var _qualityOrderIdList:Vector.<String> = null;
      
      private var _isCustomPreset:Boolean = false;
      
      private var _onlyPresetsDP:Array;
      
      private var _presetsWithCustomDP:Array;
      
      private var _isAdvanced:Boolean = false;
      
      private var _presets:SettingsDataVo = null;
      
      private var _isInited:Boolean = false;
      
      private var _allowCheckPreset:Boolean = true;
      
      private var _extendAdvancedControls:Object;
      
      private var _extendAdvancedControlsIds:Vector.<String>;
      
      private var _skipIdList:Vector.<String>;
      
      private var _skipSetEnableIdList:Vector.<String>;
      
      private var _skipDispatchPresetEvent:Boolean = false;
      
      private var _initialFOVValues:Array = null;
      
      private var _isSDQuality:Boolean = true;
      
      private var _showSDQualityWarning:Boolean = false;
      
      private var _settingsConfigHelper:SettingsConfigHelper;
      
      private const _imaginaryIdList:Vector.<String> = Vector.<String>([SettingsConfigHelper.WINDOW_SIZE,SettingsConfigHelper.RESOLUTION,SettingsConfigHelper.BORDERLESS_SIZE,SettingsConfigHelper.PRESETS,SettingsConfigHelper.QUALITY_ORDER,SettingsConfigHelper.NATIVE_RESOLUTION,SettingsConfigHelper.TESSELLATION_SUPPORTED,SettingsConfigHelper.IS_SD_QUALITY]);
      
      public function GraphicSettings()
      {
         this._onlyPresetsDP = [];
         this._presetsWithCustomDP = [];
         this._extendAdvancedControlsIds = Vector.<String>([SettingsConfigHelper.COLOR_GRADING_TECHNIQUE]);
         this._settingsConfigHelper = SettingsConfigHelper.instance;
         super();
      }
      
      override public function toString() : String
      {
         return "[WG GraphicSettings " + name + "]";
      }
      
      override public function update(param1:Object) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         this._graphicsQualityDataProv = {};
         var _loc2_:Object = param1.data;
         this._qualityOrderIdList = _loc2_.qualityOrder;
         if(this._qualityOrderIdList is Vector.<String>)
         {
            _loc3_ = this._qualityOrderIdList.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = this._qualityOrderIdList[_loc4_];
               if(_loc2_[_loc5_] != undefined)
               {
                  this._graphicsQualityDataProv[_loc5_] = SettingsControlProp(_loc2_[_loc5_]).clone();
               }
               _loc4_++;
            }
         }
         this._presets = param1.data.presets;
         super.update(param1);
      }
      
      override public function updateDependentData() : void
      {
         var _loc1_:ColorFilerSettingsVo = this._settingsConfigHelper.liveUpdateColorFilterData;
         if(_loc1_.colorFilterChanged)
         {
            colorFilterNameLabel.htmlText = _loc1_.colorFilterName;
            colorFilterImage.source = _loc1_.colorFilterImage;
            _loc1_.colorFilterChanged = false;
            return;
         }
         if(this._isInited && this._settingsConfigHelper.liveUpdateVideoSettingsData)
         {
            this.initMonitors();
            this.updateLiveVideoData();
         }
      }
      
      override protected function getContainerId() : String
      {
         return GRAPHIC_COUNTER_CONTAINER_ID;
      }
      
      override protected function onDispose() : void
      {
         var _loc3_:CheckBox = null;
         var _loc4_:Slider = null;
         var _loc5_:Slider = null;
         var _loc6_:DropdownMenu = null;
         var _loc7_:SettingsControlProp = null;
         var _loc8_:int = 0;
         var _loc9_:* = null;
         var _loc10_:int = 0;
         if(data)
         {
            _loc3_ = null;
            _loc4_ = null;
            _loc5_ = null;
            _loc6_ = null;
            _loc7_ = null;
            _loc8_ = data.keys.length;
            _loc9_ = Values.EMPTY_STR;
            _loc10_ = 0;
            for(; _loc10_ < _loc8_; _loc10_++)
            {
               _loc9_ = data.keys[_loc10_];
               if(this._skipIdList.indexOf(_loc9_) >= 0)
               {
                  continue;
               }
               _loc7_ = SettingsControlProp(data.values[_loc10_]);
               switch(_loc7_.type)
               {
                  case SettingsConfigHelper.TYPE_CHECKBOX:
                     _loc3_ = this[_loc9_ + _loc7_.type];
                     _loc3_.removeEventListener(Event.SELECT,this.onCheckBoxSelectHandler);
                     break;
                  case SettingsConfigHelper.TYPE_SLIDER:
                     _loc4_ = this[_loc9_ + _loc7_.type];
                     _loc4_.removeEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChangeHandler);
                     break;
                  case SettingsConfigHelper.TYPE_RANGE_SLIDER:
                     _loc5_ = this[_loc9_ + _loc7_.type];
                     _loc5_.removeEventListener(SliderEvent.VALUE_CHANGE,this.onRangeSliderValueChangeHandler);
                     break;
                  case SettingsConfigHelper.TYPE_DROPDOWN:
                     _loc6_ = this[_loc9_ + _loc7_.type];
                     _loc6_.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChangeHandler);
                     break;
               }
            }
         }
         var _loc1_:SettingsStepSlider = null;
         _loc9_ = SettingsConfigHelper.GRAPHIC_QUALITY;
         _loc7_ = SettingsControlProp(data[_loc9_]);
         _loc6_ = this[_loc9_ + _loc7_.type];
         _loc6_.removeEventListener(ListEvent.INDEX_CHANGE,this.onGraphicsQualityIndexChangeHandler);
         _loc9_ = SettingsConfigHelper.RENDER_PIPELINE;
         _loc7_ = SettingsControlProp(data[_loc9_]);
         var _loc2_:RadioButtonBar = this[_loc9_ + _loc7_.type];
         _loc2_.removeEventListener(IndexEvent.INDEX_CHANGE,this.onGraphicsQualityRenderPipelineIndexChangeHandler);
         for(_loc9_ in this._graphicsQualityDataProv)
         {
            if(_loc9_ == SettingsConfigHelper.RENDER_PIPELINE)
            {
               continue;
            }
            _loc7_ = SettingsControlProp(this._graphicsQualityDataProv[_loc9_]);
            switch(_loc7_.type)
            {
               case SettingsConfigHelper.TYPE_CHECKBOX:
                  _loc3_ = this[_loc9_ + _loc7_.type];
                  _loc3_.removeEventListener(Event.SELECT,this.onCheckBoxOrderedSelectHandler);
                  break;
               case SettingsConfigHelper.TYPE_STEP_SLIDER:
                  _loc1_ = this[_loc9_ + _loc7_.type];
                  _loc1_.removeEventListener(SliderEvent.VALUE_CHANGE,this.onSliderOrderedValueChangeHandler);
                  break;
               case SettingsConfigHelper.TYPE_DROPDOWN:
                  _loc6_ = this[_loc9_ + _loc7_.type];
                  _loc6_.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownOrderedIndexChangeHandler);
                  break;
            }
         }
         while(this._graphicsQualityDataProv.length)
         {
            this._graphicsQualityDataProv.pop();
         }
         this._graphicsQualityDataProv = null;
         while(this._extendAdvancedControls.length)
         {
            this._extendAdvancedControls.pop();
         }
         this._extendAdvancedControls = null;
         if(this._onlyPresetsDP)
         {
            this._onlyPresetsDP.splice(0);
            this._onlyPresetsDP = null;
         }
         while(this._skipSetEnableIdList.length)
         {
            this._skipSetEnableIdList.pop();
         }
         this._skipSetEnableIdList = null;
         if(this._presetsWithCustomDP)
         {
            this._presetsWithCustomDP.splice(0);
            this._presetsWithCustomDP = null;
         }
         this._settingsConfigHelper = null;
         App.utils.data.cleanupDynamicObject(this._presets);
         this._presets = null;
         App.utils.data.cleanupDynamicObject(this._skipIdList);
         this._skipIdList = null;
         App.utils.data.cleanupDynamicObject(this._qualityOrderIdList);
         this._qualityOrderIdList = null;
         App.utils.data.cleanupDynamicObject(this._extendAdvancedControlsIds);
         this._extendAdvancedControlsIds = null;
         autodetectQuality.removeEventListener(ButtonEvent.CLICK,this.onAutodetectClickHandler);
         tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabsIndexChangeHandler);
         refreshRateDropDown.removeEventListener(ListEvent.INDEX_CHANGE,this.onRefreshRateDropDownIndexChangeHandler);
         sizesDropDown.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChangeHandler);
         gammaSettingButton.removeEventListener(ButtonEvent.CLICK,this.onGammaBtnClickHandler);
         colorFilterButton.removeEventListener(ButtonEvent.CLICK,this.onColorFilterBtnClickHandler);
         if(interfaceScaleDropDown.visible)
         {
            interfaceScaleDropDown.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChangeHandler);
         }
         this._initialFOVValues = null;
         removeEventListener(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,this.onFormOnControlNewCountersVisitedHandler);
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         graphicsQualityLabel.text = SETTINGS.GRAPHICSQUALITY;
         autodetectQuality.label = SETTINGS.AUTODETECTBUTTON;
         dynamicRendererLabel.text = SETTINGS.DYNAMICRENDERER;
         gammaLabel.toolTip = TOOLTIPS.GAMMA;
         gammaLabel.infoIcoType = InfoIcon.TYPE_INFO;
         colorFilterLabel.toolTip = TOOLTIPS.COLORFILTER;
         colorFilterLabel.infoIcoType = InfoIcon.TYPE_INFO;
         this._skipSetEnableIdList = new Vector.<String>();
         this._skipSetEnableIdList.push(SettingsConfigHelper.REFRESH_RATE);
         tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabsIndexChangeHandler);
         tabs.dataProvider = this._settingsConfigHelper.graphicSettingsTabsDataProvider;
         this.updateCurrentTab();
         autodetectQuality.addEventListener(ButtonEvent.CLICK,this.onAutodetectClickHandler);
         gammaSettingButton.addEventListener(ButtonEvent.CLICK,this.onGammaBtnClickHandler);
         colorFilterButton.addEventListener(ButtonEvent.CLICK,this.onColorFilterBtnClickHandler);
         addEventListener(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,this.onFormOnControlNewCountersVisitedHandler);
      }
      
      override protected function getButtonBar() : ButtonBarEx
      {
         return tabs;
      }
      
      override protected function getButtonBarDP() : IDataProvider
      {
         return SettingsConfigHelper.instance.graphicSettingsTabsDataProvider;
      }
      
      override protected function getCounterProps(param1:String) : ICounterProps
      {
         if(param1 == Linkages.SCREEN_SETTING || param1 == Linkages.ADVANCED_GRAPHIC_SETTINGS)
         {
            return TABS_COUNTERS_PROPS;
         }
         return super.getCounterProps(param1);
      }
      
      override protected function setData(param1:SettingsDataVo) : void
      {
         this.setControlsData(param1);
         super.setData(param1);
      }
      
      override protected function updateDependedControl(param1:String) : void
      {
         var _loc6_:Boolean = false;
         var _loc7_:CheckBox = null;
         var _loc2_:Boolean = Boolean(data[SettingsConfigHelper.TESSELLATION_SUPPORTED].changedVal);
         var _loc3_:SettingsControlProp = null;
         var _loc4_:CheckBox = null;
         var _loc5_:SettingsControlProp = null;
         if(param1 == SettingsConfigHelper.VERTICAL_SYNC)
         {
            _loc3_ = data[param1];
            _loc4_ = this[_loc3_.isDependOn + SettingsConfigHelper.TYPE_CHECKBOX];
            _loc4_.selected = Boolean(_loc3_.changedVal);
         }
         if(param1 == SettingsConfigHelper.TERRAIN_QUALITY)
         {
            _loc3_ = SettingsControlProp(this._graphicsQualityDataProv[param1]);
            _loc5_ = SettingsControlProp(this._graphicsQualityDataProv[_loc3_.isDependOn]);
            _loc4_ = this[_loc3_.isDependOn + SettingsConfigHelper.TYPE_CHECKBOX];
            _loc6_ = _loc3_.changedVal < VALUE_TESSELLATION_SUPPORTED;
            if(!_loc6_)
            {
               _loc4_.selected = false;
            }
            _loc4_.enabled = _loc6_ && _loc2_ && Boolean(this._isAdvanced || !_loc5_.advanced);
         }
         if(param1 == SettingsConfigHelper.TERRAIN_TESSELLATION_ENABLED)
         {
            _loc3_ = SettingsControlProp(this._graphicsQualityDataProv[param1]);
            _loc4_ = this[_loc3_.isDependOn + SettingsConfigHelper.TYPE_CHECKBOX];
            _loc7_ = this[param1 + SettingsConfigHelper.TYPE_CHECKBOX];
            _loc4_.enabled = Boolean(_loc3_.changedVal);
            if(!_loc7_.selected)
            {
               _loc4_.selected = Boolean(_loc3_.changedVal);
            }
            _loc7_.enabled = _loc7_.enabled && _loc2_;
            _loc4_.enabled = _loc4_.enabled && _loc2_;
            _loc7_.selected = _loc7_.selected && _loc2_;
            _loc4_.selected = _loc4_.selected && _loc2_;
            this.updateDependedControl(SettingsConfigHelper.TERRAIN_QUALITY);
         }
         super.updateDependedControl(param1);
      }
      
      public function rewriteInitialValues() : void
      {
         var _loc1_:SettingsControlProp = SettingsControlProp(data[SettingsConfigHelper.FOV]);
         this._initialFOVValues = [fovRangeSlider.value,fovRangeSlider.leftValue,fovRangeSlider.rightValue];
         _loc1_.current = this._initialFOVValues;
      }
      
      public function setPresetAfterAutoDetect(param1:Number) : void
      {
         var _loc2_:String = SettingsConfigHelper.GRAPHIC_QUALITY;
         var _loc3_:SettingsControlProp = SettingsControlProp(data[_loc2_]);
         var _loc4_:DropdownMenu = this[_loc2_ + _loc3_.type];
         this._presets.setByKey(CURRENT_STR,param1);
         _loc3_.changedVal = this._presets.getByKey(CURRENT_STR);
         var _loc5_:int = this.getDPItemIndex(_loc4_.dataProvider,_loc3_.changedVal);
         this._isCustomPreset = _loc3_.options[_loc5_].key == SettingsConfigHelper.CUSTOM;
         this.updatePresetsDP();
         _loc4_.selectedIndex = _loc5_;
         autodetectQuality.enabled = true;
      }
      
      public function tryFindPreset() : Number
      {
         var _loc1_:Array = null;
         var _loc2_:Number = NaN;
         var _loc3_:SettingsControlProp = null;
         var _loc4_:Number = NaN;
         var _loc5_:* = null;
         var _loc6_:Number = NaN;
         var _loc7_:Boolean = false;
         var _loc8_:Object = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:DropdownMenu = null;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:String = null;
         if(this._allowCheckPreset)
         {
            _loc1_ = this._presets.getByKey(OPTIONS_STR) as Array;
            App.utils.asserter.assertNotNull(_loc1_," _presets.getByKey(OPTIONS_STR) must be Array");
            _loc2_ = _loc1_.length;
            _loc3_ = null;
            _loc4_ = -1;
            _loc5_ = Values.EMPTY_STR;
            _loc6_ = 0;
            while(_loc6_ < _loc2_)
            {
               _loc7_ = true;
               _loc8_ = _loc1_[_loc6_];
               if(_loc8_[SUPPORTED_STR])
               {
                  for(_loc5_ in _loc8_.settings)
                  {
                     _loc9_ = _loc8_.settings[_loc5_];
                     _loc3_ = SettingsControlProp(this._graphicsQualityDataProv[_loc5_]);
                     _loc10_ = Number(_loc3_.changedVal);
                     if(_loc9_ != _loc10_)
                     {
                        _loc7_ = false;
                        break;
                     }
                  }
                  if(_loc7_)
                  {
                     this._isCustomPreset = _loc8_.key == SettingsConfigHelper.CUSTOM;
                     _loc4_ = _loc8_.index;
                     break;
                  }
               }
               _loc6_++;
            }
            if(_loc4_ >= 0)
            {
               _loc5_ = SettingsConfigHelper.GRAPHIC_QUALITY;
               _loc3_ = SettingsControlProp(data[_loc5_]);
               _loc11_ = this[_loc5_ + _loc3_.type];
               this.updatePresetsDP();
               _loc12_ = _loc11_.selectedIndex;
               _loc13_ = this.getDPItemIndex(_loc11_.dataProvider,_loc4_);
               if(_loc12_ != _loc13_)
               {
                  this._skipDispatchPresetEvent = true;
                  _loc11_.selectedIndex = _loc13_;
               }
               _loc14_ = _loc11_.dataProvider.requestItemAt(_loc11_.selectedIndex).key;
               this.updateGraphicsQualityHDSDLabel(_loc14_);
            }
         }
         return _loc4_;
      }
      
      public function onSettingsChanged() : void
      {
         if(currentScreenModeId == SettingsConfigHelper.RESOLUTION)
         {
            this.updateColorSettingsEnabled();
         }
      }
      
      private function updateCurrentTab() : void
      {
         screenForm.visible = tabs.selectedIndex == 0;
         advancedForm.visible = !screenForm.visible;
      }
      
      private function setControlsData(param1:SettingsDataVo) : void
      {
         var _loc6_:String = null;
         var _loc7_:SettingsControlProp = null;
         var _loc9_:SettingsControlProp = null;
         var _loc10_:SettingsControlProp = null;
         var _loc11_:Boolean = false;
         var _loc12_:CheckBox = null;
         var _loc13_:Slider = null;
         var _loc14_:RangeSlider = null;
         var _loc15_:DropdownMenu = null;
         var _loc16_:SoundButtonEx = null;
         this.initMonitors();
         this._skipIdList = new Vector.<String>();
         this._extendAdvancedControls = {};
         var _loc2_:Vector.<String> = Vector.<String>([SettingsConfigHelper.SIZES]);
         this._skipIdList = this._qualityOrderIdList.slice(0);
         this._skipIdList = this._skipIdList.concat(this._imaginaryIdList);
         this._skipIdList = this._skipIdList.concat(_loc2_);
         this._skipIdList.push(SettingsConfigHelper.GRAPHIC_QUALITY);
         this._skipIdList.push(SettingsConfigHelper.GRAPHIC_QUALITY_HDSD);
         this._skipIdList.push(SettingsConfigHelper.GRAPHIC_QUALITY_HDSD_HIGH);
         this._skipIdList.push(SettingsConfigHelper.COLOR_FILTER_IMAGES);
         this._skipIdList.push(SettingsConfigHelper.REFRESH_RATE);
         this._skipIdList.push(SettingsConfigHelper.INTERFACE_SCALE);
         var _loc3_:Vector.<String> = param1.keys;
         var _loc4_:Vector.<Object> = param1.values;
         var _loc5_:int = _loc3_.length;
         _loc6_ = Values.EMPTY_STR;
         _loc7_ = null;
         var _loc8_:int = 0;
         for(; _loc8_ < _loc5_; _loc8_++)
         {
            _loc6_ = _loc3_[_loc8_];
            trySetLabel(_loc6_);
            if(this._skipIdList.indexOf(_loc6_) >= 0)
            {
               if(_loc6_ == SettingsConfigHelper.GRAPHIC_QUALITY_HDSD)
               {
                  _loc9_ = SettingsControlProp(_loc4_[_loc8_]);
                  if(_loc9_.current != null && _loc9_.current != Values.EMPTY_STR)
                  {
                     graphicsQualityHDSD.htmlText = _loc9_.current.toString();
                     this._showSDQualityWarning = true;
                  }
               }
               else if(_loc6_ == SettingsConfigHelper.GRAPHIC_QUALITY_HDSD_HIGH)
               {
                  _loc10_ = SettingsControlProp(_loc4_[_loc8_]);
                  if(_loc10_.current != null && _loc10_.current != Values.EMPTY_STR)
                  {
                     graphicsQualityHDSDHigh.htmlText = _loc10_.current.toString();
                     this._showSDQualityWarning = true;
                  }
               }
               if(this._extendAdvancedControlsIds.indexOf(_loc6_) == -1)
               {
                  continue;
               }
            }
            if(_loc4_[_loc8_].type && this[_loc6_ + _loc4_[_loc8_].type] != undefined)
            {
               _loc7_ = _loc4_[_loc8_] as SettingsControlProp;
               App.utils.asserter.assertNotNull(_loc7_,"values[i] must be SettingsControlProp");
               _loc11_ = !(_loc7_.current == null || _loc7_.readOnly);
               if(_loc7_.isDependOn)
               {
                  headDependedControls.push(_loc6_);
               }
               if(this._extendAdvancedControlsIds.indexOf(_loc6_) >= 0)
               {
                  this._extendAdvancedControls[_loc6_] = _loc7_.clone();
               }
               else
               {
                  switch(_loc7_.type)
                  {
                     case SettingsConfigHelper.TYPE_CHECKBOX:
                        _loc12_ = this[_loc6_ + _loc7_.type];
                        if(_loc12_.label == Values.EMPTY_STR)
                        {
                           _loc12_.label = SettingsConfigHelper.LOCALIZATION + _loc6_;
                        }
                        _loc12_.selected = _loc7_.current;
                        _loc12_.addEventListener(Event.SELECT,this.onCheckBoxSelectHandler);
                        _loc12_.visible = _loc7_.current != null;
                        if(this._skipSetEnableIdList.indexOf(_loc6_) == -1)
                        {
                           _loc12_.enabled = _loc11_;
                        }
                        if(_loc6_ == SettingsConfigHelper.DYNAMIC_FOV)
                        {
                           fovRangeSlider.rangeMode = _loc12_.selected;
                        }
                        break;
                     case SettingsConfigHelper.TYPE_SLIDER:
                        _loc13_ = this[_loc6_ + _loc7_.type];
                        _loc13_.addEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChangeHandler);
                        _loc13_.value = Number(_loc7_.current);
                        if(this._skipSetEnableIdList.indexOf(_loc6_) == -1)
                        {
                           _loc13_.enabled = _loc11_;
                        }
                        break;
                     case SettingsConfigHelper.TYPE_RANGE_SLIDER:
                        _loc14_ = this[_loc6_ + _loc7_.type];
                        _loc14_.addEventListener(SliderEvent.VALUE_CHANGE,this.onRangeSliderValueChangeHandler);
                        this._initialFOVValues = _loc7_.current as Array;
                        App.utils.asserter.assertNotNull(this._initialFOVValues,"controlProp.current must be Array");
                        this.setInitialFOVValues();
                        _loc14_.enabled = _loc11_;
                        break;
                     case SettingsConfigHelper.TYPE_DROPDOWN:
                        _loc15_ = this[_loc6_ + _loc7_.type];
                        _loc15_.visible = _loc7_.current != null;
                        _loc15_.dataProvider = new DataProvider(_loc7_.options);
                        if(_loc7_.isDataAsSelectedIndex)
                        {
                           _loc15_.selectedIndex = findSelectedIndexForDD(Number(_loc7_.current),_loc7_.options);
                        }
                        else
                        {
                           _loc15_.selectedIndex = int(_loc7_.current);
                        }
                        _loc15_.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChangeHandler);
                        if(this._skipSetEnableIdList.indexOf(_loc6_) == -1)
                        {
                           this.updateDropDownEnabled(_loc6_);
                        }
                        if(_loc6_ == SettingsConfigHelper.SCREEN_MODE)
                        {
                           currentScreenModeId = SettingsConfigHelper.SIZES_ORDER_ID[_loc7_.current];
                           this.updateColorSettingsEnabled();
                        }
                        break;
                     case SettingsConfigHelper.TYPE_BUTTON:
                        _loc16_ = this[_loc6_ + _loc7_.type];
                        _loc16_.label = _loc7_.current.toString();
                  }
               }
            }
            else if(!_loc7_.readOnly && SettingsConfigHelper.reservedImaginaryControls.indexOf(_loc6_) == -1)
            {
               DebugUtils.LOG_WARNING(CONTROL_ERROR_MESSAGE + _loc6_);
            }
         }
         this.updateScreenModeDependentControls();
         this.setSizeControl(false);
         this.initRefreshRateControl();
         this.updateRefreshRate();
         this.initInterfaceScale();
         this._allowCheckPreset = false;
         this.setPresets();
         this.setRenderPipeline();
         this.updateAdvancedDependedControls();
         this._allowCheckPreset = true;
         this._isInited = true;
         this.tryFindPreset();
      }
      
      private function initMonitors() : void
      {
         var _loc1_:SettingsControlProp = SettingsControlProp(data[SettingsConfigHelper.MONITOR]);
         var _loc2_:Number = Number(_loc1_.changedVal);
         var _loc3_:uint = _loc1_.options is Array ? uint(_loc1_.options.length) : uint(0);
         var _loc4_:SettingsControlProp = SettingsControlProp(data[SettingsConfigHelper.RESOLUTION]);
         var _loc5_:SettingsControlProp = SettingsControlProp(data[SettingsConfigHelper.WINDOW_SIZE]);
         var _loc6_:SettingsControlProp = SettingsControlProp(data[SettingsConfigHelper.BORDERLESS_SIZE]);
         _loc4_.prevVal = [];
         _loc5_.prevVal = [];
         _loc6_.prevVal = [];
         var _loc7_:Number = 0;
         while(_loc7_ < _loc3_)
         {
            _loc4_.prevVal[_loc7_] = _loc7_ == _loc2_ ? _loc4_.changedVal : 0;
            _loc5_.prevVal[_loc7_] = _loc7_ == _loc2_ ? _loc5_.changedVal : 0;
            _loc6_.prevVal[_loc7_] = _loc7_ == _loc2_ ? _loc6_.changedVal : 0;
            _loc7_++;
         }
      }
      
      private function updateScreenModeDependentControls() : void
      {
         var _loc2_:String = null;
         var _loc3_:SettingsControlProp = null;
         var _loc4_:UIComponent = null;
         var _loc5_:DropdownMenu = null;
         var _loc1_:Array = [SettingsConfigHelper.REFRESH_RATE];
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = SettingsControlProp(data[_loc2_]);
            _loc4_ = this[_loc2_ + _loc3_.type];
            if(_loc3_.type == SettingsConfigHelper.TYPE_DROPDOWN)
            {
               _loc5_ = this[_loc2_ + _loc3_.type];
               _loc4_.enabled = currentScreenModeId == SettingsConfigHelper.RESOLUTION && !(_loc3_.changedVal == null || _loc3_.readOnly) && _loc5_.dataProvider.length > 1;
            }
            else
            {
               _loc4_.enabled = currentScreenModeId == SettingsConfigHelper.RESOLUTION && !(_loc3_.changedVal == null || _loc3_.readOnly);
            }
         }
         this.updateColorSettingsEnabled();
      }
      
      private function updateColorSettingsEnabled() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = currentScreenModeId == SettingsConfigHelper.RESOLUTION;
         if(_loc2_)
         {
            _loc1_ = this.gammaSettingsEnabled();
         }
         else
         {
            _loc1_ = this._isAdvanced;
         }
         gammaSettingButton.enabled = _loc1_;
         colorFilterButton.enabled = this._isAdvanced;
      }
      
      private function gammaSettingsEnabled() : Boolean
      {
         var _loc1_:Object = this._settingsConfigHelper.changesData.getChanges();
         return SettingsControlProp(data[SettingsConfigHelper.RESOLUTION]).changedVal == SettingsControlProp(data[SettingsConfigHelper.NATIVE_RESOLUTION]).changedVal && !_loc1_.hasOwnProperty(SettingsConfigHelper.RESOLUTION) && !_loc1_.hasOwnProperty(SettingsConfigHelper.RENDER_PIPELINE);
      }
      
      private function setSizeControl(param1:Boolean = true) : void
      {
         var _loc2_:String = SettingsConfigHelper.SIZES;
         var _loc3_:SettingsControlProp = SettingsControlProp(data[_loc2_]);
         var _loc4_:DropdownMenu = this[_loc2_ + _loc3_.type];
         var _loc5_:SettingsControlProp = SettingsControlProp(data[currentScreenModeId]);
         sizesLabel.text = SettingsConfigHelper.LOCALIZATION + currentScreenModeId;
         var _loc6_:SettingsControlProp = SettingsControlProp(data[SettingsConfigHelper.MONITOR]);
         var _loc7_:Number = Number(_loc6_.changedVal);
         _loc3_.options = _loc5_.options[_loc7_];
         var _loc8_:Number = Number(_loc5_.changedVal);
         var _loc9_:Number = _loc3_.options.length - 1;
         if(param1 || _loc8_ > _loc9_)
         {
            _loc8_ = _loc9_;
         }
         _loc4_.dataProvider = new DataProvider(_loc3_.options);
         var _loc10_:Number = _loc4_.selectedIndex;
         _loc4_.selectedIndex = _loc8_;
         this.updateDropDownEnabled(_loc2_);
         if(!this._isInited)
         {
            _loc3_.current = _loc8_;
            _loc4_.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChangeHandler);
         }
         else if(_loc10_ == _loc8_)
         {
            this.updateInterfaceScale();
         }
      }
      
      private function updateDropDownEnabled(param1:String) : void
      {
         var _loc2_:SettingsControlProp = SettingsControlProp(data.getByKey(param1));
         var _loc3_:DropdownMenu = this[param1 + _loc2_.type];
         _loc3_.enabled = _loc3_.dataProvider.length > 1 && !_loc2_.readOnly;
      }
      
      private function setInitialFOVValues() : void
      {
         fovRangeSlider.value = this._initialFOVValues[0];
         fovRangeSlider.rightValue = this._initialFOVValues[2];
         fovRangeSlider.leftValue = this._initialFOVValues[1];
      }
      
      private function initRefreshRateControl() : void
      {
         refreshRateDropDown.addEventListener(ListEvent.INDEX_CHANGE,this.onRefreshRateDropDownIndexChangeHandler);
      }
      
      private function updateRefreshRate(param1:Boolean = false) : void
      {
         var _loc7_:SettingsControlProp = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Array = null;
         var _loc11_:Number = NaN;
         var _loc2_:String = SettingsConfigHelper.REFRESH_RATE;
         var _loc3_:SettingsControlProp = SettingsControlProp(data[_loc2_]);
         var _loc4_:DropdownMenu = this[_loc2_ + _loc3_.type];
         if(this._settingsConfigHelper.liveUpdateVideoSettingsData[_loc2_] && param1)
         {
            _loc7_ = SettingsControlProp(this._settingsConfigHelper.liveUpdateVideoSettingsData[_loc2_]);
            _loc3_.options = App.utils.data.cloneObject(_loc7_.options);
            _loc3_.current = _loc7_.current;
         }
         var _loc5_:Object = _loc3_.changedVal;
         if(currentScreenModeId == SettingsConfigHelper.RESOLUTION)
         {
            _loc8_ = monitorDropDown.selectedIndex;
            _loc9_ = sizesDropDown.selectedIndex;
            _loc10_ = _loc3_.options[_loc8_][_loc9_];
            _loc4_.dataProvider = new DataProvider(_loc10_);
         }
         else
         {
            _loc4_.dataProvider = new DataProvider([SETTINGS.REFRESHRATE_DEFAULT]);
         }
         this.updateDropDownEnabled(_loc2_);
         var _loc6_:int = _loc4_.dataProvider.indexOf(_loc5_);
         if(_loc6_ == -1)
         {
            _loc11_ = this.getClosestRefreshRate(int(_loc5_),_loc4_.dataProvider);
            if(isNaN(_loc11_))
            {
               _loc4_.selectedIndex = _loc4_.dataProvider.length - 1;
            }
            else
            {
               _loc4_.selectedIndex = _loc4_.dataProvider.indexOf(_loc11_);
            }
         }
         else
         {
            _loc4_.selectedIndex = _loc6_;
         }
         this.onRefreshRateDropDownIndexChangeHandler();
      }
      
      private function initInterfaceScale() : void
      {
         var _loc1_:String = SettingsConfigHelper.INTERFACE_SCALE;
         var _loc2_:SettingsControlProp = SettingsControlProp(data[_loc1_]);
         var _loc3_:DropdownMenu = this[_loc1_ + _loc2_.type];
         _loc3_.visible = _loc2_.current != null;
         interfaceScaleLabel.visible = _loc3_.visible;
         if(_loc3_.visible)
         {
            this.updateInterfaceScale();
            _loc3_.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChangeHandler);
         }
      }
      
      private function updateInterfaceScale() : void
      {
         var _loc1_:String = SettingsConfigHelper.INTERFACE_SCALE;
         var _loc2_:SettingsControlProp = SettingsControlProp(data[_loc1_]);
         var _loc3_:DropdownMenu = this[_loc1_ + _loc2_.type];
         if(!_loc3_.visible)
         {
            return;
         }
         var _loc4_:Number = this._settingsConfigHelper.getScreenSizeDataIndexById(currentScreenModeId);
         var _loc5_:int = monitorDropDown.selectedIndex;
         var _loc6_:int = sizesDropDown.selectedIndex;
         var _loc7_:Array = _loc2_.options[_loc4_][_loc5_][_loc6_];
         var _loc8_:Number = 0;
         if(_loc3_.selectedIndex >= 0)
         {
            _loc8_ = _loc3_.selectedIndex < _loc7_.length ? Number(_loc3_.selectedIndex) : Number(_loc7_.length - 1);
         }
         _loc3_.dataProvider = new DataProvider(_loc7_);
         _loc3_.selectedIndex = !!this._isInited ? int(_loc8_) : int(int(_loc2_.current));
         this.updateDropDownEnabled(_loc1_);
         if(_loc3_.enabled)
         {
            interfaceScaleLabel.toolTip = SETTINGS.INTERFACESCALE;
         }
         else
         {
            interfaceScaleLabel.toolTip = SETTINGS.INTERFACESCALEDISABLED;
         }
      }
      
      private function getClosestRefreshRate(param1:int, param2:IDataProvider) : Number
      {
         var _loc6_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:int = param2.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = Number(param2.requestItemAt(_loc5_));
            if(_loc6_ > param1 && (!!isNaN(_loc3_) ? Boolean(true) : Boolean(_loc6_ < _loc3_)))
            {
               _loc3_ = _loc6_;
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      private function setPresets() : void
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc9_:Object = null;
         var _loc10_:* = null;
         var _loc11_:Array = null;
         var _loc12_:IDataProvider = null;
         var _loc13_:int = 0;
         var _loc1_:String = SettingsConfigHelper.GRAPHIC_QUALITY;
         var _loc2_:SettingsControlProp = SettingsControlProp(data[_loc1_]);
         var _loc3_:DropdownMenu = this[_loc1_ + _loc2_.type];
         this._isSDQuality = Boolean(data[SettingsConfigHelper.IS_SD_QUALITY].changedVal);
         this._onlyPresetsDP = [];
         this._presetsWithCustomDP = [];
         var _loc8_:Object = this._presets.getByKey(OPTIONS_STR);
         for(_loc10_ in _loc8_)
         {
            _loc9_ = _loc8_[_loc10_];
            if(_loc9_.supported)
            {
               _loc6_ = _loc9_.index;
               _loc5_ = _loc9_.key;
               _loc7_ = {
                  "label":SETTINGS.graphicssettingsoptions(this.getPresetKeyForDropDown(_loc5_)),
                  "settings":_loc9_.settings,
                  "key":_loc5_,
                  "data":_loc6_
               };
               this._presetsWithCustomDP.push(_loc7_);
               if(_loc5_ == SettingsConfigHelper.CUSTOM)
               {
                  this._isCustomPreset = _loc6_ == this._presets.getByKey(CURRENT_STR);
                  _loc4_ = _loc6_;
               }
               else
               {
                  this._onlyPresetsDP.push(_loc7_);
               }
            }
         }
         _loc2_.changedVal = this._presets.getByKey(CURRENT_STR);
         _loc11_ = new DataProvider(this._presetsWithCustomDP) as Array;
         App.utils.asserter.assertNotNull(_loc11_,"_presetsWithCustomDP must be Array");
         _loc2_.options = _loc11_;
         _loc12_ = _loc2_.options as IDataProvider;
         App.utils.asserter.assertNotNull(_loc12_,"controlProp.options must be IDataProvider");
         _loc13_ = this.getDPItemIndex(_loc12_,_loc2_.changedVal);
         if(_loc13_ == -1)
         {
            this._isCustomPreset = true;
            this.updatePresetsDP();
            _loc2_.current = _loc4_;
            _loc13_ = this.getDPItemIndex(_loc3_.dataProvider,_loc4_);
         }
         else
         {
            this.updatePresetsDP();
         }
         _loc3_.selectedIndex = _loc13_;
         _loc3_.addEventListener(ListEvent.INDEX_CHANGE,this.onGraphicsQualityIndexChangeHandler);
         var _loc14_:String = _loc3_.dataProvider.requestItemAt(_loc13_).key;
         this.updateGraphicsQualityHDSDLabel(_loc14_);
      }
      
      private function getPresetKeyForDropDown(param1:String) : String
      {
         if(this.isSDHigh(param1))
         {
            return param1 + SD;
         }
         return param1;
      }
      
      private function setRenderPipeline() : void
      {
         var _loc2_:SettingsControlProp = null;
         var _loc3_:Boolean = false;
         var _loc4_:ButtonBarEx = null;
         var _loc1_:String = SettingsConfigHelper.RENDER_PIPELINE;
         if(data[_loc1_] && this[_loc1_ + data[_loc1_].type] != undefined)
         {
            _loc2_ = SettingsControlProp(data[_loc1_]);
            _loc3_ = !(_loc2_.changedVal == null || _loc2_.readOnly);
            _loc4_ = this[_loc1_ + _loc2_.type];
            _loc4_.dataProvider = new DataProvider(_loc2_.options);
            _loc4_.selectedIndex = this.getDPItemIndex(_loc4_.dataProvider,_loc2_.changedVal);
            _loc4_.enabled = _loc3_;
            this._isAdvanced = _loc4_.selectedItem[DATA_STR] == SettingsConfigHelper.ADVANCED_GRAPHICS_DATA;
            _loc4_.addEventListener(IndexEvent.INDEX_CHANGE,this.onGraphicsQualityRenderPipelineIndexChangeHandler);
         }
      }
      
      private function getDPItemIndex(param1:IDataProvider, param2:Object, param3:String = "data") : int
      {
         var _loc5_:Object = null;
         var _loc4_:int = -1;
         for each(_loc5_ in param1)
         {
            if(_loc5_.hasOwnProperty(param3) && _loc5_[param3] == param2)
            {
               _loc4_ = param1.indexOf(_loc5_);
               break;
            }
         }
         return _loc4_;
      }
      
      private function updateAdvancedDependedControls() : void
      {
         this.updateDataProviderForQuality();
         this.updateExtendedAdvancedControlsData();
         this.updateQualityControls();
         this.updateExtendedAdvancedControls();
         this.updateSmoothingControl();
         this.updateColorSettingsEnabled();
      }
      
      private function updateDataProviderForQuality() : void
      {
         var _loc1_:* = null;
         var _loc2_:SettingsControlProp = null;
         var _loc3_:SettingsStepSlider = null;
         var _loc4_:Array = null;
         var _loc5_:* = null;
         for(_loc1_ in this._graphicsQualityDataProv)
         {
            if(_loc1_ == SettingsConfigHelper.RENDER_PIPELINE)
            {
               continue;
            }
            _loc2_ = SettingsControlProp(this._graphicsQualityDataProv[_loc1_]);
            switch(_loc2_.type)
            {
               case SettingsConfigHelper.TYPE_CHECKBOX:
                  break;
               case SettingsConfigHelper.TYPE_SLIDER:
                  break;
               case SettingsConfigHelper.TYPE_STEP_SLIDER:
                  _loc3_ = this[_loc1_ + _loc2_.type];
                  _loc3_.inAdvancedMode = this._isAdvanced;
                  break;
               case SettingsConfigHelper.TYPE_DROPDOWN:
                  _loc2_.options = [];
                  _loc4_ = data[_loc1_].options;
                  for(_loc5_ in _loc4_)
                  {
                     if(this._isAdvanced || !_loc4_[_loc5_].advanced)
                     {
                        _loc2_.options.push(_loc4_[_loc5_]);
                     }
                  }
                  break;
            }
         }
      }
      
      private function updateQualityControls() : void
      {
         var _loc1_:* = null;
         var _loc2_:SettingsControlProp = null;
         var _loc3_:CheckBox = null;
         for(_loc1_ in this._graphicsQualityDataProv)
         {
            if(_loc1_ != SettingsConfigHelper.RENDER_PIPELINE)
            {
               if(this[_loc1_ + SettingsControlProp(this._graphicsQualityDataProv[_loc1_]).type])
               {
                  _loc2_ = SettingsControlProp(this._graphicsQualityDataProv[_loc1_]);
                  this.updateAdvancedQualityControl(_loc1_,_loc2_);
               }
            }
         }
         _loc3_ = CheckBox(this[SettingsConfigHelper.DRR_AUTOSCALER_ENABLED + SettingsConfigHelper.TYPE_CHECKBOX]);
         this.updateDynamicRendererSlider(_loc3_.selected);
      }
      
      private function updateAdvancedQualityControl(param1:String, param2:SettingsControlProp) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:uint = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc10_:CheckBox = null;
         var _loc11_:Boolean = false;
         var _loc12_:SettingsStepSlider = null;
         var _loc13_:DropdownMenu = null;
         var _loc8_:uint = 0;
         var _loc9_:Array = param2.options;
         switch(param2.type)
         {
            case SettingsConfigHelper.TYPE_CHECKBOX:
               _loc10_ = this[param1 + param2.type];
               _loc11_ = param2.changedVal;
               _loc10_.selected = _loc11_ && (this._isAdvanced || !param2.advanced);
               _loc10_.enabled = Boolean(this._isAdvanced || !param2.advanced);
               if(_loc11_ != _loc10_.selected)
               {
                  param2.changedVal = _loc10_.selected;
                  dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,param1,_loc10_.selected));
               }
               if(!this._isInited)
               {
                  _loc10_.addEventListener(Event.SELECT,this.onCheckBoxOrderedSelectHandler);
               }
               break;
            case SettingsConfigHelper.TYPE_STEP_SLIDER:
               _loc12_ = this[param1 + param2.type];
               _loc3_ = Number(param2.changedVal);
               _loc4_ = -1;
               _loc5_ = _loc9_.length;
               _loc8_ = 0;
               while(_loc8_ < _loc5_)
               {
                  if(_loc9_[_loc8_].data == _loc3_)
                  {
                     _loc4_ = _loc8_;
                     break;
                  }
                  _loc8_++;
               }
               _loc12_.dataProvider = new DataProvider(_loc9_);
               _loc12_.inAdvancedMode = this._isAdvanced;
               _loc12_.validateNow();
               _loc6_ = _loc12_.value;
               _loc12_.value = _loc4_ != -1 ? Number(_loc4_) : Number(0);
               _loc7_ = _loc9_[_loc12_.value].data;
               if(_loc6_ == _loc12_.value)
               {
                  if(param2.prevVal != _loc7_)
                  {
                     param2.prevVal = param2.changedVal;
                     dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,param1,_loc7_));
                  }
               }
               param2.changedVal = _loc7_;
               if(!this._isInited)
               {
                  _loc12_.addEventListener(SliderEvent.VALUE_CHANGE,this.onSliderOrderedValueChangeHandler);
               }
               break;
            case SettingsConfigHelper.TYPE_DROPDOWN:
               _loc13_ = this[param1 + param2.type];
               _loc3_ = Number(param2.changedVal);
               _loc4_ = -1;
               _loc5_ = _loc9_.length;
               _loc8_ = 0;
               while(_loc8_ < _loc5_)
               {
                  if(_loc9_[_loc8_].data == _loc3_)
                  {
                     _loc4_ = _loc8_;
                     break;
                  }
                  _loc8_++;
               }
               _loc13_.menuRowCount = _loc9_.length <= 7 ? Number(_loc9_.length) : Number(7);
               _loc13_.dataProvider = new DataProvider(_loc9_);
               _loc6_ = _loc13_.selectedIndex;
               _loc13_.selectedIndex = _loc4_ != -1 ? int(_loc4_) : int(0);
               _loc7_ = _loc9_[_loc13_.selectedIndex].data;
               if(_loc6_ == _loc13_.selectedIndex)
               {
                  if(param2.prevVal != _loc7_)
                  {
                     param2.prevVal = param2.changedVal;
                     dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,param1,_loc7_));
                  }
               }
               param2.changedVal = _loc7_;
               this.updateDropDownEnabled(param1);
               if(!this._isInited)
               {
                  _loc13_.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownOrderedIndexChangeHandler);
               }
         }
         this.updateDependedControl(param1);
      }
      
      private function updateExtendedAdvancedControlsData() : void
      {
         var _loc1_:SettingsControlProp = null;
         var _loc2_:* = null;
         var _loc3_:Array = null;
         var _loc4_:* = null;
         if(this._extendAdvancedControls)
         {
            for(_loc2_ in this._extendAdvancedControls)
            {
               _loc1_ = SettingsControlProp(this._extendAdvancedControls[_loc2_]);
               _loc1_.options = [];
               _loc3_ = data[_loc2_].options;
               for(_loc4_ in _loc3_)
               {
                  if(this._isAdvanced || !_loc3_[_loc4_].advanced)
                  {
                     _loc1_.options.push(_loc3_[_loc4_]);
                  }
               }
            }
         }
      }
      
      private function updateExtendedAdvancedControls() : void
      {
         var _loc1_:SettingsControlProp = null;
         var _loc2_:* = null;
         if(this._extendAdvancedControls)
         {
            for(_loc2_ in this._extendAdvancedControls)
            {
               _loc1_ = SettingsControlProp(this._extendAdvancedControls[_loc2_]);
               this.updateAdvancedQualityControl(_loc2_,_loc1_);
            }
         }
      }
      
      private function updateSmoothingControl() : void
      {
         CUSTOM_AA_MODELabel.visible = this._isAdvanced;
         CUSTOM_AA_MODEValue.visible = this._isAdvanced;
         CUSTOM_AA_MODEStepSlider.visible = this._isAdvanced;
         MSAA_QUALITYLabel.visible = !this._isAdvanced;
         MSAA_QUALITYValue.visible = !this._isAdvanced;
         MSAA_QUALITYStepSlider.visible = !this._isAdvanced;
      }
      
      private function updateCurrentPropForGraphicsOrderInPreset(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc3_:SettingsControlProp = null;
         for(_loc2_ in param1)
         {
            if(_loc2_ != SettingsConfigHelper.RENDER_PIPELINE)
            {
               if(this._qualityOrderIdList.indexOf(_loc2_) >= 0)
               {
                  _loc3_ = SettingsControlProp(this._graphicsQualityDataProv[_loc2_]);
                  _loc3_.changedVal = _loc3_.type == SettingsConfigHelper.TYPE_CHECKBOX ? Boolean(param1[_loc2_]) : Number(param1[_loc2_]);
               }
               else
               {
                  DebugUtils.LOG_WARNING(SET_DATA_ISSUE_MESSAGE + _loc2_);
               }
            }
         }
      }
      
      private function updateLiveVideoData() : void
      {
         var _loc8_:String = null;
         var _loc9_:SettingsControlProp = null;
         var _loc12_:SettingsControlProp = null;
         var _loc13_:SettingsControlProp = null;
         var _loc14_:Number = NaN;
         var _loc1_:CheckBox = null;
         var _loc2_:DropdownMenu = null;
         var _loc3_:Slider = null;
         var _loc4_:Vector.<String> = this._settingsConfigHelper.liveUpdateVideoSettingsOrderData;
         var _loc5_:Object = this._settingsConfigHelper.liveUpdateVideoSettingsData;
         var _loc6_:uint = _loc4_.length;
         var _loc7_:IDataUtils = App.utils.data;
         var _loc10_:uint = 0;
         while(_loc10_ < _loc6_)
         {
            _loc8_ = _loc4_[_loc10_];
            _loc9_ = SettingsControlProp(data[_loc8_]);
            if(_loc5_[_loc8_])
            {
               _loc12_ = SettingsControlProp(_loc5_[_loc8_]);
               _loc9_.options = _loc7_.cloneObject(_loc12_.options);
               _loc9_.current = _loc12_.current;
            }
            _loc10_++;
         }
         var _loc11_:Boolean = false;
         _loc10_ = 0;
         for(; _loc10_ < _loc6_; _loc10_++)
         {
            _loc8_ = _loc4_[_loc10_];
            _loc9_ = SettingsControlProp(data[_loc8_]);
            if(!(_loc9_ && this[_loc8_ + _loc9_.type]))
            {
               continue;
            }
            switch(_loc9_.type)
            {
               case SettingsConfigHelper.TYPE_CHECKBOX:
                  _loc1_ = CheckBox(this[_loc8_ + _loc9_.type]);
                  _loc1_.selected = Boolean(_loc9_.changedVal);
                  break;
               case SettingsConfigHelper.TYPE_SLIDER:
                  if(_loc5_[_loc8_])
                  {
                     _loc3_ = Slider(this[_loc8_ + _loc9_.type]);
                     _loc3_.value = Number(_loc9_.changedVal);
                  }
                  break;
               case SettingsConfigHelper.TYPE_DROPDOWN:
                  _loc2_ = DropdownMenu(this[_loc8_ + _loc9_.type]);
                  if(_loc8_ == SettingsConfigHelper.SIZES)
                  {
                     _loc13_ = SettingsControlProp(_loc5_[currentScreenModeId]);
                     if(_loc13_ && _loc13_.options is Array)
                     {
                        _loc14_ = monitorDropDown.selectedIndex;
                        SettingsControlProp(data[currentScreenModeId]).prevVal[_loc14_] = _loc13_.changedVal;
                        _loc2_.dataProvider = new DataProvider(_loc13_.options[_loc14_]);
                        _loc2_.selectedIndex = int(_loc13_.changedVal);
                        _loc2_.enabled = _loc2_.dataProvider.length > 1;
                     }
                     this.updateColorSettingsEnabled();
                  }
                  else if(_loc8_ == SettingsConfigHelper.REFRESH_RATE)
                  {
                     this.updateRefreshRate(true);
                  }
                  else if(_loc8_ == SettingsConfigHelper.INTERFACE_SCALE)
                  {
                     _loc11_ = true;
                  }
                  else
                  {
                     _loc2_.dataProvider = new DataProvider(_loc9_.options);
                     _loc2_.selectedIndex = int(_loc9_.changedVal);
                     this.updateDropDownEnabled(_loc8_);
                  }
                  break;
            }
         }
         if(_loc11_)
         {
            this.updateInterfaceScale();
         }
      }
      
      private function updatePresetsDP() : void
      {
         var _loc1_:String = SettingsConfigHelper.GRAPHIC_QUALITY;
         var _loc2_:SettingsControlProp = SettingsControlProp(data.getByKey(_loc1_));
         var _loc3_:DropdownMenu = this[_loc1_ + _loc2_.type];
         _loc3_.dataProvider = new DataProvider(!!this._isCustomPreset ? this._presetsWithCustomDP : this._onlyPresetsDP);
         this.updateDropDownEnabled(_loc1_);
      }
      
      private function updateDynamicRendererSlider(param1:Boolean) : void
      {
         var _loc2_:String = SettingsConfigHelper.DYNAMIC_RENDERER;
         var _loc3_:SettingsControlProp = SettingsControlProp(data[_loc2_]);
         var _loc4_:Slider = Slider(this[_loc2_ + _loc3_.type]);
         _loc4_.value = Number(_loc3_.prevVal);
         if(param1)
         {
            _loc4_.removeEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChangeHandler);
            this.updateSliderLabel(_loc2_,_loc3_.hasValue,_loc4_.value.toString());
         }
         else
         {
            _loc4_.addEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChangeHandler);
         }
         _loc4_.enabled = dynamicRendererValue.enabled = !param1;
      }
      
      private function updateSliderLabel(param1:String, param2:Boolean, param3:String) : void
      {
         var _loc4_:LabelControl = null;
         var _loc5_:String = null;
         if(param2 && this[param1 + SettingsConfigHelper.TYPE_VALUE])
         {
            _loc4_ = this[param1 + SettingsConfigHelper.TYPE_VALUE];
            _loc5_ = Values.EMPTY_STR;
            if(param1 == SettingsConfigHelper.DYNAMIC_RENDERER)
            {
               _loc5_ = POSTFIX_STR;
            }
            _loc4_.text = param3.toString() + _loc5_;
         }
      }
      
      private function updateGraphicsQualityHDSDLabel(param1:String) : void
      {
         var _loc2_:Boolean = this.isSDHigh(param1);
         graphicsQualityHDSDHigh.visible = this._showSDQualityWarning && _loc2_;
         graphicsQualityHDSD.visible = this._showSDQualityWarning && !_loc2_;
      }
      
      private function isSDHigh(param1:String) : Boolean
      {
         return this._isSDQuality && HIGH_QUALITY.indexOf(param1) >= 0;
      }
      
      private function onFormOnControlNewCountersVisitedHandler(param1:SettingViewEvent) : void
      {
         param1.viewId = Boolean(param1.viewId) ? param1.viewId : viewId;
         param1.subViewId = !!screenForm.visible ? SCREEN_SETTINGS : ADVANCED_GRAPHIC_SETTINGS;
      }
      
      private function onTabsIndexChangeHandler(param1:IndexEvent) : void
      {
         if(initialized)
         {
            this.updateCurrentTab();
         }
      }
      
      private function onRefreshRateDropDownIndexChangeHandler(param1:ListEvent = null) : void
      {
         var _loc2_:String = null;
         var _loc3_:SettingsControlProp = null;
         var _loc4_:DropdownMenu = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(currentScreenModeId == SettingsConfigHelper.RESOLUTION)
         {
            _loc2_ = SettingsConfigHelper.REFRESH_RATE;
            _loc3_ = SettingsControlProp(data[_loc2_]);
            _loc4_ = this[_loc2_ + _loc3_.type];
            _loc5_ = int(_loc3_.changedVal);
            _loc6_ = int(_loc4_.dataProvider.requestItemAt(_loc4_.selectedIndex));
            if(_loc5_ != _loc6_)
            {
               _loc3_.prevVal = _loc5_;
               _loc3_.changedVal = _loc6_;
               dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,_loc2_,_loc6_));
            }
         }
      }
      
      private function onGraphicsQualityIndexChangeHandler(param1:ListEvent) : void
      {
         var _loc6_:SettingsControlProp = null;
         var _loc7_:ButtonBarEx = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:int = 0;
         var _loc11_:Object = null;
         var _loc12_:Boolean = false;
         this._allowCheckPreset = false;
         var _loc2_:Object = param1.itemData;
         var _loc3_:String = _loc2_.key;
         this._presets.setByKey(CURRENT_STR,_loc2_.index);
         this._isCustomPreset = _loc3_ == SettingsConfigHelper.CUSTOM;
         this.updatePresetsDP();
         if(this._skipDispatchPresetEvent || this._isCustomPreset)
         {
            this._skipDispatchPresetEvent = false;
            this._allowCheckPreset = true;
            return;
         }
         this.updateCurrentPropForGraphicsOrderInPreset(_loc2_.settings);
         var _loc4_:String = SettingsConfigHelper.RENDER_PIPELINE;
         var _loc5_:* = data[_loc4_];
         if(_loc5_ && this[_loc4_ + _loc5_.type] != undefined)
         {
            _loc6_ = SettingsControlProp(_loc5_);
            _loc7_ = this[_loc4_ + _loc6_.type];
            _loc8_ = _loc7_.selectedItem[DATA_STR];
            _loc9_ = _loc2_.settings[SettingsConfigHelper.RENDER_PIPELINE];
            if(_loc8_ != _loc9_)
            {
               _loc10_ = this.getDPItemIndex(_loc7_.dataProvider,_loc9_);
               if(_loc10_ != -1)
               {
                  _loc11_ = _loc7_.dataProvider.requestItemAt(_loc10_);
                  _loc12_ = !!_loc11_.hasOwnProperty(SUPPORTED_STR) ? Boolean(_loc11_[SUPPORTED_STR]) : Boolean(true);
                  if(_loc12_)
                  {
                     _loc7_.selectedIndex = _loc10_;
                  }
                  else
                  {
                     this._allowCheckPreset = true;
                     this.updateAdvancedDependedControls();
                  }
               }
            }
            else
            {
               this.updateAdvancedDependedControls();
            }
         }
         this.updateGraphicsQualityHDSDLabel(_loc3_);
         this._allowCheckPreset = true;
      }
      
      private function onGraphicsQualityRenderPipelineIndexChangeHandler(param1:IndexEvent) : void
      {
         var _loc2_:Number = param1.index;
         var _loc3_:ButtonBarEx = ButtonBarEx(param1.target);
         var _loc4_:String = this._settingsConfigHelper.getControlIdByControlNameAndType(_loc3_.name,SettingsConfigHelper.TYPE_BUTTON_BAR);
         var _loc5_:SettingsControlProp = SettingsControlProp(this._graphicsQualityDataProv[_loc4_]);
         var _loc6_:Number = _loc5_.options[_loc2_].data;
         var _loc7_:Boolean = this._isAdvanced;
         this._isAdvanced = _loc3_.selectedItem[DATA_STR] == SettingsConfigHelper.ADVANCED_GRAPHICS_DATA;
         _loc5_.prevVal = _loc5_.changedVal;
         _loc5_.changedVal = _loc6_;
         if(this._isAdvanced != _loc7_)
         {
            dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,_loc4_,_loc6_));
            this.updateAdvancedDependedControls();
         }
         this.tryFindPreset();
      }
      
      private function onDropDownIndexChangeHandler(param1:ListEvent) : void
      {
         var _loc6_:Number = NaN;
         var _loc2_:DropdownMenu = DropdownMenu(param1.target);
         var _loc3_:String = this._settingsConfigHelper.getControlIdByControlNameAndType(_loc2_.name,SettingsConfigHelper.TYPE_DROPDOWN);
         var _loc4_:SettingsControlProp = SettingsControlProp(data[_loc3_]);
         var _loc5_:Number = _loc4_.isDataAsSelectedIndex && _loc4_.options[param1.index].hasOwnProperty(DATA_STR) ? Number(_loc4_.options[param1.index].data) : Number(param1.index);
         _loc4_.changedVal = _loc5_;
         if(_loc3_ == SettingsConfigHelper.SIZES)
         {
            _loc3_ = currentScreenModeId;
            _loc4_ = SettingsControlProp(data[currentScreenModeId]);
            _loc4_.changedVal = _loc5_;
            _loc6_ = monitorDropDown.selectedIndex;
            _loc4_.prevVal[_loc6_] = _loc5_;
            this.updateRefreshRate();
            this.updateInterfaceScale();
            if(currentScreenModeId == SettingsConfigHelper.RESOLUTION)
            {
               this.updateColorSettingsEnabled();
            }
         }
         else
         {
            _loc4_.prevVal = _loc5_;
         }
         if(_loc3_ == SettingsConfigHelper.MONITOR)
         {
            this.setSizeControl(true);
            this.updateRefreshRate();
         }
         else if(_loc3_ == SettingsConfigHelper.SCREEN_MODE)
         {
            currentScreenModeId = SettingsConfigHelper.SIZES_ORDER_ID[_loc4_.changedVal];
            this.updateScreenModeDependentControls();
            this.setSizeControl(false);
            this.updateRefreshRate();
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,_loc3_,_loc5_));
      }
      
      private function onRangeSliderValueChangeHandler(param1:SliderEvent) : void
      {
         var _loc2_:RangeSlider = RangeSlider(param1.target);
         var _loc3_:String = this._settingsConfigHelper.getControlIdByControlNameAndType(RangeSlider(param1.target).name,SettingsConfigHelper.TYPE_RANGE_SLIDER);
         var _loc4_:Array = [_loc2_.value,_loc2_.leftValue,_loc2_.rightValue];
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,_loc3_,_loc4_));
      }
      
      private function onSliderValueChangeHandler(param1:SliderEvent) : void
      {
         var _loc2_:Slider = Slider(param1.target);
         var _loc3_:String = this._settingsConfigHelper.getControlIdByControlNameAndType(Slider(param1.target).name,SettingsConfigHelper.TYPE_SLIDER);
         var _loc4_:SettingsControlProp = SettingsControlProp(data[_loc3_]);
         this.updateSliderLabel(_loc3_,_loc4_.hasValue,_loc2_.value.toString());
         _loc4_.prevVal = _loc2_.value;
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,_loc3_,Slider(param1.target).value));
      }
      
      private function onCheckBoxSelectHandler(param1:Event) : void
      {
         var _loc2_:CheckBox = CheckBox(param1.target);
         var _loc3_:String = this._settingsConfigHelper.getControlIdByControlNameAndType(_loc2_.name,SettingsConfigHelper.TYPE_CHECKBOX);
         var _loc4_:SettingsControlProp = SettingsControlProp(data[_loc3_]);
         _loc4_.changedVal = _loc2_.selected;
         if(_loc3_ == SettingsConfigHelper.DYNAMIC_FOV)
         {
            fovRangeSlider.rangeMode = _loc2_.selected;
            this.setInitialFOVValues();
         }
         if(_loc4_.isDependOn)
         {
            this.updateDependedControl(_loc3_);
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,_loc3_,_loc2_.selected));
      }
      
      private function onCheckBoxOrderedSelectHandler(param1:Event) : void
      {
         var _loc2_:CheckBox = CheckBox(param1.target);
         var _loc3_:String = this._settingsConfigHelper.getControlIdByControlNameAndType(_loc2_.name,SettingsConfigHelper.TYPE_CHECKBOX);
         var _loc4_:SettingsControlProp = SettingsControlProp(this._graphicsQualityDataProv[_loc3_]);
         _loc4_.changedVal = _loc2_.selected;
         if(_loc3_ == SettingsConfigHelper.DRR_AUTOSCALER_ENABLED)
         {
            this.updateDynamicRendererSlider(_loc2_.selected);
         }
         if(_loc4_.isDependOn)
         {
            this.updateDependedControl(_loc3_);
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,_loc3_,_loc2_.selected));
         this.tryFindPreset();
      }
      
      private function onDropDownOrderedIndexChangeHandler(param1:ListEvent) : void
      {
         var _loc2_:DropdownMenu = DropdownMenu(param1.target);
         var _loc3_:String = this._settingsConfigHelper.getControlIdByControlNameAndType(_loc2_.name,SettingsConfigHelper.TYPE_DROPDOWN);
         var _loc4_:SettingsControlProp = null;
         if(this._extendAdvancedControlsIds.indexOf(_loc3_) >= 0)
         {
            _loc4_ = SettingsControlProp(this._extendAdvancedControls[_loc3_]);
         }
         else
         {
            _loc4_ = SettingsControlProp(this._graphicsQualityDataProv[_loc3_]);
         }
         var _loc5_:Object = _loc4_.options[param1.index];
         var _loc6_:Number = !!_loc5_.hasOwnProperty(DATA_STR) ? Number(_loc5_.data) : Number(param1.index);
         _loc4_.prevVal = _loc4_.changedVal;
         _loc4_.changedVal = _loc6_;
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,_loc3_,_loc6_));
         this.tryFindPreset();
      }
      
      private function onSliderOrderedValueChangeHandler(param1:SliderEvent) : void
      {
         var _loc2_:SettingsStepSlider = SettingsStepSlider(param1.target);
         var _loc3_:String = this._settingsConfigHelper.getControlIdByControlNameAndType(_loc2_.name,SettingsConfigHelper.TYPE_STEP_SLIDER);
         var _loc4_:SettingsControlProp = null;
         if(this._extendAdvancedControlsIds.indexOf(_loc3_) >= 0)
         {
            _loc4_ = SettingsControlProp(this._extendAdvancedControls[_loc3_]);
         }
         else
         {
            _loc4_ = SettingsControlProp(this._graphicsQualityDataProv[_loc3_]);
         }
         var _loc5_:Number = _loc4_.options[_loc2_.value].data;
         _loc4_.prevVal = _loc4_.changedVal;
         _loc4_.changedVal = _loc5_;
         if(_loc4_.isDependOn)
         {
            this.updateDependedControl(_loc3_);
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,_loc3_,_loc5_));
         this.tryFindPreset();
      }
      
      private function onAutodetectClickHandler(param1:ButtonEvent) : void
      {
         autodetectQuality.enabled = false;
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_AUTO_DETECT_QUALITY,viewId));
      }
      
      private function onGammaBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_GAMMA_SETTING_OPEN,viewId));
      }
      
      private function onColorFilterBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_COLOR_SETTING_OPEN,viewId));
      }
   }
}
