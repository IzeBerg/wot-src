package net.wg.gui.lobby.settings
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.KeyProps;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.events.ListEventEx;
   import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
   import net.wg.gui.lobby.settings.events.SettingViewEvent;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.SettingsKeyProp;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   import net.wg.utils.ICounterProps;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.SliderEvent;
   
   public class ControlsSettings extends ControlsSettingsBase
   {
      
      private static const CONTROLS_COUNTER_CONTAINER_ID:String = "CONTROLS_COUNTER_CONTAINER_ID ";
       
      
      private var _isControlsChanged:Boolean;
      
      public function ControlsSettings()
      {
         super();
      }
      
      override public function needDataWithChanges() : Boolean
      {
         return true;
      }
      
      override public function toString() : String
      {
         return "[WG ControlsSettings " + name + "]";
      }
      
      override public function updateNewCounters(param1:Vector.<CountersVo>) : void
      {
         this.updateKeysNewCounters(param1);
         super.updateNewCounters(param1);
      }
      
      override protected function getContainerId() : String
      {
         return CONTROLS_COUNTER_CONTAINER_ID;
      }
      
      override protected function onBeforeDispose() : void
      {
         defaultBtn.removeEventListener(ButtonEvent.CLICK,this.onSetDefaultClickHandler);
         keys.removeEventListener(ListEventEx.ITEM_TEXT_CHANGE,this.onKeysItemTextChangeHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:Vector.<String> = null;
         var _loc2_:Vector.<Object> = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:SettingsControlProp = null;
         var _loc7_:CheckBox = null;
         var _loc8_:Slider = null;
         if(data && data.keys)
         {
            _loc1_ = data.keys;
            _loc2_ = data.values;
            _loc3_ = _loc1_.length;
            _loc4_ = Values.EMPTY_STR;
            _loc5_ = 0;
            for(; _loc5_ < _loc3_; _loc5_++)
            {
               _loc4_ = _loc1_[_loc5_];
               if(!(_loc2_[_loc5_] is SettingsControlProp))
               {
                  continue;
               }
               _loc6_ = SettingsControlProp(_loc2_[_loc5_]);
               if(!this[_loc4_ + _loc6_.type])
               {
                  continue;
               }
               switch(_loc6_.type)
               {
                  case SettingsConfigHelper.TYPE_CHECKBOX:
                     _loc7_ = CheckBox(this[_loc4_ + _loc6_.type]);
                     if(_loc7_.hasEventListener(Event.SELECT))
                     {
                        _loc7_.removeEventListener(Event.SELECT,this.onCheckBoxSelectHandler);
                     }
                     break;
                  case SettingsConfigHelper.TYPE_SLIDER:
                     _loc8_ = Slider(this[_loc4_ + _loc6_.type]);
                     if(_loc8_.hasEventListener(SliderEvent.VALUE_CHANGE))
                     {
                        _loc8_.removeEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChangeHandler);
                     }
                     break;
               }
            }
         }
         super.onDispose();
      }
      
      override protected function getTargetControlId(param1:DisplayObject) : String
      {
         var _loc2_:String = super.getTargetControlId(param1);
         if(!_loc2_ && param1.name)
         {
            _loc2_ = param1.name;
         }
         return _loc2_;
      }
      
      override protected function setData(param1:SettingsDataVo) : void
      {
         var _loc5_:String = null;
         var _loc6_:Object = null;
         var _loc7_:Boolean = false;
         var _loc9_:CheckBox = null;
         var _loc10_:Slider = null;
         var _loc11_:SettingsDataVo = null;
         var _loc12_:Array = null;
         super.setData(param1);
         var _loc2_:Vector.<String> = param1.keys;
         var _loc3_:Vector.<Object> = param1.values;
         var _loc4_:int = _loc2_.length;
         _loc5_ = Values.EMPTY_STR;
         _loc6_ = null;
         var _loc8_:int = 0;
         while(_loc8_ < _loc4_)
         {
            _loc5_ = _loc2_[_loc8_];
            if(_loc3_[_loc8_] is SettingsControlProp)
            {
               _loc6_ = _loc3_[_loc8_] as SettingsControlProp;
               App.utils.asserter.assertNotNull(_loc6_,"valuesView[i] must be SettingsControlProp");
               _loc7_ = !(_loc6_.current == null || _loc6_.readOnly);
               if(this[_loc5_ + _loc6_.type])
               {
                  switch(_loc6_.type)
                  {
                     case SettingsConfigHelper.TYPE_CHECKBOX:
                        _loc9_ = CheckBox(this[_loc5_ + _loc6_.type]);
                        _loc9_.selected = _loc6_.current;
                        _loc9_.addEventListener(Event.SELECT,this.onCheckBoxSelectHandler);
                        _loc9_.enabled = _loc7_;
                        break;
                     case SettingsConfigHelper.TYPE_SLIDER:
                        _loc10_ = Slider(this[_loc5_ + _loc6_.type]);
                        _loc10_.value = _loc6_.current;
                        _loc10_.addEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChangeHandler);
                        _loc10_.enabled = _loc7_;
                  }
               }
            }
            else if(_loc5_ == SettingsConfigHelper.KEYBOARD)
            {
               _loc11_ = _loc3_[_loc8_] as SettingsDataVo;
               App.utils.asserter.assertNotNull(_loc11_,"valuesView[i] must be SettingsDataVo");
               _loc12_ = this.createDataProviderForKeys(_loc11_,data[SettingsConfigHelper.KEYS_LAYOUT_ORDER]);
               keys.dataProvider = new DataProvider(_loc12_);
               keys.addEventListener(ListEventEx.ITEM_TEXT_CHANGE,this.onKeysItemTextChangeHandler);
               keys.validateNow();
            }
            _loc8_++;
         }
         defaultBtn.addEventListener(ButtonEvent.CLICK,this.onSetDefaultClickHandler);
         this.checkEnabledSetDefBtn();
      }
      
      public function isControlsChanged(param1:Boolean) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc5_:Object = null;
         var _loc2_:Boolean = this._isControlsChanged;
         this._isControlsChanged = false;
         var _loc4_:Vector.<String> = SettingsConfigHelper.instance.settingsData[SettingsConfigHelper.CONTROLS_SETTINGS][SettingsConfigHelper.KEYBOARD_IMPORTANT_BINDS];
         for each(_loc5_ in keys.dataProvider)
         {
            if(KeyProps.KEY_NONE == _loc5_.key && _loc4_.indexOf(_loc5_.id) != -1)
            {
               _loc3_ = true;
               break;
            }
         }
         return !!param1 ? _loc2_ && _loc3_ : Boolean(_loc3_);
      }
      
      private function updateKeysNewCounters(param1:Vector.<CountersVo>) : void
      {
         var _loc4_:CountersVo = null;
         var _loc2_:DisplayObject = null;
         var _loc3_:ICounterProps = getCounterProps(SettingsConfigHelper.TYPE_KEYINPUT_ITEM);
         for each(_loc4_ in param1)
         {
            _loc2_ = keys.getChildByName(_loc4_.componentId);
            if(_loc2_)
            {
               addNewCounterControl(_loc2_,_loc4_.count,_loc3_,true);
            }
         }
      }
      
      private function createDataProviderForKeys(param1:SettingsDataVo, param2:Vector.<String>) : Array
      {
         var _loc6_:String = null;
         var _loc3_:Array = [];
         var _loc4_:uint = param2.length;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param2[_loc5_];
            _loc3_.push(SettingsKeyProp(param1.getByKey(_loc6_)).getObject());
            _loc5_++;
         }
         return _loc3_;
      }
      
      private function checkEnabledSetDefBtn() : void
      {
         defaultBtn.enabled = keys.keysWasChanged() || this.controlsChanged();
      }
      
      private function controlsChanged() : Boolean
      {
         var _loc2_:Vector.<String> = null;
         var _loc3_:Vector.<Object> = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:SettingsControlProp = null;
         var _loc8_:CheckBox = null;
         var _loc9_:Slider = null;
         var _loc1_:Boolean = false;
         if(data)
         {
            _loc2_ = data.keys;
            _loc3_ = data.values;
            _loc4_ = _loc2_.length;
            _loc5_ = Values.EMPTY_STR;
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc5_ = _loc2_[_loc6_];
               if(_loc3_[_loc6_] is SettingsControlProp)
               {
                  _loc7_ = SettingsControlProp(_loc3_[_loc6_]);
                  if(this[_loc5_ + _loc7_.type])
                  {
                     switch(_loc7_.type)
                     {
                        case SettingsConfigHelper.TYPE_CHECKBOX:
                           _loc8_ = CheckBox(this[_loc5_ + _loc7_.type]);
                           _loc1_ = _loc8_.selected != _loc7_.defaultValue;
                           break;
                        case SettingsConfigHelper.TYPE_SLIDER:
                           _loc9_ = Slider(this[_loc5_ + _loc7_.type]);
                           _loc1_ = _loc9_.value != _loc7_.defaultValue;
                     }
                  }
               }
               if(_loc1_)
               {
                  break;
               }
               _loc6_++;
            }
         }
         return _loc1_;
      }
      
      private function onSetDefaultClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:Vector.<String> = null;
         var _loc3_:Vector.<Object> = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:SettingsControlProp = null;
         var _loc8_:CheckBox = null;
         var _loc9_:Slider = null;
         keys.restoreDefault();
         this._isControlsChanged = true;
         if(data)
         {
            _loc2_ = data.keys;
            _loc3_ = data.values;
            _loc4_ = _loc2_.length;
            _loc5_ = Values.EMPTY_STR;
            _loc6_ = 0;
            for(; _loc6_ < _loc4_; _loc6_++)
            {
               _loc5_ = _loc2_[_loc6_];
               if(!(_loc3_[_loc6_] is SettingsControlProp))
               {
                  continue;
               }
               _loc7_ = SettingsControlProp(_loc3_[_loc6_]);
               if(!this[_loc5_ + _loc7_.type])
               {
                  continue;
               }
               switch(_loc7_.type)
               {
                  case SettingsConfigHelper.TYPE_CHECKBOX:
                     _loc8_ = CheckBox(this[_loc5_ + _loc7_.type]);
                     _loc8_.selected = _loc7_.defaultValue;
                     break;
                  case SettingsConfigHelper.TYPE_SLIDER:
                     _loc9_ = Slider(this[_loc5_ + _loc7_.type]);
                     _loc9_.value = Number(_loc7_.defaultValue);
                     break;
               }
            }
         }
      }
      
      private function onSliderValueChangeHandler(param1:SliderEvent) : void
      {
         var _loc2_:Slider = Slider(param1.target);
         var _loc3_:String = SettingsConfigHelper.instance.getControlIdByControlNameAndType(_loc2_.name,SettingsConfigHelper.TYPE_SLIDER);
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,_loc3_,_loc2_.value));
         this.checkEnabledSetDefBtn();
      }
      
      private function onCheckBoxSelectHandler(param1:Event) : void
      {
         var _loc2_:CheckBox = CheckBox(param1.target);
         var _loc3_:String = SettingsConfigHelper.instance.getControlIdByControlNameAndType(_loc2_.name,SettingsConfigHelper.TYPE_CHECKBOX);
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,_loc3_,_loc2_.selected));
         this.checkEnabledSetDefBtn();
      }
      
      private function onKeysItemTextChangeHandler(param1:ListEventEx) : void
      {
         this._isControlsChanged = true;
         keys.updateDataProvider();
         var _loc2_:String = param1.itemData.id;
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,SettingsConfigHelper.KEYBOARD,_loc2_,param1.controllerIdx));
         this.checkEnabledSetDefBtn();
         if(_loc2_ == SettingsConfigHelper.PUSH_TO_TALK)
         {
            dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_PTT_CONTROL_CHANGED,viewId,null,_loc2_,param1.controllerIdx));
         }
      }
   }
}
