package net.wg.gui.lobby.settings
{
   import flash.events.Event;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
   import net.wg.gui.lobby.settings.events.SettingsSubVewEvent;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterProps;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   
   public class SettingsArtyForm extends SettingsNewCountersForm implements ISettingsAimForm
   {
      
      private static const CHECKBOX_COUNTER_OFFSET_X:int = -7;
       
      
      public var shotsResultIndicatorCheckbox:CheckBox = null;
      
      public var spgScaleWidgetCheckbox:CheckBox = null;
      
      public var autoChangeAimModeCheckbox:CheckBox = null;
      
      public var spgStrategicCamModeLabel:LabelControl = null;
      
      public var spgStrategicCamModeDropDown:DropdownMenu = null;
      
      public var aimEntranceModeLabel:LabelControl = null;
      
      public var aimEntranceModeDropDown:DropdownMenu = null;
      
      private var _formId:String = null;
      
      private var _data:Object = null;
      
      public function SettingsArtyForm()
      {
         super();
         this.shotsResultIndicatorCheckbox.multiline = this.spgScaleWidgetCheckbox.multiline = this.autoChangeAimModeCheckbox.multiline = true;
         this.shotsResultIndicatorCheckbox.wordWrap = this.spgScaleWidgetCheckbox.wordWrap = this.autoChangeAimModeCheckbox.wordWrap = true;
      }
      
      override protected function onDispose() : void
      {
         this.shotsResultIndicatorCheckbox.removeEventListener(Event.SELECT,this.onCheckBoxSelectHandler);
         this.shotsResultIndicatorCheckbox.dispose();
         this.shotsResultIndicatorCheckbox = null;
         this.spgScaleWidgetCheckbox.removeEventListener(Event.SELECT,this.onCheckBoxSelectHandler);
         this.spgScaleWidgetCheckbox.dispose();
         this.spgScaleWidgetCheckbox = null;
         this.autoChangeAimModeCheckbox.removeEventListener(Event.SELECT,this.onCheckBoxSelectHandler);
         this.autoChangeAimModeCheckbox.dispose();
         this.autoChangeAimModeCheckbox = null;
         this.spgStrategicCamModeLabel.dispose();
         this.spgStrategicCamModeLabel = null;
         this.spgStrategicCamModeDropDown.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChangeHandler);
         this.spgStrategicCamModeDropDown.dispose();
         this.spgStrategicCamModeDropDown = null;
         this.aimEntranceModeLabel.dispose();
         this.aimEntranceModeLabel = null;
         this.aimEntranceModeDropDown.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChangeHandler);
         this.aimEntranceModeDropDown.dispose();
         this.aimEntranceModeDropDown = null;
         this._data = null;
         super.onDispose();
      }
      
      public function setData(param1:String, param2:Object) : void
      {
         var _loc3_:Vector.<String> = null;
         var _loc4_:Vector.<Object> = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:SettingsControlProp = null;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         var _loc10_:CheckBox = null;
         var _loc11_:LabelControl = null;
         var _loc12_:DropdownMenu = null;
         this._formId = param1;
         if(param2 != null)
         {
            this._data = param2;
            _loc3_ = param2.keys;
            _loc4_ = param2.values;
            _loc5_ = _loc3_.length;
            _loc6_ = param2.EMPTY_STR;
            _loc7_ = null;
            _loc9_ = 0;
            for(; _loc9_ < _loc5_; _loc9_++)
            {
               _loc6_ = _loc3_[_loc9_];
               _loc7_ = _loc4_[_loc9_] as SettingsControlProp;
               App.utils.asserter.assertNotNull(_loc7_," values[i] must be SettingsControlProp");
               _loc8_ = !(_loc7_.current == null || _loc7_.readOnly);
               if(!this[_loc6_ + _loc7_.type])
               {
                  continue;
               }
               switch(_loc7_.type)
               {
                  case SettingsConfigHelper.TYPE_CHECKBOX:
                     _loc10_ = this[_loc6_ + _loc7_.type];
                     _loc10_.label = _loc7_.extraData.checkBoxLabel;
                     _loc10_.toolTip = _loc7_.extraData.tooltip;
                     if(_loc10_.toolTip != null)
                     {
                        _loc10_.infoIcoType = InfoIcon.TYPE_INFO;
                     }
                     _loc10_.selected = _loc7_.current;
                     _loc10_.enabled = _loc8_;
                     _loc10_.addEventListener(Event.SELECT,this.onCheckBoxSelectHandler);
                     break;
                  case SettingsConfigHelper.TYPE_DROPDOWN:
                     _loc11_ = this[_loc6_ + SettingsConfigHelper.TYPE_LABEL];
                     _loc11_.text = _loc7_.extraData.label;
                     _loc11_.toolTip = _loc7_.extraData.tooltip;
                     if(_loc11_.toolTip != null)
                     {
                        _loc11_.infoIcoType = InfoIcon.TYPE_INFO;
                     }
                     _loc12_ = this[_loc6_ + _loc7_.type];
                     _loc12_.dataProvider = new DataProvider(_loc7_.options);
                     _loc12_.menuRowCount = _loc7_.options is Array ? Number(_loc7_.options.length) : Number(0);
                     _loc12_.selectedIndex = int(_loc7_.current);
                     _loc12_.enabled = _loc8_;
                     _loc12_.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChangeHandler);
                     break;
               }
            }
         }
         else
         {
            this.disableAllControls();
         }
      }
      
      override public function get formId() : String
      {
         return this._formId;
      }
      
      override protected function getControlPropsByKey(param1:String) : SettingsControlProp
      {
         if(this._data && this._data[param1])
         {
            return this._data[param1];
         }
         return super.getControlPropsByKey(param1);
      }
      
      override protected function getCounterProps(param1:String) : ICounterProps
      {
         if(param1 == SettingsConfigHelper.TYPE_CHECKBOX)
         {
            return new CounterProps(CHECKBOX_COUNTER_OFFSET_X,CounterProps.DEFAULT_OFFSET_Y,TextFormatAlign.LEFT,false,Linkages.COUNTER_LINE_UI);
         }
         return super.getCounterProps(param1);
      }
      
      private function disableAllControls() : void
      {
         this.shotsResultIndicatorCheckbox.enabled = this.spgScaleWidgetCheckbox.enabled = this.autoChangeAimModeCheckbox.enabled = this.spgStrategicCamModeLabel.enabled = this.spgStrategicCamModeDropDown.enabled = this.aimEntranceModeLabel.enabled = this.aimEntranceModeDropDown.enabled = false;
      }
      
      private function onDropDownIndexChangeHandler(param1:ListEvent) : void
      {
         var _loc2_:DropdownMenu = DropdownMenu(param1.target);
         var _loc3_:String = SettingsConfigHelper.instance.getControlIdByControlNameAndType(_loc2_.name,SettingsConfigHelper.TYPE_DROPDOWN);
         dispatchEvent(new SettingsSubVewEvent(SettingsSubVewEvent.ON_CONTROL_CHANGE,this._formId,_loc3_,_loc2_.selectedIndex));
      }
      
      private function onCheckBoxSelectHandler(param1:Event) : void
      {
         var _loc2_:CheckBox = CheckBox(param1.target);
         var _loc3_:String = SettingsConfigHelper.instance.getControlIdByControlNameAndType(_loc2_.name,SettingsConfigHelper.TYPE_CHECKBOX);
         var _loc4_:Boolean = _loc2_.selected;
         dispatchEvent(new SettingsSubVewEvent(SettingsSubVewEvent.ON_CONTROL_CHANGE,this._formId,_loc3_,_loc4_));
      }
   }
}
