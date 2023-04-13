package net.wg.gui.lobby.settings.feedback.ribbons
{
   import flash.display.DisplayObject;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_EFFICIENCY_TYPES;
   import net.wg.gui.components.common.CounterBase;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
   import net.wg.gui.lobby.settings.feedback.FeedbackBaseForm;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.infrastructure.interfaces.IDisplayObject;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterProps;
   import scaleform.clik.core.UIComponent;
   
   public class BattleRibbonsForm extends FeedbackBaseForm
   {
      
      private static const SCROLL_STEP_FACTOR:int = 30;
      
      private static const RIBBONS_COUNTER_CONTAINER_ID:String = "RIBBONS_COUNTER_CONTAINER_ID ";
      
      private static const COUNTER_CHECKBOX_OFFSET_X:Number = -27;
       
      
      public var ribbonsContainer:SettingsRibbonContainer = null;
      
      public var controlsContainer:ControlsContainer = null;
      
      public var controlsScrollBar:ScrollBar = null;
      
      public var controlsScrollPane:ResizableScrollPane = null;
      
      public var ribbonsScrollBar:ScrollBar = null;
      
      public var ribbonsScrollPane:ResizableScrollPane = null;
      
      private var _itemsMap:Dictionary = null;
      
      private var _countSelectedItems:int = 0;
      
      public function BattleRibbonsForm()
      {
         super();
         this._itemsMap = new Dictionary();
         this._itemsMap[this.getControlByName("battleEventsReceivedDamageCheckbox").name] = BATTLE_EFFICIENCY_TYPES.RECEIVED_DAMAGE;
         this._itemsMap[this.getControlByName("battleEventsReceivedCritsCheckbox").name] = BATTLE_EFFICIENCY_TYPES.RECEIVED_CRITS;
         this._itemsMap["battleEventsBlockedDamageCheckbox"] = BATTLE_EFFICIENCY_TYPES.ARMOR;
         this._itemsMap["battleEventsEnemyBurningCheckbox"] = BATTLE_EFFICIENCY_TYPES.BURN;
         this._itemsMap["battleEventsEnemyRamAttackCheckbox"] = BATTLE_EFFICIENCY_TYPES.RAM;
         this._itemsMap["battleEventsEnemyHpDamageCheckbox"] = BATTLE_EFFICIENCY_TYPES.DAMAGE;
         this._itemsMap["battleEventsEnemyDetectionDamageCheckbox"] = BATTLE_EFFICIENCY_TYPES.ASSIST_SPOT;
         this._itemsMap["battleEventsEnemyTrackDamageCheckbox"] = BATTLE_EFFICIENCY_TYPES.ASSIST_TRACK;
         this._itemsMap["battleEventsEnemyDetectionCheckbox"] = BATTLE_EFFICIENCY_TYPES.DETECTION;
         this._itemsMap["battleEventsEnemyKillCheckbox"] = BATTLE_EFFICIENCY_TYPES.DESTRUCTION;
         this._itemsMap["battleEventsBaseCaptureDropCheckbox"] = BATTLE_EFFICIENCY_TYPES.DEFENCE;
         this._itemsMap["battleEventsBaseCaptureCheckbox"] = BATTLE_EFFICIENCY_TYPES.CAPTURE;
         this._itemsMap["battleEventsEnemyCriticalHitCheckbox"] = BATTLE_EFFICIENCY_TYPES.CRITS;
         this._itemsMap["battleEventsEnemyWorldCollisionCheckbox"] = BATTLE_EFFICIENCY_TYPES.WORLD_COLLISION;
         this._itemsMap["battleEventsEnemyAssistStunCheckbox"] = BATTLE_EFFICIENCY_TYPES.ASSIST_STUN;
         this._itemsMap["battleEventsEnemyStunCheckbox"] = BATTLE_EFFICIENCY_TYPES.STUN;
      }
      
      override protected function getControlByName(param1:String) : IDisplayObject
      {
         return this.controlsContainer.getControlByName(param1) || super.getControlByName(param1);
      }
      
      override protected function getControl(param1:String, param2:String) : DisplayObject
      {
         return this.getControlByName(param1 + param2) as DisplayObject;
      }
      
      override public function updateNewCounters(param1:Vector.<CountersVo>) : void
      {
         var _loc6_:CountersVo = null;
         super.updateNewCounters(param1);
         var _loc2_:String = Values.EMPTY_STR;
         var _loc3_:DisplayObject = null;
         var _loc4_:ControlsGroup = null;
         var _loc5_:SettingsControlProp = null;
         for each(_loc6_ in param1)
         {
            _loc2_ = _loc6_.componentId;
            _loc5_ = getControlPropsByKey(_loc2_);
            if(_loc5_)
            {
               _loc3_ = this.getControl(_loc2_,_loc5_.type);
               if(_loc3_ && _loc6_.count != CounterBase.DEFAULT_EMPTY_VALUE)
               {
                  _loc4_ = _loc3_.parent.parent as ControlsGroup;
                  if(_loc4_)
                  {
                     _loc4_.isOpen = true;
                  }
               }
            }
         }
      }
      
      override protected function getCounterProps(param1:String) : ICounterProps
      {
         if(param1 == SettingsConfigHelper.TYPE_CHECKBOX)
         {
            return new CounterProps(COUNTER_CHECKBOX_OFFSET_X,CounterProps.DEFAULT_OFFSET_Y,TextFormatAlign.LEFT,false,Linkages.COUNTER_LINE_UI);
         }
         return super.getCounterProps(param1);
      }
      
      override public function updateContent(param1:Object) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:CheckBox = null;
         var _loc4_:* = null;
         super.updateContent(param1);
         this._countSelectedItems = 0;
         for(_loc4_ in this._itemsMap)
         {
            _loc3_ = CheckBox(this.getControlByName(_loc4_));
            _loc2_ = _loc3_.selected;
            this.ribbonsContainer.updateItemVisible(this._itemsMap[_loc4_],_loc2_);
            if(_loc2_)
            {
               ++this._countSelectedItems;
            }
         }
         this.ribbonsContainer.redraw();
         this.ribbonsContainer.updateSettings(this.controlsContainer.battleEventsEventNameCheckbox.selected,this.controlsContainer.battleEventsVehicleInfoCheckbox.selected);
         this.setEventsCheckboxesEnabled();
      }
      
      override protected function getContainerId() : String
      {
         return RIBBONS_COUNTER_CONTAINER_ID;
      }
      
      override protected function onCheckBoxSelected(param1:CheckBox) : void
      {
         var _loc2_:* = null;
         super.onCheckBoxSelected(param1);
         if(this._itemsMap.hasOwnProperty(param1.name))
         {
            if(this._countSelectedItems == 0)
            {
               this.controlsContainer.battleEventsShowInBattleCheckbox.selected = false;
            }
         }
         else if(this._countSelectedItems == 0 && param1 == this.controlsContainer.battleEventsShowInBattleCheckbox && param1.selected)
         {
            for(_loc2_ in this._itemsMap)
            {
               CheckBox(this.getControlByName(_loc2_)).selected = true;
            }
            this.controlsContainer.battleEventsEventNameCheckbox.selected = true;
            this.controlsContainer.battleEventsVehicleInfoCheckbox.selected = true;
         }
      }
      
      override protected function onDispose() : void
      {
         App.utils.data.cleanupDynamicObject(this._itemsMap);
         this._itemsMap = null;
         this.ribbonsContainer.dispose();
         this.ribbonsContainer = null;
         this.controlsContainer.dispose();
         this.controlsContainer = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.controlsScrollPane.scrollBar = this.controlsScrollBar;
         this.controlsScrollPane.scrollStepFactor = SCROLL_STEP_FACTOR;
         this.controlsScrollPane.target = this.controlsContainer;
         this.controlsScrollPane.scrollPosition = 0;
         this.controlsScrollPane.setSize(200,492);
         this.ribbonsScrollPane.scrollBar = this.ribbonsScrollBar;
         this.ribbonsScrollPane.scrollStepFactor = SCROLL_STEP_FACTOR;
         this.ribbonsContainer.x -= this.ribbonsScrollPane.x;
         this.ribbonsContainer.y -= this.ribbonsScrollPane.y;
         this.ribbonsScrollPane.target = this.ribbonsContainer;
         this.ribbonsScrollPane.scrollPosition = this.ribbonsScrollPane.maxScroll;
         this.ribbonsScrollPane.setSize(550,492);
      }
      
      private function setEventsCheckboxesEnabled() : void
      {
         var _loc2_:* = null;
         var _loc1_:Boolean = this.controlsContainer.battleEventsShowInBattleCheckbox.selected && this.controlsContainer.battleEventsShowInBattleCheckbox.enabled;
         for(_loc2_ in this._itemsMap)
         {
            setElementEnabled(UIComponent(this.getControlByName(_loc2_)),_loc1_);
         }
         setElementEnabled(this.controlsContainer.battleEventsEventNameCheckbox,_loc1_);
         setElementEnabled(this.controlsContainer.battleEventsVehicleInfoCheckbox,_loc1_);
         this.ribbonsScrollPane.alpha = this.ribbonsScrollBar.alpha = int(_loc1_);
      }
      
      override public function get formId() : String
      {
         return Linkages.FEEDBACK_BATTLE_EVENTS;
      }
   }
}
