package net.wg.gui.lobby.settings
{
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.crosshairPanel.ICrosshair;
   import net.wg.gui.components.crosshairPanel.constants.CrosshairConsts;
   import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
   import net.wg.gui.lobby.settings.events.SettingViewEvent;
   import net.wg.gui.lobby.settings.events.SettingsSubVewEvent;
   import net.wg.gui.lobby.settings.vo.CursorTabsDataVo;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.SettingsTabNewCounterVo;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   import net.wg.gui.lobby.settings.vo.config.aim.AimSettingsDataVo;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class AimSettings extends AimSettingsBase
   {
      
      private static const CENTRAL_TAG_TYPE_STR:String = "centralTagType";
      
      private static const CENTRAL_TAG_STR:String = "centralTag";
      
      private static const NET_STR:String = "net";
      
      private static const NET_TYPE_STR:String = NET_STR + "Type";
      
      private static const RELOADER_STR:String = "reloader";
      
      private static const CONDITION_STR:String = "condition";
      
      private static const CASSETTE_STR:String = "cassette";
      
      private static const MIXING:String = "mixing";
      
      private static const GUN_TAG:String = "gunTag";
      
      private static const MIXING_TYPE:String = "mixingType";
      
      private static const GUN_TAG_TYPE:String = "gunTagType";
      
      private static const RELOADER_TIMER_STR:String = RELOADER_STR + "Timer";
      
      private static const ZOOM_INDICATOR_STR:String = "zoomIndicator";
      
      private static const PRC_DIVIDER:Number = 100;
      
      private static const DEFAULT_TYPE:Number = 0;
      
      private static const DEFAULT_ALPHA:Number = 0;
      
      private static const AIM_COUNTER_CONTAINER_ID:String = "AIM_COUNTER_CONTAINER_ID";
      
      private static const SHOTS_RESULT_INDICATOR_STR:String = "shotsResultIndicator";
      
      private static const SPG_SCALE_WIDGET_STR:String = "spgScaleWidget";
      
      private static const ARTY_TAB_INDEX:int = 2;
      
      private static const CONTOUR_TAB_INDEX:int = 3;
      
      private static const ARTY_SHOT_NOTIFY_NORMAL:String = "red";
      
      private static const ARTY_SHOT_NOTIFY_COLORBLIND:String = "purple";
      
      private static const CONTOUR_TAB_NAME:String = "contour";
      
      private static const CONTOUR_PENETRABLE_ZONE_TAB_NAME:String = "contourPenetrableZone";
      
      private static const CONTOUR_IMPENETRABLE_ZONE_TAB_NAME:String = "contourImpenetrableZone";
       
      
      private var _aimData:AimSettingsDataVo = null;
      
      private var _currentTab:uint = 0;
      
      private var _dynamicCursorsData:Object = null;
      
      private var _setDataInProgress:Boolean = false;
      
      private var _cursorTabsDataProvider:IDataProvider;
      
      private var _colorSchemeMgr:IColorSchemeManager;
      
      public function AimSettings()
      {
         this._cursorTabsDataProvider = SettingsConfigHelper.instance.cursorTabsDataProvider;
         this._colorSchemeMgr = App.colorSchemeMgr;
         super();
      }
      
      override public function toString() : String
      {
         return "[WG AimSettings " + name + "]";
      }
      
      override protected function getContainerId() : String
      {
         return AIM_COUNTER_CONTAINER_ID;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         artyZoomPanel.visible = false;
         artyShotNotify.visible = false;
         artyShotIndicatorsPanel.visible = false;
         this.onColorSchemesUpdatedHandler();
         this._colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemesUpdatedHandler);
         arcadeForm.addEventListener(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,this.onFormOnControlNewCountersVisitedHandler);
         sniperForm.addEventListener(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,this.onFormOnControlNewCountersVisitedHandler);
         spgForm.addEventListener(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,this.onFormOnControlNewCountersVisitedHandler);
         contourForm.addEventListener(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,this.onFormOnControlNewCountersVisitedHandler);
      }
      
      override protected function setData(param1:SettingsDataVo) : void
      {
         var _loc12_:int = 0;
         var _loc13_:ISettingsAimForm = null;
         super.setData(param1);
         this._aimData = param1 as AimSettingsDataVo;
         this._dynamicCursorsData = {};
         this._setDataInProgress = true;
         var _loc2_:Vector.<String> = param1.keys;
         var _loc3_:Vector.<Object> = param1.values;
         var _loc4_:int = _loc2_.length;
         var _loc5_:SettingsDataVo = null;
         var _loc6_:Vector.<String> = null;
         var _loc7_:Vector.<Object> = null;
         var _loc8_:String = Values.EMPTY_STR;
         var _loc9_:int = 0;
         var _loc10_:String = Values.EMPTY_STR;
         var _loc11_:int = 0;
         while(_loc11_ < _loc4_)
         {
            _loc8_ = _loc2_[_loc11_];
            _loc5_ = _loc3_[_loc11_] as SettingsDataVo;
            App.utils.asserter.assertNotNull(_loc5_,"values[i] must be SettingsDataVo");
            if(this[_loc8_ + FORM])
            {
               _loc13_ = ISettingsAimForm(this[_loc8_ + FORM]);
               _loc13_.setData(_loc8_,_loc5_);
               _loc13_.addEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE,this.onFormAimOnControlChangeHandler);
            }
            _loc6_ = _loc5_.keys;
            _loc7_ = _loc5_.values;
            _loc9_ = _loc5_.keys.length;
            _loc12_ = 0;
            while(_loc12_ < _loc9_)
            {
               _loc10_ = _loc6_[_loc12_];
               if(!this._dynamicCursorsData.hasOwnProperty(_loc8_))
               {
                  this._dynamicCursorsData[_loc8_] = {};
               }
               this._dynamicCursorsData[_loc8_][_loc10_] = Boolean(SettingsControlProp(_loc7_[_loc12_]).current) ? SettingsControlProp(_loc7_[_loc12_]).current : 0;
               _loc12_++;
            }
            _loc11_++;
         }
         this._setDataInProgress = false;
         tabs.dataProvider = this._cursorTabsDataProvider;
         tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabIndexChangeHandler);
         tabs.selectedIndex = this._currentTab;
      }
      
      override protected function onBeforeDispose() : void
      {
         tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabIndexChangeHandler);
         arcadeForm.removeEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE,this.onFormAimOnControlChangeHandler);
         sniperForm.removeEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE,this.onFormAimOnControlChangeHandler);
         arcadeForm.removeEventListener(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,this.onFormOnControlNewCountersVisitedHandler);
         sniperForm.removeEventListener(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,this.onFormOnControlNewCountersVisitedHandler);
         spgForm.removeEventListener(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,this.onFormOnControlNewCountersVisitedHandler);
         contourForm.removeEventListener(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,this.onFormOnControlNewCountersVisitedHandler);
         this._colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemesUpdatedHandler);
         this._colorSchemeMgr = null;
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         bg = null;
         this._aimData = null;
         this._dynamicCursorsData = null;
         this._cursorTabsDataProvider = null;
         super.onDispose();
      }
      
      override protected function updateNewCountersControls(param1:Vector.<SettingsTabNewCounterVo>) : void
      {
         var _loc8_:int = 0;
         var _loc2_:int = this._cursorTabsDataProvider.length;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:SettingsNewCountersForm = null;
         var _loc6_:int = param1.length;
         var _loc7_:int = 0;
         while(_loc7_ < _loc2_)
         {
            _loc3_ = this._cursorTabsDataProvider[_loc7_].id;
            _loc4_ = this._cursorTabsDataProvider[_loc7_].formID;
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               if(_loc3_ == param1[_loc8_].subTabId)
               {
                  _loc5_ = this[_loc4_];
                  if(_loc5_)
                  {
                     _loc5_.updateNewCounters(param1[_loc8_].counters);
                  }
               }
               _loc8_++;
            }
            _loc7_++;
         }
      }
      
      override protected function getAvailableMarkVisitedCountersIds(param1:String, param2:Vector.<CountersVo>) : Array
      {
         var _loc3_:Array = [];
         if(StringUtils.isEmpty(param1) || this._aimData == null)
         {
            return _loc3_;
         }
         return super.getAvailableMarkVisitedCountersIds(param1,param2);
      }
      
      override protected function isCounterCanMarkAsVisited(param1:String, param2:CountersVo) : Boolean
      {
         var _loc3_:SettingsDataVo = this._aimData[param1];
         var _loc4_:SettingsControlProp = _loc3_[param2.componentId];
         if(_loc4_ && LINE_COUNTER_TYPES.indexOf(_loc4_.type) != Values.DEFAULT_INT)
         {
            return true;
         }
         return super.isCounterCanMarkAsVisited(param1,param2);
      }
      
      private function updateShowContent() : void
      {
         var _loc1_:uint = this._cursorTabsDataProvider.length;
         var _loc2_:SettingsNewCountersForm = null;
         var _loc3_:CursorTabsDataVo = null;
         var _loc4_:ICrosshair = null;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc1_)
         {
            _loc3_ = this._cursorTabsDataProvider[_loc5_];
            _loc2_ = this[_loc3_.formID];
            _loc2_.visible = _loc2_.formId == this._cursorTabsDataProvider[this._currentTab].id;
            _loc4_ = ICrosshair(this[_loc3_.crosshairID]);
            if(_loc4_)
            {
               _loc4_.visible = _loc2_.visible;
            }
            _loc5_++;
         }
         bg.gotoAndStop(this._currentTab + 1);
         this.updateCrosshairs(this._currentTab);
      }
      
      private function updateCrosshairs(param1:Number) : void
      {
         var _loc2_:String = this._cursorTabsDataProvider[param1].id;
         var _loc3_:Object = this._dynamicCursorsData[_loc2_];
         var _loc4_:Number = Boolean(_loc3_[CENTRAL_TAG_TYPE_STR]) ? Number(_loc3_[CENTRAL_TAG_TYPE_STR]) : Number(DEFAULT_TYPE);
         var _loc5_:Number = Boolean(_loc3_[CENTRAL_TAG_STR]) ? Number(_loc3_[CENTRAL_TAG_STR] / PRC_DIVIDER) : Number(DEFAULT_ALPHA);
         var _loc6_:Number = Boolean(_loc3_[NET_TYPE_STR]) ? Number(_loc3_[NET_TYPE_STR]) : Number(DEFAULT_TYPE);
         var _loc7_:Number = Boolean(_loc3_[NET_STR]) ? Number(_loc3_[NET_STR] / PRC_DIVIDER) : Number(DEFAULT_ALPHA);
         var _loc8_:Number = Boolean(_loc3_[RELOADER_STR]) ? Number(_loc3_[RELOADER_STR] / PRC_DIVIDER) : Number(DEFAULT_ALPHA);
         var _loc9_:Number = Boolean(_loc3_[CONDITION_STR]) ? Number(_loc3_[CONDITION_STR] / PRC_DIVIDER) : Number(DEFAULT_ALPHA);
         var _loc10_:Number = Boolean(_loc3_[RELOADER_TIMER_STR]) ? Number(_loc3_[RELOADER_TIMER_STR] / PRC_DIVIDER) : Number(DEFAULT_ALPHA);
         var _loc11_:Number = Boolean(_loc3_[CASSETTE_STR]) ? Number(_loc3_[CASSETTE_STR] / PRC_DIVIDER) : Number(DEFAULT_ALPHA);
         var _loc12_:Boolean = _loc3_[ZOOM_INDICATOR_STR];
         var _loc13_:Number = !!_loc12_ ? Number(_loc3_[ZOOM_INDICATOR_STR] / PRC_DIVIDER) : Number(DEFAULT_ALPHA);
         var _loc14_:Number = Boolean(_loc3_[MIXING]) ? Number(_loc3_[MIXING] / PRC_DIVIDER) : Number(DEFAULT_ALPHA);
         var _loc15_:Number = Boolean(_loc3_[GUN_TAG]) ? Number(_loc3_[GUN_TAG] / PRC_DIVIDER) : Number(DEFAULT_ALPHA);
         var _loc16_:Number = _loc3_[MIXING_TYPE];
         var _loc17_:Number = _loc3_[GUN_TAG_TYPE];
         var _loc18_:ICrosshair = null;
         switch(param1)
         {
            case 0:
               _loc18_ = arcadeCrosshair;
               break;
            case 1:
               _loc18_ = sniperCrosshair;
         }
         artyShotIndicatorsPanel.visible = artyShotNotify.visible = param1 == ARTY_TAB_INDEX && _loc3_[SHOTS_RESULT_INDICATOR_STR];
         artyZoomPanel.visible = param1 == ARTY_TAB_INDEX && _loc3_[SPG_SCALE_WIDGET_STR];
         contourCrosshair.visible = param1 == CONTOUR_TAB_INDEX;
         if(contourCrosshair.visible)
         {
            contourCrosshair.updateData(_loc3_[CONTOUR_TAB_NAME],_loc3_[CONTOUR_PENETRABLE_ZONE_TAB_NAME],_loc3_[CONTOUR_IMPENETRABLE_ZONE_TAB_NAME]);
         }
         if(_loc18_)
         {
            _loc18_.setCenterType(_loc4_);
            _loc18_.setNetType(_loc6_);
            _loc18_.setComponentsAlpha(_loc7_,_loc5_,_loc8_,_loc9_,_loc11_,_loc10_,_loc13_);
            _loc18_.setReloadingTime(RELOADING_TIME);
            _loc18_.setReloadingState(CrosshairConsts.RELOADING_ENDED);
            _loc18_.setHealth(CrosshairConsts.MAX_HEALTH);
            if(_loc12_)
            {
               _loc18_.setZoom(App.utils.locale.makeString(SETTINGS.AIM_X2));
            }
         }
         gunMarker.setSettings(_loc17_,_loc16_,_loc15_,_loc14_);
      }
      
      private function onFormOnControlNewCountersVisitedHandler(param1:SettingViewEvent) : void
      {
         var _loc2_:String = Boolean(param1.viewId) ? param1.viewId : viewId;
         var _loc3_:SettingViewEvent = new SettingViewEvent(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,_loc2_,param1.subViewId,param1.controlId,param1.controlValue);
         dispatchEvent(_loc3_);
      }
      
      private function onFormAimOnControlChangeHandler(param1:SettingsSubVewEvent) : void
      {
         if(this._setDataInProgress)
         {
            return;
         }
         var _loc2_:String = param1.subViewId;
         var _loc3_:String = param1.controlId;
         if(this._dynamicCursorsData != null)
         {
            this._dynamicCursorsData[_loc2_][param1.controlId] = param1.controlValue;
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,_loc2_,_loc3_,param1.controlValue));
         this.updateCrosshairs(this._currentTab);
      }
      
      private function onTabIndexChangeHandler(param1:IndexEvent) : void
      {
         this._currentTab = param1.index;
         this.updateShowContent();
      }
      
      private function onColorSchemesUpdatedHandler(param1:ColorSchemeEvent = null) : void
      {
         var _loc2_:Boolean = this._colorSchemeMgr.getIsColorBlindS();
         artyShotIndicatorsPanel.setDummyData(_loc2_);
         artyShotNotify.gotoAndStop(!!_loc2_ ? ARTY_SHOT_NOTIFY_COLORBLIND : ARTY_SHOT_NOTIFY_NORMAL);
         contourCrosshair.isColorBlind = _loc2_;
      }
   }
}
