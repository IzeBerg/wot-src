package net.wg.gui.lobby.settings
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.common.CounterBase;
   import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
   import net.wg.gui.lobby.settings.events.SettingViewEvent;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.SettingsTabNewCounterVo;
   import net.wg.gui.lobby.settings.vo.TabsDataVo;
   import net.wg.gui.lobby.settings.vo.VisitedCounters;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.counter.CounterManager;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.ICounterProps;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class SettingsNewCountersForm extends UIComponentEx
   {
      
      protected static const LINE_COUNTER_TYPES:Array = [SettingsConfigHelper.TYPE_BUTTON_BAR,SettingsConfigHelper.TYPE_CHECKBOX,SettingsConfigHelper.TYPE_STEP_SLIDER];
      
      private static const COUNTER_CHECKBOX_OFFSET_X:Number = -14;
      
      private static const COUNTER_BUTTON_BAR_OFFSET_X:Number = -7;
      
      private static const COUNTER_STEP_SLIDER_OFFSET_X:Number = -15;
      
      private static const COUNTER_STEP_SLIDER_OFFSET_Y:Number = -13;
      
      private static const COUNTER_KEY_INPUT_OFFSET_X:Number = -37;
      
      private static const COUNTER_KEY_INPUT_OFFSET_Y:Number = -24;
      
      private static const NEW_COUNTER_TAB_OFFSET_Y:int = 0;
      
      private static const INVALIDATE_BUTTON_BAR:String = "invalidateButtonBar";
      
      private static const INV_NEW_COUNTERS:String = "invNewCounters";
      
      private static const INVALIDATE_TABS_NEW_COUNTERS:String = "invalidateTabsNewCounters";
      
      private static const DEF_SETTINGS_COUNTER_CONTAINER_ID:String = "DEF_SETTINGS_COUNTER_CONTAINER_ID";
      
      private static const NEW_COUNTERS_CONTAINER_ID_DYNAMIC_POSTFIX:String = "_DYNAMIC";
      
      private static const FIELD_ENABLED:String = "enabled";
      
      private static const COUNTER_ERROR_MSG:String = "Can\'t set new counter for control by id ";
       
      
      private var _counterManager:ICounterManager;
      
      private var _settingsTabsNewCounters:Vector.<SettingsTabNewCounterVo> = null;
      
      private var _isButtonBarReady:Boolean = false;
      
      private var _counterStaticContainerId:String = "";
      
      private var _counterDynamicContainerId:String = "";
      
      public function SettingsNewCountersForm()
      {
         this._counterManager = App.utils.counterManager;
         super();
         this._counterStaticContainerId = this.getContainerId();
         this._counterDynamicContainerId = this._counterStaticContainerId + NEW_COUNTERS_CONTAINER_ID_DYNAMIC_POSTFIX;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:ButtonBarEx = this.getButtonBar();
         if(_loc1_)
         {
            _loc1_.addEventListener(Event.COMPLETE,this.onTabsCompleteHandler);
            _loc1_.addEventListener(IndexEvent.INDEX_CHANGE,this.onIndexChangeHandler);
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this._counterManager.disposeCountersForContainer(this._counterStaticContainerId);
         var _loc1_:Vector.<DisplayObject> = this._counterManager.disposeCountersForContainer(this._counterDynamicContainerId);
         if(_loc1_)
         {
            while(_loc1_.length)
            {
               _loc1_.pop().removeEventListener(MouseEvent.CLICK,this.onControlNewCounterClickHandler);
            }
         }
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this._counterManager = null;
         if(this._settingsTabsNewCounters)
         {
            this._settingsTabsNewCounters = null;
         }
         var _loc1_:ButtonBarEx = this.getButtonBar();
         if(_loc1_)
         {
            _loc1_.removeEventListener(Event.COMPLETE,this.onTabsCompleteHandler);
            _loc1_.removeEventListener(IndexEvent.INDEX_CHANGE,this.onIndexChangeHandler);
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._isButtonBarReady && isInvalid(INVALIDATE_BUTTON_BAR))
         {
            invalidate(INVALIDATE_TABS_NEW_COUNTERS);
         }
         if(this._isButtonBarReady && this._settingsTabsNewCounters && isInvalid(INVALIDATE_TABS_NEW_COUNTERS))
         {
            this.updateNewCountersForTabs();
         }
         if(this._settingsTabsNewCounters && isInvalid(INV_NEW_COUNTERS))
         {
            this.updateNewCountersControls(this._settingsTabsNewCounters);
         }
      }
      
      public function invalidateNewCounters(param1:Vector.<SettingsTabNewCounterVo>) : void
      {
         this._settingsTabsNewCounters = param1;
         invalidate(INV_NEW_COUNTERS,INVALIDATE_TABS_NEW_COUNTERS);
      }
      
      public function markVisitedCounters() : Array
      {
         var _loc2_:Array = null;
         var _loc3_:SettingsTabNewCounterVo = null;
         var _loc4_:ButtonBarEx = null;
         var _loc5_:TabsDataVo = null;
         var _loc6_:String = null;
         var _loc1_:Array = [];
         for each(_loc3_ in this._settingsTabsNewCounters)
         {
            if(StringUtils.isEmpty(_loc3_.subTabId))
            {
               _loc2_ = this.getLineCountersIds(null,_loc3_.counters);
               if(_loc2_.length)
               {
                  _loc1_.push(new VisitedCounters(this.viewId,null,_loc2_));
               }
            }
         }
         _loc4_ = this.getButtonBar();
         if(_loc4_)
         {
            _loc5_ = TabsDataVo(_loc4_.selectedItem);
            if(!_loc5_)
            {
               return _loc1_;
            }
            _loc6_ = _loc5_.linkage;
            _loc2_ = this.getTabLineCountersIds(_loc6_);
            if(_loc2_ && _loc2_.length)
            {
               _loc1_.push(new VisitedCounters(this.viewId,_loc6_,_loc2_));
            }
         }
         return _loc1_;
      }
      
      public function updateNewCounters(param1:Vector.<CountersVo>) : void
      {
         var _loc6_:CountersVo = null;
         var _loc2_:String = Values.EMPTY_STR;
         var _loc3_:DisplayObject = null;
         var _loc4_:SettingsControlProp = null;
         var _loc5_:ICounterProps = null;
         for each(_loc6_ in param1)
         {
            _loc2_ = _loc6_.componentId;
            _loc4_ = this.getControlPropsByKey(_loc2_);
            if(_loc4_)
            {
               _loc3_ = this.getControl(_loc2_,_loc4_.type);
               if(_loc3_)
               {
                  _loc5_ = this.getCounterProps(_loc4_.type);
                  this.addNewCounterControl(_loc3_,_loc6_.count,_loc5_,true);
               }
               else
               {
                  DebugUtils.LOG_WARNING(COUNTER_ERROR_MSG + _loc2_);
               }
            }
         }
      }
      
      protected function getButtonBarDP() : IDataProvider
      {
         return null;
      }
      
      protected function getContainerId() : String
      {
         return DEF_SETTINGS_COUNTER_CONTAINER_ID;
      }
      
      protected function getButtonBar() : ButtonBarEx
      {
         return null;
      }
      
      protected function getControlPropsByKey(param1:String) : SettingsControlProp
      {
         return null;
      }
      
      protected function updateNewCountersControls(param1:Vector.<SettingsTabNewCounterVo>) : void
      {
         var _loc2_:SettingsTabNewCounterVo = null;
         for each(_loc2_ in param1)
         {
            this.updateNewCounters(_loc2_.counters);
         }
      }
      
      protected function getCounterProps(param1:String) : ICounterProps
      {
         if(param1 == SettingsConfigHelper.TYPE_CHECKBOX)
         {
            return new CounterProps(COUNTER_CHECKBOX_OFFSET_X,CounterProps.DEFAULT_OFFSET_Y,TextFormatAlign.LEFT,false,Linkages.COUNTER_LINE_UI);
         }
         if(param1 == SettingsConfigHelper.TYPE_BUTTON_BAR)
         {
            return new CounterProps(COUNTER_BUTTON_BAR_OFFSET_X,CounterProps.DEFAULT_OFFSET_Y,TextFormatAlign.LEFT,false,Linkages.COUNTER_LINE_UI);
         }
         if(param1 == SettingsConfigHelper.TYPE_KEYINPUT_ITEM)
         {
            return new CounterProps(COUNTER_KEY_INPUT_OFFSET_X,COUNTER_KEY_INPUT_OFFSET_Y,TextFormatAlign.LEFT,true,Linkages.COUNTER_LINE_KEY_UI);
         }
         if(param1 == SettingsConfigHelper.TYPE_STEP_SLIDER)
         {
            return new CounterProps(COUNTER_STEP_SLIDER_OFFSET_X,COUNTER_STEP_SLIDER_OFFSET_Y,TextFormatAlign.LEFT,true,Linkages.COUNTER_LINE_UI);
         }
         return new CounterProps(CounterProps.DEFAULT_OFFSET_X,NEW_COUNTER_TAB_OFFSET_Y);
      }
      
      protected function getControl(param1:String, param2:String) : DisplayObject
      {
         return this[param1 + param2];
      }
      
      protected function getLineCountersIds(param1:String, param2:Vector.<CountersVo>) : Array
      {
         var _loc4_:SettingsControlProp = null;
         var _loc5_:CountersVo = null;
         var _loc3_:Array = [];
         for each(_loc5_ in param2)
         {
            if(_loc5_.count == CounterManager.DEF_COUNTER_NO_VIEWED_VALUE)
            {
               _loc4_ = this.getControlPropsByKey(_loc5_.componentId);
               if(_loc4_)
               {
                  if(LINE_COUNTER_TYPES.indexOf(_loc4_.type) != Values.DEFAULT_INT)
                  {
                     _loc3_.push(_loc5_.componentId);
                  }
               }
            }
         }
         return _loc3_;
      }
      
      protected function addNewCounterControl(param1:DisplayObject, param2:String, param3:ICounterProps, param4:Boolean) : void
      {
         var _loc5_:String = !!param4 ? this._counterDynamicContainerId : this._counterStaticContainerId;
         if(param2 == CounterBase.DEFAULT_EMPTY_VALUE)
         {
            param2 = null;
         }
         var _loc6_:int = this._counterManager.setCounter(param1,param2,_loc5_,param3);
         if(param4)
         {
            if(_loc6_ == CounterManager.COUNTER_REMOVED)
            {
               param1.removeEventListener(MouseEvent.CLICK,this.onControlNewCounterClickHandler);
            }
            else if(_loc6_ == CounterManager.COUNTER_ADDED)
            {
               param1.addEventListener(MouseEvent.CLICK,this.onControlNewCounterClickHandler);
            }
         }
      }
      
      protected function getTargetControlId(param1:DisplayObject) : String
      {
         return SettingsConfigHelper.instance.getControlIdByControl(param1);
      }
      
      private function onControlNewCounterClick(param1:DisplayObject) : void
      {
         var _loc2_:String = null;
         var _loc3_:SettingViewEvent = null;
         if(param1)
         {
            _loc2_ = this.getTargetControlId(param1);
            if(!_loc2_)
            {
               return;
            }
            _loc3_ = new SettingViewEvent(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,this.viewId,this.formId,null,[_loc2_]);
            dispatchEvent(_loc3_);
         }
      }
      
      private function updateNewCountersForTabs() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:SettingsTabNewCounterVo = null;
         var _loc6_:DisplayObject = null;
         var _loc7_:CountersVo = null;
         var _loc8_:ButtonBarEx = null;
         var _loc9_:int = 0;
         var _loc1_:IDataProvider = this.getButtonBarDP();
         if(_loc1_)
         {
            _loc2_ = _loc1_.length;
            _loc3_ = 0;
            _loc4_ = null;
            _loc5_ = null;
            _loc6_ = null;
            _loc8_ = this.getButtonBar();
            _loc9_ = 0;
            while(_loc9_ < _loc2_)
            {
               _loc4_ = TabsDataVo(_loc1_[_loc9_]).linkage;
               _loc3_ = 0;
               for each(_loc5_ in this._settingsTabsNewCounters)
               {
                  if(_loc5_.subTabId == _loc4_)
                  {
                     _loc6_ = _loc8_.getButtonAt(_loc9_);
                     if(_loc6_)
                     {
                        for each(_loc7_ in _loc5_.counters)
                        {
                           if(_loc7_.count == CounterManager.DEF_COUNTER_NO_VIEWED_VALUE)
                           {
                              _loc3_++;
                           }
                        }
                        this.addNewCounterControl(_loc6_,_loc3_.toString(),this.getCounterProps(_loc4_),false);
                     }
                  }
               }
               _loc9_++;
            }
         }
      }
      
      private function getTabLineCountersIds(param1:String) : Array
      {
         var _loc2_:SettingsTabNewCounterVo = null;
         for each(_loc2_ in this._settingsTabsNewCounters)
         {
            if(_loc2_.subTabId == param1)
            {
               return this.getLineCountersIds(param1,_loc2_.counters);
            }
         }
         return null;
      }
      
      public function get formId() : String
      {
         return Values.EMPTY_STR;
      }
      
      public function get viewId() : String
      {
         return Values.EMPTY_STR;
      }
      
      private function onIndexChangeHandler(param1:IndexEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:IDataProvider = null;
         var _loc5_:Array = null;
         var _loc6_:TabsDataVo = null;
         var _loc2_:int = param1.lastIndex;
         if(_loc2_ != Values.DEFAULT_INT)
         {
            _loc3_ = null;
            _loc4_ = this.getButtonBarDP();
            if(_loc4_)
            {
               _loc6_ = TabsDataVo(_loc4_.requestItemAt(_loc2_));
               if(_loc6_)
               {
                  _loc3_ = _loc6_.linkage;
               }
            }
            if(StringUtils.isEmpty(_loc3_))
            {
               return;
            }
            _loc5_ = this.getTabLineCountersIds(_loc3_);
            if(_loc5_ && _loc5_.length > 0)
            {
               dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,this.viewId,_loc3_,null,_loc5_));
            }
         }
      }
      
      private function onControlNewCounterClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = param1.currentTarget as DisplayObject;
         if(_loc2_.hasOwnProperty(FIELD_ENABLED) && !_loc2_[FIELD_ENABLED])
         {
            return;
         }
         this.onControlNewCounterClick(_loc2_);
      }
      
      private function onTabsCompleteHandler(param1:Event) : void
      {
         this._isButtonBarReady = true;
         invalidate(INVALIDATE_BUTTON_BAR);
      }
   }
}
