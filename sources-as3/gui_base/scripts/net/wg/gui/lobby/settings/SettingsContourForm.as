package net.wg.gui.lobby.settings
{
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.lobby.settings.components.RadioButtonBar;
   import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
   import net.wg.gui.lobby.settings.events.SettingsSubVewEvent;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterProps;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.events.ListEvent;
   
   public class SettingsContourForm extends SettingsNewCountersForm implements ISettingsAimForm
   {
      
      private static const BUTTONBAR_COUNTER_OFFSET_X:int = -7;
      
      private static const MAX_TOOLTIP_WIDTH:uint = 270;
      
      private static const INFO_DELTA:int = 10;
       
      
      public var contourButtonBar:RadioButtonBar = null;
      
      public var contourLabel:TextField = null;
      
      public var overlapContourEnabledLabel:TextField = null;
      
      public var contourPenetrableZoneLabel:LabelControl = null;
      
      public var contourPenetrableZoneDropDown:DropdownMenu = null;
      
      public var contourImpenetrableZoneLabel:LabelControl = null;
      
      public var contourImpenetrableZoneDropDown:DropdownMenu = null;
      
      public var overlapContourInfoIcon:InfoIcon = null;
      
      private var _formId:String = null;
      
      private var _data:Object = null;
      
      public function SettingsContourForm()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.contourLabel.text = SETTINGS.CURSOR_CONTOURLABEL;
         this.overlapContourEnabledLabel.text = SETTINGS.CURSOR_OVERLAPCONTOURLABEL;
         this.contourPenetrableZoneLabel.text = SETTINGS.CURSOR_CONTOURPENETRABLEZONE;
         this.contourImpenetrableZoneLabel.text = SETTINGS.CURSOR_CONTOURIMPENETRABLEZONE;
         this.overlapContourInfoIcon.tooltipMaxWidth = MAX_TOOLTIP_WIDTH;
         this.overlapContourInfoIcon.tooltip = SETTINGS.CURSOR_OVERLAPCONTOUR_TOOLTIP;
         this.overlapContourInfoIcon.icoType = InfoIcon.TYPE_WARNING;
         this.overlapContourInfoIcon.x = this.overlapContourEnabledLabel.x + this.overlapContourEnabledLabel.textWidth + INFO_DELTA ^ 0;
      }
      
      override protected function onDispose() : void
      {
         this.contourButtonBar.removeEventListener(ListEvent.INDEX_CHANGE,this.onButtonBarIndexChangeHandler);
         this.contourButtonBar.dispose();
         this.contourButtonBar = null;
         this.contourPenetrableZoneDropDown.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChangeHandler);
         this.contourPenetrableZoneDropDown.dispose();
         this.contourPenetrableZoneDropDown = null;
         this.contourImpenetrableZoneDropDown.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChangeHandler);
         this.contourImpenetrableZoneDropDown.dispose();
         this.contourImpenetrableZoneDropDown = null;
         this.contourLabel = null;
         this.overlapContourEnabledLabel = null;
         this.contourPenetrableZoneLabel.dispose();
         this.contourPenetrableZoneLabel = null;
         this.contourImpenetrableZoneLabel.dispose();
         this.contourImpenetrableZoneLabel = null;
         this.overlapContourInfoIcon.dispose();
         this.overlapContourInfoIcon = null;
         this._data = null;
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
      
      override protected function getCounterProps(param1:String) : ICounterProps
      {
         if(param1 == SettingsConfigHelper.TYPE_BUTTON_BAR)
         {
            return new CounterProps(BUTTONBAR_COUNTER_OFFSET_X,CounterProps.DEFAULT_OFFSET_Y,TextFormatAlign.LEFT,false,Linkages.COUNTER_LINE_UI);
         }
         return super.getCounterProps(param1);
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
         var _loc10_:RadioButtonBar = null;
         var _loc11_:int = 0;
         var _loc12_:DropdownMenu = null;
         var _loc13_:int = 0;
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
                  case SettingsConfigHelper.TYPE_BUTTON_BAR:
                     _loc10_ = this[_loc6_ + _loc7_.type];
                     _loc11_ = _loc7_.extraData.length;
                     _loc10_.dataProvider = new DataProvider(_loc7_.options);
                     _loc10_.setInfoIconTooltipWidth(MAX_TOOLTIP_WIDTH);
                     _loc13_ = 0;
                     while(_loc13_ < _loc11_)
                     {
                        _loc10_.setInfoButton(_loc7_.extraData[_loc13_].tooltip,_loc13_);
                        _loc13_++;
                     }
                     _loc10_.selectedIndex = int(_loc7_.current);
                     _loc10_.enabled = _loc8_;
                     _loc10_.addEventListener(IndexEvent.INDEX_CHANGE,this.onButtonBarIndexChangeHandler);
                     break;
                  case SettingsConfigHelper.TYPE_DROPDOWN:
                     _loc12_ = this[_loc6_ + _loc7_.type];
                     _loc12_.dataProvider = new DataProvider(_loc7_.options);
                     _loc12_.menuRowCount = _loc7_.options is Array ? Number(_loc7_.options.length) : Number(0);
                     _loc12_.selectedIndex = this.getSelectedIndex(_loc7_);
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
      
      protected function dispatchSettingSubVewEvent(param1:String, param2:Object) : void
      {
         dispatchEvent(new SettingsSubVewEvent(SettingsSubVewEvent.ON_CONTROL_CHANGE,this.formId,param1,param2));
      }
      
      private function disableAllControls() : void
      {
         this.contourButtonBar.enabled = false;
         this.contourPenetrableZoneDropDown.enabled = false;
         this.contourImpenetrableZoneDropDown.enabled = false;
      }
      
      private function getSelectedIndex(param1:SettingsControlProp) : int
      {
         var _loc2_:int = param1.options.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1.options[_loc3_].data == param1.current)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return Values.DEFAULT_INT;
      }
      
      override public function get formId() : String
      {
         return this._formId;
      }
      
      private function onButtonBarIndexChangeHandler(param1:IndexEvent) : void
      {
         var _loc2_:RadioButtonBar = RadioButtonBar(param1.target);
         var _loc3_:String = SettingsConfigHelper.instance.getControlIdByControlNameAndType(_loc2_.name,SettingsConfigHelper.TYPE_BUTTON_BAR);
         this.dispatchSettingSubVewEvent(_loc3_,_loc2_.selectedIndex);
      }
      
      private function onDropDownIndexChangeHandler(param1:ListEvent) : void
      {
         var _loc2_:DropdownMenu = DropdownMenu(param1.target);
         var _loc3_:String = SettingsConfigHelper.instance.getControlIdByControlNameAndType(_loc2_.name,SettingsConfigHelper.TYPE_DROPDOWN);
         dispatchEvent(new SettingsSubVewEvent(SettingsSubVewEvent.ON_CONTROL_CHANGE,this._formId,_loc3_,_loc2_.dataProvider[_loc2_.selectedIndex].data));
      }
   }
}
