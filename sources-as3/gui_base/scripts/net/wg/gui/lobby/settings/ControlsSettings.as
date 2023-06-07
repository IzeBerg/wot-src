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
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 255
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
      }
      
      public function isControlsChanged(param1:Boolean) : Boolean
      {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 84
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
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
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 161
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
      }
      
      private function onSetDefaultClickHandler(param1:ButtonEvent) : void
      {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 155
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
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
