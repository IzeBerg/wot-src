package net.wg.gui.battle.commander.views.vehiclesPanel
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.BATTLE_CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.gui.battle.commander.VO.daapi.DAAPICommanderDataVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPICommanderInfoVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPISuppliesDataVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPIVehicleCommanderDataVO;
   import net.wg.infrastructure.base.meta.IVehiclesPanelMeta;
   import net.wg.infrastructure.base.meta.impl.VehiclesPanelMeta;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IRTSBattleStatisticDataController;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.events.ComponentEvent;
   
   public class VehiclesPanel extends VehiclesPanelMeta implements IVehiclesPanelMeta, IRTSBattleStatisticDataController, IBattleComponentDataController
   {
      
      private static const ITEM_RENDERER:String = "VehiclesPanelItemUI";
      
      private static const CONTAINER_MARGIN_WIDTH:Number = 11;
      
      private static const CONTAINER_MARGIN_WIDTH_BIG:Number = 0;
      
      private static const COMMANDER_DAMAGE_LOG_OFFSET:Number = 80;
       
      
      public var bg:Sprite = null;
      
      public var container:Sprite = null;
      
      private var _visibleItems:Vector.<VehiclesPanelItem>;
      
      private var _items:Vector.<VehiclesPanelItem>;
      
      private var _itemMap:Dictionary;
      
      private var _itemsOrder:Array;
      
      private var _backgroundWidth:Number = 0;
      
      private var _stageWidth:Number = 0;
      
      private var _isBigItems:Boolean = true;
      
      private var _allowVehicleSelection:Boolean = true;
      
      private var _classFactory:IClassFactory;
      
      public function VehiclesPanel()
      {
         this._classFactory = App.utils.classFactory;
         super();
         this._items = new Vector.<VehiclesPanelItem>();
         this._itemMap = new Dictionary();
         this._visibleItems = new Vector.<VehiclesPanelItem>();
         this._itemsOrder = [];
         this.mouseEnabled = this.bg.mouseEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         this.removeAllItems();
         this._items = null;
         this._itemMap = null;
         this._itemsOrder = null;
         this._visibleItems = null;
         this.container = null;
         this.bg = null;
         this._classFactory = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         invalidateSize();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateVisibleItems();
            this.updateSizes();
            this.updatePositions();
            this.updateContainerPosition();
            this.bg.width = this._backgroundWidth;
         }
      }
      
      public function setAllowVehicleSelection(param1:Boolean) : void
      {
         if(this._allowVehicleSelection == param1)
         {
            return;
         }
         this._allowVehicleSelection = param1;
      }
      
      public function addVehiclesInfo(param1:IDAAPIDataClass) : void
      {
         this.applyVehicleData(param1);
      }
      
      public function calcContainerX() : Number
      {
         var _loc1_:Number = this.getVehiclesContainerWidth();
         var _loc2_:int = this._backgroundWidth - _loc1_ >> 1;
         if(this._backgroundWidth - _loc1_ > COMMANDER_DAMAGE_LOG_OFFSET)
         {
            _loc2_ = COMMANDER_DAMAGE_LOG_OFFSET + (this._backgroundWidth - _loc1_ - COMMANDER_DAMAGE_LOG_OFFSET >> 1);
         }
         return _loc2_;
      }
      
      public function resetFrags() : void
      {
      }
      
      public function setArenaInfo(param1:IDAAPIDataClass) : void
      {
      }
      
      public function setFrags(param1:IDAAPIDataClass) : void
      {
      }
      
      public function setPersonalStatus(param1:uint) : void
      {
      }
      
      public function setQuestStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      public function setRTSCommanderInfo(param1:DAAPICommanderInfoVO) : void
      {
      }
      
      public function setRTSCommanderData(param1:DAAPICommanderDataVO) : void
      {
         var _loc2_:DAAPIVehicleCommanderDataVO = null;
         var _loc3_:VehiclesPanelItem = null;
         for each(_loc2_ in param1.leftItems)
         {
            _loc3_ = this.getItemByID(_loc2_.vehicleID);
            if(_loc3_)
            {
               _loc3_.setCommanderData(_loc2_);
            }
         }
      }
      
      public function setRTSCommanderMode(param1:Boolean) : void
      {
      }
      
      public function setRTSOrder(param1:Number, param2:Number, param3:Boolean) : void
      {
         var _loc4_:VehiclesPanelItem = this.getItemByID(param1);
         if(_loc4_)
         {
            _loc4_.setOrderIconState(param2,param3);
         }
      }
      
      public function setRTSVehicleModuleDamaged(param1:int, param2:String) : void
      {
         var _loc3_:VehiclesPanelItem = this.getItemByID(param1);
         if(_loc3_)
         {
            _loc3_.setDamagedModule(param2);
         }
      }
      
      public function setRTSVehicleModuleRepaired(param1:int, param2:String) : void
      {
         var _loc3_:VehiclesPanelItem = this.getItemByID(param1);
         if(_loc3_)
         {
            _loc3_.setRepairedModule(param2);
         }
      }
      
      public function setRTSIsSpotted(param1:Number, param2:Boolean) : void
      {
      }
      
      public function setRTSCondition(param1:Number, param2:String) : void
      {
         var _loc3_:VehiclesPanelItem = this.getItemByID(param1);
         if(_loc3_)
         {
            _loc3_.setCondition(param2);
         }
      }
      
      public function setRTSPlayerCommander(param1:Boolean) : void
      {
      }
      
      public function setRTSClipData(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean) : void
      {
         var _loc6_:VehiclesPanelItem = this.getItemByID(param1);
         if(_loc6_)
         {
            _loc6_.setClipData(param2,param3,param4,param5);
         }
      }
      
      public function setRTSReloading(param1:int, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:VehiclesPanelItem = this.getItemByID(param1);
         if(_loc5_)
         {
            _loc5_.setReloading(param2,param3,param4);
         }
      }
      
      public function setRTSSelectedVehicles(param1:Vector.<int>) : void
      {
         var _loc2_:VehiclesPanelItem = null;
         for each(_loc2_ in this._items)
         {
            _loc2_.isSelected = param1.indexOf(_loc2_.vehicleID) > -1;
         }
      }
      
      public function setRTSSpeakingVehicle(param1:int, param2:Boolean) : void
      {
         var _loc3_:VehiclesPanelItem = this.getItemByID(param1);
         if(_loc3_)
         {
            _loc3_.isSpeaking = param2;
         }
      }
      
      public function setRTSVehicleDisabled(param1:int, param2:Boolean) : void
      {
         var _loc3_:VehiclesPanelItem = this.getItemByID(param1);
         if(_loc3_)
         {
            _loc3_.isDisabled = param2;
         }
      }
      
      public function setRTSSupplyData(param1:DAAPISuppliesDataVO) : void
      {
      }
      
      public function setRTSVehicleGroup(param1:int, param2:int) : void
      {
         var _loc3_:VehiclesPanelItem = this.getItemByID(param1);
         if(_loc3_)
         {
            _loc3_.groupID = param2;
         }
      }
      
      public function setRTSVehicleInFocus(param1:int) : void
      {
         var _loc2_:VehiclesPanelItem = null;
         for each(_loc2_ in this._items)
         {
            _loc2_.isFocused = _loc2_.vehicleID == param1;
         }
      }
      
      public function setRTSVehiclesInFocus(param1:Vector.<int>, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:VehiclesPanelItem = null;
         for each(_loc3_ in param1)
         {
            _loc4_ = this.getItemByID(_loc3_);
            if(_loc4_)
            {
               _loc4_.isFocused = param2;
            }
         }
      }
      
      public function setStageWidth(param1:Number) : void
      {
         if(param1 != this._stageWidth)
         {
            this._stageWidth = param1;
            invalidateSize();
         }
      }
      
      public function setUserTags(param1:IDAAPIDataClass) : void
      {
      }
      
      public function setVehiclesData(param1:IDAAPIDataClass) : void
      {
         this.removeAllItems();
         this.applyVehicleData(param1);
      }
      
      public function setBackgroundWidth(param1:Number) : void
      {
         if(param1 != this._backgroundWidth)
         {
            this._backgroundWidth = param1;
            invalidateSize();
         }
      }
      
      public function getVehiclesContainerWidth(param1:Boolean = true) : int
      {
         var _loc2_:Boolean = !!param1 ? Boolean(this._isBigItems) : Boolean(false);
         var _loc3_:int = VehiclesPanelItem.getWidth(_loc2_);
         return _loc3_ * this._visibleItems.length + (!!_loc2_ ? CONTAINER_MARGIN_WIDTH_BIG : CONTAINER_MARGIN_WIDTH);
      }
      
      public function updateInvitationsStatuses(param1:IDAAPIDataClass) : void
      {
      }
      
      public function updatePersonalStatus(param1:uint, param2:uint) : void
      {
      }
      
      public function updatePlayerStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      public function updateTriggeredChatCommands(param1:IDAAPIDataClass) : void
      {
      }
      
      public function updateUserTags(param1:IDAAPIDataClass) : void
      {
      }
      
      public function updateVehicleStatus(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(param1);
         var _loc3_:VehiclesPanelItem = this.getItemByID(_loc2_.vehicleID);
         if(_loc3_)
         {
            _loc3_.setStatus(_loc2_.status);
         }
         if(_loc2_.leftVehiclesIDs)
         {
            invalidateSize();
         }
      }
      
      public function updateVehiclesData(param1:IDAAPIDataClass) : void
      {
         this.applyVehicleData(param1,true);
      }
      
      public function updateVehiclesStat(param1:IDAAPIDataClass) : void
      {
      }
      
      override protected function updateVisibility() : void
      {
         var _loc1_:VehiclesPanelItem = null;
         super.updateVisibility();
         for each(_loc1_ in this._items)
         {
            _loc1_.setCompVisible(_isCompVisible);
         }
      }
      
      private function updateContainerPosition() : void
      {
         this.container.x = this.calcContainerX();
      }
      
      private function updatePositions() : void
      {
         var _loc1_:VehiclesPanelItem = null;
         for each(_loc1_ in this._visibleItems)
         {
            _loc1_.setPosition(this._visibleItems.indexOf(_loc1_));
         }
      }
      
      private function updateVisibleItems() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:VehiclesPanelItem = null;
         this._visibleItems.splice(0,this._visibleItems.length);
         for each(_loc1_ in this._itemsOrder)
         {
            _loc2_ = this.getItemByID(_loc1_);
            if(_loc2_ && _loc2_.visible)
            {
               this._visibleItems.push(_loc2_);
            }
         }
         this.checkForBigItems();
      }
      
      private function checkForBigItems() : void
      {
         var _loc1_:Boolean = this._backgroundWidth - COMMANDER_DAMAGE_LOG_OFFSET > VehiclesPanelItem.getWidth(true) * this._visibleItems.length + CONTAINER_MARGIN_WIDTH;
         if(_loc1_ != this._isBigItems)
         {
            this._isBigItems = _loc1_;
         }
      }
      
      private function updateSizes() : void
      {
         var _loc1_:VehiclesPanelItem = null;
         for each(_loc1_ in this._items)
         {
            _loc1_.isBig = this._isBigItems;
         }
      }
      
      private function removeAllItems() : void
      {
         var _loc1_:VehiclesPanelItem = null;
         if(this._itemMap)
         {
            App.utils.data.cleanupDynamicObject(this._itemMap);
         }
         this._itemsOrder.splice(0,this._items.length);
         if(this._items)
         {
            for each(_loc1_ in this._items)
            {
               _loc1_.removeEventListener(ComponentEvent.SHOW,this.handleItemShowHide);
               _loc1_.removeEventListener(ComponentEvent.HIDE,this.handleItemShowHide);
               _loc1_.removeEventListener(MouseEvent.DOUBLE_CLICK,this.handleItemDoubleClickEvent);
               _loc1_.removeEventListener(MouseEvent.CLICK,this.handleItemMouseClickEvent);
               _loc1_.removeEventListener(MouseEvent.MOUSE_OVER,this.handleItemMouseOverEvent);
               _loc1_.removeEventListener(MouseEvent.MOUSE_OUT,this.handleItemMouseOutEvent);
               _loc1_.dispose();
            }
            this._items.splice(0,this._items.length);
            this._visibleItems.splice(0,this._visibleItems.length);
         }
         while(this.container.numChildren)
         {
            this.container.removeChildAt(0);
         }
      }
      
      private function getItemByID(param1:Number) : VehiclesPanelItem
      {
         return this._itemMap[param1];
      }
      
      private function applyVehicleData(param1:IDAAPIDataClass, param2:Boolean = false) : void
      {
         var _loc5_:int = 0;
         var _loc6_:VehiclesPanelItem = null;
         var _loc7_:DAAPIVehicleInfoVO = null;
         var _loc8_:int = 0;
         var _loc3_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
         if(!_loc3_.leftVehiclesIDs)
         {
            return;
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.leftVehiclesIDs.length)
         {
            _loc5_ = _loc3_.leftVehiclesIDs[_loc4_];
            _loc6_ = this.getItemByID(_loc5_);
            _loc7_ = _loc3_.getLeftVehicleInfo(_loc5_);
            if(_loc7_ != null)
            {
               if(!_loc6_)
               {
                  _loc6_ = this._classFactory.getComponent(ITEM_RENDERER,VehiclesPanelItem);
                  _loc6_.addEventListener(ComponentEvent.SHOW,this.handleItemShowHide);
                  _loc6_.addEventListener(ComponentEvent.HIDE,this.handleItemShowHide);
                  _loc6_.addEventListener(MouseEvent.DOUBLE_CLICK,this.handleItemDoubleClickEvent);
                  _loc6_.addEventListener(MouseEvent.CLICK,this.handleItemMouseClickEvent);
                  _loc6_.addEventListener(MouseEvent.MOUSE_OVER,this.handleItemMouseOverEvent);
                  _loc6_.addEventListener(MouseEvent.MOUSE_OUT,this.handleItemMouseOutEvent);
                  this._itemMap[_loc5_] = _loc6_;
                  this._items.push(_loc6_);
                  this.container.addChild(_loc6_);
                  invalidateSize();
               }
               if(_loc6_)
               {
                  _loc6_.setData(_loc7_);
               }
            }
            _loc4_++;
         }
         if(param2)
         {
            this._itemsOrder.splice(0);
            for each(_loc8_ in _loc3_.leftVehiclesIDs)
            {
               this._itemsOrder.push(_loc8_);
            }
            invalidateSize();
            onUpdateVehicleOrderS(this._itemsOrder);
         }
      }
      
      private function handleItemShowHide(param1:Event = null) : void
      {
         invalidateSize();
      }
      
      private function handleItemMouseClickEvent(param1:MouseEvent) : void
      {
         if(!this._allowVehicleSelection)
         {
            return;
         }
         var _loc2_:VehiclesPanelItem = param1.target as VehiclesPanelItem;
         if(_loc2_.isAlive && !_loc2_.isDisabled)
         {
            if(App.utils.commons.isRightButton(param1))
            {
               App.contextMenuMgr.show(BATTLE_CONTEXT_MENU_HANDLER_TYPE.COMMANDER_VEHICLES_PANEL,this,_loc2_.vehicleID);
            }
            if(App.utils.commons.isLeftButton(param1))
            {
               onSelectVehicleS(_loc2_.vehicleID);
            }
         }
      }
      
      private function handleItemDoubleClickEvent(param1:MouseEvent) : void
      {
         var _loc2_:VehiclesPanelItem = null;
         if(!this._allowVehicleSelection)
         {
            return;
         }
         if(App.utils.commons.isLeftButton(param1))
         {
            _loc2_ = param1.target as VehiclesPanelItem;
            if(!_loc2_.isDisabled)
            {
               onSwitchVehicleS(_loc2_.vehicleID);
            }
         }
      }
      
      private function handleItemMouseOverEvent(param1:MouseEvent) : void
      {
         if(!this._allowVehicleSelection)
         {
            return;
         }
         var _loc2_:VehiclesPanelItem = param1.target as VehiclesPanelItem;
         if(!_loc2_.isDisabled)
         {
            setVehicleHighlightS(_loc2_.vehicleID,true);
         }
      }
      
      private function handleItemMouseOutEvent(param1:MouseEvent) : void
      {
         if(!this._allowVehicleSelection)
         {
            return;
         }
         var _loc2_:VehiclesPanelItem = param1.target as VehiclesPanelItem;
         if(!_loc2_.isDisabled)
         {
            setVehicleHighlightS(_loc2_.vehicleID,false);
         }
      }
   }
}
