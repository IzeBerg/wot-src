package net.wg.gui.battle.pveBase.views.stats.components.playersPanel.list
{
   import fl.motion.easing.Cubic;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.PveDAAPIVehicleInfoVO;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.events.PlayersPanelListEvent;
   import net.wg.gui.battle.components.stats.playersPanel.events.PlayersPanelItemEvent;
   import net.wg.gui.battle.components.stats.playersPanel.interfaces.IPlayersPanelListItem;
   import net.wg.gui.battle.pveBase.views.stats.components.playersPanel.interfaces.IPvePlayersPanelListItem;
   import net.wg.gui.battle.pveBase.views.stats.components.playersPanel.interfaces.IPvePlayersPanelListItemHolder;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IPlayersPanelListItemHolder;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.motion.Tween;
   
   public class PvePlayersPanelListRight extends PveBasePlayersPanelListRight
   {
      
      private static const LINKAGE:String = "PvePlayersPanelListItemRightUI";
      
      private static const APPEARING_DURATION:int = 500;
      
      private static const DISAPPEARING_DURATION:int = 1000;
      
      private static const DISAPPEARING_DELAY:int = 800;
      
      private static const APPEARING_DELAY:int = 100;
      
      private static const APPEARING_X_SHIFT:int = 70;
      
      private static const DISAPPEARING_X_SHIFT:int = 200;
      
      private static const ITEM_HEIGHT:int = 25;
      
      private static const MAX_COUNT:int = 15;
       
      
      private var _renderersContainer:Sprite;
      
      private var _newVehicles:Vector.<Number>;
      
      private var _removedVehicles:Vector.<Number>;
      
      private var _vehiclesOrder:Vector.<Number>;
      
      private var _vehicleInfoDict:Dictionary;
      
      private var _tweenByVehicleID:Dictionary;
      
      private var _mapHolderByVehicleID:Dictionary;
      
      private var _auxiliaryVehicleData:Dictionary;
      
      private var _isCursorVisible:Boolean = false;
      
      private var _vehicleIDUnderMouse:int = -1;
      
      private var _holders:Vector.<IPvePlayersPanelListItemHolder>;
      
      private var _HPBarVisibilityState:uint = 0;
      
      private var _overrideExInfoValue:Boolean = false;
      
      private var _classFactory:IClassFactory;
      
      public function PvePlayersPanelListRight()
      {
         this._renderersContainer = new Sprite();
         this._newVehicles = new Vector.<Number>(0);
         this._removedVehicles = new Vector.<Number>(0);
         this._vehiclesOrder = new Vector.<Number>(0);
         this._vehicleInfoDict = new Dictionary();
         this._tweenByVehicleID = new Dictionary();
         this._mapHolderByVehicleID = new Dictionary();
         this._auxiliaryVehicleData = new Dictionary();
         this._holders = new Vector.<IPvePlayersPanelListItemHolder>();
         this._classFactory = App.utils.classFactory;
         super();
         addChild(this._renderersContainer);
      }
      
      protected function getHolderByVehicleID(param1:Number) : IPvePlayersPanelListItemHolder
      {
         return this._mapHolderByVehicleID[param1];
      }
      
      override public function getRenderersVisibleWidth() : uint
      {
         var _loc1_:Rectangle = this._renderersContainer.getBounds(this);
         return _loc1_.x + _loc1_.width;
      }
      
      override public function setVehicleData(param1:Vector.<DAAPIVehicleInfoVO>) : void
      {
         var _loc2_:DAAPIVehicleInfoVO = null;
         var _loc3_:int = 0;
         if(param1 == null)
         {
            return;
         }
         for each(_loc2_ in param1)
         {
            this._vehicleInfoDict[_loc2_.vehicleID] = _loc2_;
            if(_loc2_.isAlive())
            {
               _loc3_ = this._removedVehicles.indexOf(_loc2_.vehicleID);
               if(_loc3_ != -1)
               {
                  this._removedVehicles.splice(_loc3_,1);
               }
            }
         }
         this.processVehiclesData();
      }
      
      private function processVehiclesData() : void
      {
         var _loc1_:DAAPIVehicleInfoVO = null;
         var _loc2_:Number = NaN;
         var _loc3_:IPlayersPanelListItemHolder = null;
         var _loc4_:PveDAAPIVehicleInfoVO = null;
         var _loc5_:Boolean = false;
         for each(_loc1_ in this._vehicleInfoDict)
         {
            _loc2_ = _loc1_.vehicleID;
            if(this._removedVehicles.indexOf(_loc2_) == -1)
            {
               if(_loc1_.isAlive() || this._tweenByVehicleID[_loc2_] !== undefined)
               {
                  _loc3_ = this.getHolderByVehicleID(_loc2_);
                  if(_loc3_)
                  {
                     _loc3_.setVehicleData(_loc1_);
                  }
                  else
                  {
                     _loc4_ = _loc1_ as PveDAAPIVehicleInfoVO;
                     _loc5_ = _loc4_ == null || _loc4_.teamPanelMode != PveDAAPIVehicleInfoVO.HIDE;
                     if(this._renderersContainer.numChildren < MAX_COUNT && _loc5_)
                     {
                        this.addItem(_loc1_);
                     }
                  }
               }
            }
         }
         this.updatePositions();
         if(this._newVehicles.length > 0)
         {
            dispatchEvent(new PlayersPanelListEvent(PlayersPanelListEvent.ITEMS_COUNT_CHANGE,0));
            this.setMouseListenersEnabled(this._isCursorVisible);
         }
      }
      
      override public function setIsCursorVisible(param1:Boolean) : void
      {
         var _loc2_:IPlayersPanelListItemHolder = null;
         if(this._isCursorVisible == param1)
         {
            return;
         }
         this._isCursorVisible = param1;
         this.setMouseListenersEnabled(param1);
         if(this._vehicleIDUnderMouse != Values.DEFAULT_INT)
         {
            if(this._isCursorVisible)
            {
               _loc2_ = this.getHolderByVehicleID(this._vehicleIDUnderMouse);
               MinimapEntryController.instance.highlight(_loc2_.vehicleID);
            }
            else
            {
               this._vehicleIDUnderMouse = Values.DEFAULT_INT;
               MinimapEntryController.instance.unhighlight();
            }
         }
      }
      
      private function setMouseListenersEnabled(param1:Boolean) : void
      {
         var _loc2_:IPvePlayersPanelListItemHolder = null;
         var _loc3_:IPlayersPanelListItem = null;
         if(param1)
         {
            for each(_loc2_ in this._holders)
            {
               _loc3_ = _loc2_.getListItem();
               _loc3_.addEventListener(PlayersPanelItemEvent.ON_ITEM_OVER,this.onPlayersListItemOnItemOverHandler);
               _loc3_.addEventListener(PlayersPanelItemEvent.ON_ITEM_OUT,this.onPlayersListItemOnItemOutHandler);
            }
         }
         else
         {
            for each(_loc2_ in this._holders)
            {
               _loc3_ = _loc2_.getListItem();
               _loc3_.removeEventListener(PlayersPanelItemEvent.ON_ITEM_OVER,this.onPlayersListItemOnItemOverHandler);
               _loc3_.removeEventListener(PlayersPanelItemEvent.ON_ITEM_OUT,this.onPlayersListItemOnItemOutHandler);
            }
         }
      }
      
      private function onPlayersListItemOnItemOverHandler(param1:PlayersPanelItemEvent) : void
      {
         this._vehicleIDUnderMouse = param1.holderItemID;
         MinimapEntryController.instance.highlight(this._vehicleIDUnderMouse);
      }
      
      private function onPlayersListItemOnItemOutHandler(param1:PlayersPanelItemEvent) : void
      {
         this._vehicleIDUnderMouse = Values.DEFAULT_INT;
         MinimapEntryController.instance.unhighlight();
      }
      
      private function addItem(param1:DAAPIVehicleInfoVO) : void
      {
         var _loc2_:IPvePlayersPanelListItem = this._classFactory.getComponent(LINKAGE,IPvePlayersPanelListItem);
         var _loc3_:Number = param1.vehicleID;
         _loc2_.holderItemID = _loc3_;
         _loc2_.setOverrideExInfo(this._overrideExInfoValue);
         this._renderersContainer.addChild(DisplayObject(_loc2_));
         var _loc4_:IPvePlayersPanelListItemHolder = new PvePlayersPanelListItemHolder(_loc2_);
         _loc4_.setPanelHPBarVisibilityState(this._HPBarVisibilityState);
         _loc4_.setVehicleData(param1);
         this._mapHolderByVehicleID[_loc3_] = _loc4_;
         this._holders.push(_loc4_);
         var _loc5_:AuxiliaryVehicleData = this._auxiliaryVehicleData[_loc3_];
         if(_loc5_ != null)
         {
            _loc4_.setPlayerHP(_loc5_.playerHP);
            _loc4_.setSpottedStatus(_loc5_.spottedStatus);
            _loc2_.setChatCommand(_loc5_.chatCommand,_loc5_.chatCommandFlags);
         }
         _loc2_.visible = false;
         this._newVehicles.push(_loc3_);
         if(this._vehiclesOrder.indexOf(_loc3_) == -1)
         {
            this._vehiclesOrder.push(_loc3_);
         }
         if(this._newVehicles.length == 1)
         {
            addEventListener(Event.RENDER,this.onRenderHandler);
            App.instance.stage.invalidate();
         }
      }
      
      override public function setPanelHPBarVisibilityState(param1:uint) : void
      {
         var _loc2_:IPvePlayersPanelListItemHolder = null;
         if(param1 == this._HPBarVisibilityState)
         {
            return;
         }
         this._HPBarVisibilityState = param1;
         for each(_loc2_ in this._holders)
         {
            _loc2_.setPanelHPBarVisibilityState(param1);
         }
      }
      
      override public function setOverrideExInfo(param1:Boolean) : void
      {
         var _loc2_:IPvePlayersPanelListItemHolder = null;
         this._overrideExInfoValue = param1;
         for each(_loc2_ in this._holders)
         {
            _loc2_.setOverrideExInfo(param1);
         }
      }
      
      override public function updateOrder(param1:Vector.<Number>) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._vehiclesOrder = param1.slice();
         this.updatePositions();
      }
      
      private function updatePositions() : void
      {
         var _loc2_:IPlayersPanelListItemHolder = null;
         var _loc1_:int = this._vehiclesOrder.length;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc1_)
         {
            _loc2_ = this.getHolderByVehicleID(this._vehiclesOrder[_loc4_]);
            if(_loc2_)
            {
               _loc2_.getListItem().y = ITEM_HEIGHT * _loc3_++;
            }
            _loc4_++;
         }
      }
      
      override public function removeAllItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         App.utils.data.cleanupDynamicObject(this._mapHolderByVehicleID);
         if(this._holders)
         {
            _loc1_ = this._holders.length;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               this._holders[_loc3_].getListItem().dispose();
               this._holders[_loc3_].dispose();
               _loc3_++;
            }
            this._holders.length = 0;
         }
         if(this._renderersContainer != null)
         {
            while(this._renderersContainer.numChildren > 0)
            {
               this._renderersContainer.removeChildAt(0);
            }
         }
         for each(_loc2_ in this._tweenByVehicleID)
         {
            this._tweenByVehicleID[_loc2_].dispose();
         }
         App.utils.data.cleanupDynamicObject(this._tweenByVehicleID);
         this._vehiclesOrder.length = 0;
         this._newVehicles.length = 0;
         this._removedVehicles.length = 0;
      }
      
      private function getOrCreateAuxiliaryData(param1:int) : AuxiliaryVehicleData
      {
         var _loc2_:AuxiliaryVehicleData = this._auxiliaryVehicleData[param1];
         if(_loc2_ == null)
         {
            this._auxiliaryVehicleData[param1] = _loc2_ = new AuxiliaryVehicleData();
         }
         return _loc2_;
      }
      
      override public function setPlayerHP(param1:int, param2:int) : void
      {
         this.getOrCreateAuxiliaryData(param1).playerHP = param2;
         var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
         if(_loc3_)
         {
            _loc3_.setPlayerHP(param2);
         }
      }
      
      override public function setPlayerStatus(param1:Number, param2:uint) : void
      {
         var _loc3_:DAAPIVehicleInfoVO = this._vehicleInfoDict[param1];
         if(_loc3_ != null)
         {
            _loc3_.playerStatus = param2;
         }
         var _loc4_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
         if(_loc4_)
         {
            _loc4_.setPlayerStatus(param2);
         }
      }
      
      override public function setVehicleStatus(param1:Number, param2:uint) : void
      {
         var _loc5_:Boolean = false;
         var _loc6_:IPlayersPanelListItem = null;
         var _loc7_:Tween = null;
         var _loc3_:DAAPIVehicleInfoVO = this._vehicleInfoDict[param1];
         if(_loc3_ != null)
         {
            _loc3_.vehicleStatus = param2;
         }
         var _loc4_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
         if(_loc4_)
         {
            _loc5_ = _loc4_.getVehicleData().isAlive();
            _loc4_.setVehicleData(_loc3_);
            if(_loc3_.isBot && !_loc3_.isAlive() && _loc5_)
            {
               this._removedVehicles.push(param1);
               _loc6_ = _loc4_.getListItem();
               _loc7_ = new Tween(DISAPPEARING_DURATION,_loc6_,{"x":DISAPPEARING_X_SHIFT},{
                  "onComplete":this.disappearingCompleted,
                  "data":param1,
                  "delay":DISAPPEARING_DELAY,
                  "ease":Cubic.easeIn,
                  "fastTransform":false
               });
               this._tweenByVehicleID[param1] = _loc7_;
            }
         }
      }
      
      private function disappearingCompleted(param1:Tween) : void
      {
         this.tweenCompleteHandler(param1);
         var _loc2_:Number = Number(param1.data);
         var _loc3_:IPvePlayersPanelListItemHolder = this.getHolderByVehicleID(_loc2_);
         var _loc4_:int = this._holders.indexOf(_loc3_);
         if(_loc4_ != -1)
         {
            this._holders.splice(_loc4_,1);
         }
         delete this._mapHolderByVehicleID[_loc3_.vehicleID];
         var _loc5_:IPlayersPanelListItem = _loc3_.getListItem();
         this._renderersContainer.removeChild(_loc5_ as DisplayObject);
         _loc5_.dispose();
         _loc3_.dispose();
         this.processVehiclesData();
         this.updatePositions();
      }
      
      override public function setSpottedStatus(param1:Number, param2:uint) : void
      {
         this.getOrCreateAuxiliaryData(param1).spottedStatus = param2;
         var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
         if(_loc3_)
         {
            _loc3_.setSpottedStatus(param2);
         }
      }
      
      override public function updateColorBlind() : void
      {
         var _loc1_:IPvePlayersPanelListItemHolder = null;
         for each(_loc1_ in this._holders)
         {
            _loc1_.getListItem().updateColorBlind();
         }
      }
      
      private function onRenderHandler(param1:Event) : void
      {
         var _loc2_:IPlayersPanelListItemHolder = null;
         var _loc3_:Number = NaN;
         var _loc4_:IPlayersPanelListItem = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Tween = null;
         removeEventListener(Event.RENDER,this.onRenderHandler);
         if(this._newVehicles.length > 0)
         {
            this._newVehicles.sort(this.sortItemsByY);
            _loc5_ = 0;
            for each(_loc3_ in this._newVehicles)
            {
               _loc2_ = this.getHolderByVehicleID(_loc3_);
               _loc4_ = _loc2_.getListItem();
               _loc4_.visible = true;
               _loc4_.alpha = 0;
               _loc4_.x = APPEARING_X_SHIFT;
               _loc6_ = APPEARING_DELAY * _loc5_;
               _loc5_++;
               _loc7_ = new Tween(APPEARING_DURATION,_loc4_,{
                  "alpha":1,
                  "x":0
               },{
                  "delay":_loc6_,
                  "onComplete":this.tweenCompleteHandler,
                  "data":_loc3_,
                  "ease":Cubic.easeInOut,
                  "fastTransform":false
               });
               this._tweenByVehicleID[_loc3_] = _loc7_;
            }
            this._newVehicles.length = 0;
         }
      }
      
      private function sortItemsByY(param1:Number, param2:Number) : int
      {
         var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
         var _loc4_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param2);
         return _loc3_.getListItem().y - _loc4_.getListItem().y;
      }
      
      private function tweenCompleteHandler(param1:Tween) : void
      {
         delete this._tweenByVehicleID[param1.data];
      }
      
      override public function toString() : String
      {
         return "[WG PvePlayersPanelListRight]";
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(Event.RENDER,this.onRenderHandler);
         this.setMouseListenersEnabled(false);
         this._vehicleIDUnderMouse = Values.DEFAULT_INT;
         this.removeAllItems();
         this._newVehicles = null;
         this._vehiclesOrder = null;
         this._removedVehicles = null;
         this._mapHolderByVehicleID = null;
         App.utils.data.cleanupDynamicObject(this._auxiliaryVehicleData);
         this._auxiliaryVehicleData = null;
         App.utils.data.cleanupDynamicObject(this._vehicleInfoDict);
         this._tweenByVehicleID = null;
         this._holders = null;
         this._renderersContainer = null;
         this._classFactory = null;
         super.onDispose();
      }
      
      override public function setChatCommand(param1:Number, param2:String, param3:uint) : void
      {
         var _loc4_:AuxiliaryVehicleData = this.getOrCreateAuxiliaryData(param1);
         _loc4_.chatCommandFlags = param3;
         _loc4_.chatCommand = param2;
         var _loc5_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
         if(_loc5_)
         {
            _loc5_.setChatCommand(param2,param3);
         }
      }
   }
}

class AuxiliaryVehicleData
{
    
   
   public var playerHP:int = 0;
   
   public var spottedStatus:uint = 0;
   
   public var chatCommand:String = "";
   
   public var chatCommandFlags:uint = 0;
   
   function AuxiliaryVehicleData()
   {
      super();
   }
}
