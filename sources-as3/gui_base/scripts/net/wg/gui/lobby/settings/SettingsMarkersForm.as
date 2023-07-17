package net.wg.gui.lobby.settings
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropdownMenu;
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
      
      private static const COUNTER_CHECKBOX_OFFSET_X:Number = -6;
       
      
      public var markerHeader:TextField = null;
      
      public var markerHP:TextField = null;
      
      public var markerHeaderAlt:TextField = null;
      
      public var markerHPAlt:TextField = null;
      
      public var markerBaseIconCheckbox:CheckBox = null;
      
      public var markerBaseLevelCheckbox:CheckBox = null;
      
      public var markerBaseVehicleNameCheckbox:CheckBox = null;
      
      public var markerBasePlayerNameCheckbox:CheckBox = null;
      
      public var markerBaseHpIndicatorCheckbox:CheckBox = null;
      
      public var markerBaseHpDropDown:DropdownMenu = null;
      
      public var markerBaseDamageCheckbox:CheckBox = null;
      
      public var markerBaseAimMarker2DCheckbox:CheckBox = null;
      
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
      }
      
      override protected function getCounterProps(param1:String) : ICounterProps
      {
         if(param1 == SettingsConfigHelper.TYPE_CHECKBOX)
         {
            return new CounterProps(COUNTER_CHECKBOX_OFFSET_X,CounterProps.DEFAULT_OFFSET_Y,TextFormatAlign.LEFT,false,Linkages.COUNTER_LINE_UI);
         }
         return super.getCounterProps(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:SettingsControlProp = null;
         var _loc4_:int = 0;
         var _loc5_:CheckBox = null;
         var _loc6_:DropdownMenu = null;
         if(this._data && this._data.keys)
         {
            _loc1_ = Values.EMPTY_STR;
            _loc2_ = this._data.keys.length;
            _loc4_ = 0;
            for(; _loc4_ < _loc2_; _loc4_++)
            {
               _loc1_ = this._data.keys[_loc4_];
               _loc3_ = SettingsControlProp(this._data.values[_loc4_]);
               if(!this[_loc1_ + _loc3_.type])
               {
                  continue;
               }
               switch(_loc3_.type)
               {
                  case SettingsConfigHelper.TYPE_CHECKBOX:
                     _loc5_ = this[_loc1_ + _loc3_.type];
                     if(_loc5_.hasEventListener(Event.SELECT))
                     {
                        _loc5_.removeEventListener(Event.SELECT,this.onCheckBoxSelectHandler);
                     }
                     break;
                  case SettingsConfigHelper.TYPE_DROPDOWN:
                     _loc6_ = this[_loc1_ + _loc3_.type];
                     if(_loc6_.hasEventListener(ListEvent.INDEX_CHANGE))
                     {
                        _loc6_.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChangeHandler);
                     }
                     break;
               }
            }
            this._data = null;
         }
         this.markerHeader = null;
         this.markerHP = null;
         this.markerHeaderAlt = null;
         this.markerHPAlt = null;
         this.markerBaseIconCheckbox.dispose();
         this.markerBaseIconCheckbox = null;
         this.markerBaseLevelCheckbox.dispose();
         this.markerBaseLevelCheckbox = null;
         this.markerBaseVehicleNameCheckbox.dispose();
         this.markerBaseVehicleNameCheckbox = null;
         this.markerBasePlayerNameCheckbox.dispose();
         this.markerBasePlayerNameCheckbox = null;
         this.markerBaseHpIndicatorCheckbox.dispose();
         this.markerBaseHpIndicatorCheckbox = null;
         this.markerBaseHpDropDown.dispose();
         this.markerBaseHpDropDown = null;
         this.markerBaseDamageCheckbox.dispose();
         this.markerBaseDamageCheckbox = null;
         this.markerAltIconCheckbox.dispose();
         this.markerAltIconCheckbox = null;
         this.markerAltLevelCheckbox.dispose();
         this.markerAltLevelCheckbox = null;
         this.markerAltVehicleNameCheckbox.dispose();
         this.markerAltVehicleNameCheckbox = null;
         this.markerAltPlayerNameCheckbox.dispose();
         this.markerAltPlayerNameCheckbox = null;
         this.markerAltHpIndicatorCheckbox.dispose();
         this.markerAltHpIndicatorCheckbox = null;
         this.markerAltHpDropDown.dispose();
         this.markerAltHpDropDown = null;
         this.markerAltDamageCheckbox.dispose();
         this.markerAltDamageCheckbox = null;
         if(this.markerBaseAimMarker2DCheckbox)
         {
            this.markerBaseAimMarker2DCheckbox.dispose();
            this.markerBaseAimMarker2DCheckbox = null;
         }
         if(this.markerAltAimMarker2DCheckbox)
         {
            this.markerAltAimMarker2DCheckbox.dispose();
            this.markerAltAimMarker2DCheckbox = null;
         }
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
         var _loc3_:Vector.<String> = null;
         var _loc4_:Vector.<Object> = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:SettingsControlProp = null;
         var _loc8_:int = 0;
         var _loc9_:CheckBox = null;
         var _loc10_:DropdownMenu = null;
         this._formId = param1;
         if(param2 != null)
         {
            this._data = param2;
            _loc3_ = param2.keys;
            _loc4_ = param2.values;
            _loc5_ = _loc3_.length;
            _loc6_ = Values.EMPTY_STR;
            _loc7_ = null;
            _loc8_ = 0;
            for(; _loc8_ < _loc5_; _loc8_++)
            {
               _loc6_ = _loc3_[_loc8_];
               _loc7_ = _loc4_[_loc8_] as SettingsControlProp;
               App.utils.asserter.assertNotNull(_loc7_,"values[i] must be SettingsControlProp");
               if(!this[_loc6_ + _loc7_.type])
               {
                  continue;
               }
               switch(_loc7_.type)
               {
                  case SettingsConfigHelper.TYPE_CHECKBOX:
                     _loc9_ = this[_loc6_ + _loc7_.type];
                     _loc9_.selected = _loc7_.current;
                     _loc9_.enabled = _loc7_.readOnly == false;
                     _loc9_.addEventListener(Event.SELECT,this.onCheckBoxSelectHandler);
                     break;
                  case SettingsConfigHelper.TYPE_DROPDOWN:
                     _loc10_ = this[_loc6_ + _loc7_.type];
                     _loc10_.menuRowCount = _loc7_.options.length;
                     _loc10_.dataProvider = new DataProvider(_loc7_.options);
                     _loc10_.selectedIndex = int(_loc7_.current);
                     _loc10_.enabled = _loc7_.current != null && _loc7_.readOnly == false;
                     _loc10_.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChangeHandler);
                     break;
               }
            }
         }
         else
         {
            this.disableAllControls();
         }
      }
      
      private function getAltPrefix(param1:String) : String
      {
         return param1.indexOf(ALT_STR,0) >= 0 ? ALT_STR : Values.EMPTY_STR;
      }
      
      private function disableAllControls() : void
      {
         this.markerBaseIconCheckbox.enabled = false;
         this.markerBaseLevelCheckbox.enabled = false;
         this.markerBaseVehicleNameCheckbox.enabled = false;
         this.markerBasePlayerNameCheckbox.enabled = false;
         this.markerBaseHpIndicatorCheckbox.enabled = false;
         this.markerBaseHpDropDown.enabled = false;
         this.markerBaseDamageCheckbox.enabled = false;
         this.markerAltIconCheckbox.enabled = false;
         this.markerAltLevelCheckbox.enabled = false;
         this.markerAltVehicleNameCheckbox.enabled = false;
         this.markerAltPlayerNameCheckbox.enabled = false;
         this.markerAltHpIndicatorCheckbox.enabled = false;
         this.markerAltHpDropDown.enabled = false;
         this.markerAltDamageCheckbox.enabled = false;
      }
      
      override public function get formId() : String
      {
         return this._formId;
      }
      
      private function onDropDownIndexChangeHandler(param1:ListEvent) : void
      {
         var _loc2_:DropdownMenu = DropdownMenu(param1.target);
         var _loc3_:String = SettingsConfigHelper.instance.getControlIdByControlNameAndType(_loc2_.name,SettingsConfigHelper.TYPE_DROPDOWN);
         var _loc4_:String = this.getAltPrefix(_loc3_);
         dispatchEvent(new SettingsSubVewEvent(SettingsSubVewEvent.ON_CONTROL_CHANGE,this._formId,_loc3_,_loc2_.selectedIndex,_loc4_));
      }
      
      private function onCheckBoxSelectHandler(param1:Event) : void
      {
         var _loc2_:CheckBox = CheckBox(param1.target);
         var _loc3_:String = SettingsConfigHelper.instance.getControlIdByControlNameAndType(_loc2_.name,SettingsConfigHelper.TYPE_CHECKBOX);
         var _loc4_:String = this.getAltPrefix(_loc3_);
         dispatchEvent(new SettingsSubVewEvent(SettingsSubVewEvent.ON_CONTROL_CHANGE,this._formId,_loc3_,_loc2_.selected,_loc4_));
      }
   }
}
