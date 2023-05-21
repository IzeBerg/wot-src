package net.wg.gui.lobby.settings
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
   import net.wg.gui.lobby.settings.events.SettingsSubVewEvent;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterProps;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   
   public class SettingsMarkersForm extends SettingsNewCountersForm
   {
      
      private static const ALT_STR:String = "Alt";
      
      private static const COUNTER_CHECKBOX_OFFSET_X:int = -6;
      
      private static const PANE_WIDTH:uint = 250;
      
      private static const PANE_HEIGHT:uint = 216;
      
      private static const CONTROL_ID_PROP:String = "controlID";
       
      
      public var markerHeader:TextField = null;
      
      public var markerHeaderAlt:TextField = null;
      
      public var scrollPaneBase:ResizableScrollPane = null;
      
      public var scrollPaneAlt:ResizableScrollPane = null;
      
      public var topShadowBase:MovieClip = null;
      
      public var bottomShadowBase:MovieClip = null;
      
      public var topShadowAlt:MovieClip = null;
      
      public var bottomShadowAlt:MovieClip = null;
      
      public var markerBaseVehicleDistCheckbox:CheckBox = null;
      
      public var markerBaseIconCheckbox:CheckBox = null;
      
      public var markerBaseLevelCheckbox:CheckBox = null;
      
      public var markerBaseVehicleNameCheckbox:CheckBox = null;
      
      public var markerBasePlayerNameCheckbox:CheckBox = null;
      
      public var markerBaseHpIndicatorCheckbox:CheckBox = null;
      
      public var markerBaseAimMarker2DCheckbox:CheckBox = null;
      
      public var markerBaseHpDropDown:DropdownMenu = null;
      
      public var markerBaseDamageCheckbox:CheckBox = null;
      
      public var markerAltVehicleDistCheckbox:CheckBox = null;
      
      public var markerAltIconCheckbox:CheckBox = null;
      
      public var markerAltLevelCheckbox:CheckBox = null;
      
      public var markerAltVehicleNameCheckbox:CheckBox = null;
      
      public var markerAltPlayerNameCheckbox:CheckBox = null;
      
      public var markerAltHpIndicatorCheckbox:CheckBox = null;
      
      public var markerAltAimMarker2DCheckbox:CheckBox = null;
      
      public var markerAltHpDropDown:DropdownMenu = null;
      
      public var markerAltDamageCheckbox:CheckBox = null;
      
      private var _formId:String = null;
      
      private var _data:SettingsDataVo = null;
      
      public function SettingsMarkersForm()
      {
         super();
         this.initControls();
      }
      
      private static function getAltPrefix(param1:String) : String
      {
         return param1.indexOf(ALT_STR,0) >= 0 ? ALT_STR : Values.EMPTY_STR;
      }
      
      override protected function getCounterProps(param1:String) : ICounterProps
      {
         if(param1 == SettingsConfigHelper.TYPE_CHECKBOX)
         {
            return new CounterProps(COUNTER_CHECKBOX_OFFSET_X,CounterProps.DEFAULT_OFFSET_Y,TextFormatAlign.LEFT,false,Linkages.COUNTER_LINE_UI);
         }
         return super.getCounterProps(param1);
      }
      
      override protected function getTargetControlId(param1:DisplayObject) : String
      {
         return param1[CONTROL_ID_PROP];
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.markerBaseLevelCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.markerBaseLevelCheckbox.toolTip = SETTINGS.MARKER_LEVEL_TOOLTIP;
         this.scrollPaneBase.setSize(PANE_WIDTH,PANE_HEIGHT);
         this.scrollPaneAlt.setSize(PANE_WIDTH,PANE_HEIGHT);
         this.topShadowBase.mouseChildren = this.topShadowBase.mouseEnabled = false;
         this.bottomShadowBase.mouseChildren = this.bottomShadowBase.mouseEnabled = false;
         this.topShadowAlt.mouseChildren = this.topShadowAlt.mouseEnabled = false;
         this.bottomShadowAlt.mouseChildren = this.bottomShadowAlt.mouseEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:SettingsControlProp = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:int = 0;
         var _loc6_:CheckBox = null;
         var _loc7_:DropdownMenu = null;
         if(this._data && this._data.keys)
         {
            _loc1_ = this._data.keys.length;
            _loc5_ = 0;
            for(; _loc5_ < _loc1_; _loc5_++)
            {
               _loc2_ = this._data.keys[_loc5_];
               _loc3_ = SettingsControlProp(this._data.values[_loc5_]);
               _loc4_ = this[_loc2_ + _loc3_.type];
               if(!_loc4_)
               {
                  continue;
               }
               switch(_loc3_.type)
               {
                  case SettingsConfigHelper.TYPE_CHECKBOX:
                     _loc6_ = CheckBox(_loc4_);
                     if(_loc6_.hasEventListener(Event.SELECT))
                     {
                        _loc6_.removeEventListener(Event.SELECT,this.onCheckBoxSelectHandler);
                     }
                     break;
                  case SettingsConfigHelper.TYPE_DROPDOWN:
                     _loc7_ = DropdownMenu(_loc4_);
                     if(_loc7_.hasEventListener(ListEvent.INDEX_CHANGE))
                     {
                        _loc7_.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChangeHandler);
                     }
                     break;
               }
            }
            this._data = null;
         }
         this.markerHeader = null;
         this.markerHeaderAlt = null;
         this.topShadowBase = null;
         this.bottomShadowBase = null;
         this.topShadowAlt = null;
         this.bottomShadowAlt = null;
         this.scrollPaneBase.dispose();
         this.scrollPaneBase = null;
         this.scrollPaneAlt.dispose();
         this.scrollPaneAlt = null;
         this.markerBaseVehicleDistCheckbox = null;
         this.markerBaseIconCheckbox = null;
         this.markerBaseLevelCheckbox = null;
         this.markerBaseVehicleNameCheckbox = null;
         this.markerBasePlayerNameCheckbox = null;
         this.markerBaseHpIndicatorCheckbox = null;
         this.markerBaseAimMarker2DCheckbox = null;
         this.markerBaseHpDropDown = null;
         this.markerBaseDamageCheckbox = null;
         this.markerAltVehicleDistCheckbox = null;
         this.markerAltIconCheckbox = null;
         this.markerAltLevelCheckbox = null;
         this.markerAltVehicleNameCheckbox = null;
         this.markerAltPlayerNameCheckbox = null;
         this.markerAltHpIndicatorCheckbox = null;
         this.markerAltAimMarker2DCheckbox = null;
         this.markerAltHpDropDown = null;
         this.markerAltDamageCheckbox = null;
         super.onDispose();
      }
      
      override protected function getControlPropsByKey(param1:String) : SettingsControlProp
      {
         if(this._data && this._data[param1])
         {
            return this._data[param1];
         }
         return super.getControlPropsByKey(param1);
      }
      
      public function setData(param1:String, param2:SettingsDataVo) : void
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:SettingsControlProp = null;
         var _loc6_:DisplayObject = null;
         var _loc7_:int = 0;
         var _loc8_:CheckBox = null;
         var _loc9_:DropdownMenu = null;
         this._formId = param1;
         if(param2 != null)
         {
            this._data = param2;
            _loc3_ = param2.keys.length;
            _loc7_ = 0;
            for(; _loc7_ < _loc3_; _loc7_++)
            {
               _loc4_ = param2.keys[_loc7_];
               _loc5_ = param2.values[_loc7_] as SettingsControlProp;
               App.utils.asserter.assertNotNull(_loc5_,"values[i] must be SettingsControlProp");
               _loc6_ = this[_loc4_ + _loc5_.type];
               if(!_loc6_)
               {
                  continue;
               }
               switch(_loc5_.type)
               {
                  case SettingsConfigHelper.TYPE_CHECKBOX:
                     _loc8_ = CheckBox(_loc6_);
                     _loc8_[CONTROL_ID_PROP] = _loc4_;
                     _loc8_.selected = _loc5_.current;
                     _loc8_.enabled = !_loc5_.readOnly;
                     _loc8_.addEventListener(Event.SELECT,this.onCheckBoxSelectHandler);
                     break;
                  case SettingsConfigHelper.TYPE_DROPDOWN:
                     _loc9_ = DropdownMenu(_loc6_);
                     _loc9_[CONTROL_ID_PROP] = _loc4_;
                     _loc9_.menuRowCount = _loc5_.options.length;
                     _loc9_.dataProvider = new DataProvider(_loc5_.options);
                     _loc9_.selectedIndex = int(_loc5_.current);
                     _loc9_.enabled = _loc5_.current != null && !_loc5_.readOnly;
                     _loc9_.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChangeHandler);
                     break;
               }
            }
         }
         else
         {
            this.disableAllControls();
         }
      }
      
      private function disableAllControls() : void
      {
         var _loc1_:SettingsMarkerContentForm = SettingsMarkerContentForm(this.scrollPaneBase.target);
         _loc1_.disableAllControls();
         var _loc2_:SettingsMarkerContentForm = SettingsMarkerContentForm(this.scrollPaneAlt.target);
         _loc2_.disableAllControls();
      }
      
      private function initControls() : void
      {
         var _loc1_:SettingsMarkerContentForm = SettingsMarkerContentForm(this.scrollPaneBase.target);
         this.markerBaseVehicleDistCheckbox = _loc1_.vehicleDistCheckbox;
         this.markerBaseIconCheckbox = _loc1_.iconCheckbox;
         this.markerBaseLevelCheckbox = _loc1_.levelCheckbox;
         this.markerBaseVehicleNameCheckbox = _loc1_.vehicleNameCheckbox;
         this.markerBasePlayerNameCheckbox = _loc1_.playerNameCheckbox;
         this.markerBaseHpIndicatorCheckbox = _loc1_.hpIndicatorCheckbox;
         this.markerBaseAimMarker2DCheckbox = _loc1_.aimMarker2DCheckbox;
         this.markerBaseHpDropDown = _loc1_.hpDropDown;
         this.markerBaseDamageCheckbox = _loc1_.damageCheckbox;
         var _loc2_:SettingsMarkerContentForm = SettingsMarkerContentForm(this.scrollPaneAlt.target);
         this.markerAltVehicleDistCheckbox = _loc2_.vehicleDistCheckbox;
         this.markerAltIconCheckbox = _loc2_.iconCheckbox;
         this.markerAltLevelCheckbox = _loc2_.levelCheckbox;
         this.markerAltVehicleNameCheckbox = _loc2_.vehicleNameCheckbox;
         this.markerAltPlayerNameCheckbox = _loc2_.playerNameCheckbox;
         this.markerAltHpIndicatorCheckbox = _loc2_.hpIndicatorCheckbox;
         this.markerAltAimMarker2DCheckbox = _loc2_.aimMarker2DCheckbox;
         this.markerAltHpDropDown = _loc2_.hpDropDown;
         this.markerAltDamageCheckbox = _loc2_.damageCheckbox;
      }
      
      override public function get formId() : String
      {
         return this._formId;
      }
      
      private function onDropDownIndexChangeHandler(param1:ListEvent) : void
      {
         var _loc2_:DropdownMenu = null;
         var _loc3_:String = null;
         _loc2_ = DropdownMenu(param1.target);
         _loc3_ = _loc2_[CONTROL_ID_PROP];
         var _loc4_:String = getAltPrefix(_loc3_);
         dispatchEvent(new SettingsSubVewEvent(SettingsSubVewEvent.ON_CONTROL_CHANGE,this._formId,_loc3_,_loc2_.selectedIndex,_loc4_));
      }
      
      private function onCheckBoxSelectHandler(param1:Event) : void
      {
         var _loc2_:CheckBox = null;
         var _loc3_:String = null;
         _loc2_ = CheckBox(param1.target);
         _loc3_ = _loc2_[CONTROL_ID_PROP];
         var _loc4_:String = getAltPrefix(_loc3_);
         dispatchEvent(new SettingsSubVewEvent(SettingsSubVewEvent.ON_CONTROL_CHANGE,this._formId,_loc3_,_loc2_.selected,_loc4_));
      }
   }
}
