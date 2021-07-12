package net.wg.gui.battle.views.superPlatoonPanel.list
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehicleStatsVO;
   import net.wg.gui.battle.views.superPlatoonPanel.renderers.PlatoonMemberListItemRenderer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PlatoonPanelList extends Sprite implements IDisposable
   {
      
      private static const ITEM_HEIGHT:int = 25;
      
      private static const STARTING_Y_OFFSET:int = 8;
       
      
      public var container:MovieClip = null;
      
      private var _items:Vector.<PlatoonMemberListItemHolder> = null;
      
      private var _currOrder:Vector.<Number> = null;
      
      private var _totalOrder:Vector.<Number> = null;
      
      private var _isChatCommVisible:Boolean = true;
      
      private var _itemsHealth:Dictionary = null;
      
      public function PlatoonPanelList()
      {
         super();
         this._currOrder = new <Number>[0,0,0];
         this._items = new Vector.<PlatoonMemberListItemHolder>();
         this._itemsHealth = new Dictionary();
         this._totalOrder = new Vector.<Number>();
      }
      
      public final function dispose() : void
      {
         var _loc1_:PlatoonMemberListItemHolder = null;
         this._currOrder.splice(0,this._currOrder.length);
         this._currOrder = null;
         this._totalOrder.fixed = false;
         this._totalOrder.splice(0,this._totalOrder.length);
         this._totalOrder = null;
         for each(_loc1_ in this._items)
         {
            this.container.removeChild(_loc1_.listItem);
            _loc1_.dispose();
            _loc1_ = null;
         }
         this._items.splice(0,this._items.length);
         this._items = null;
         if(this._itemsHealth)
         {
            App.utils.data.cleanupDynamicObject(this._itemsHealth);
         }
         this._itemsHealth = null;
         this.container = null;
      }
      
      public function forceOrderUpdate() : void
      {
         if(this._totalOrder)
         {
            this.updateOrder(this._totalOrder);
         }
      }
      
      public function setEpicVehiclesStats(param1:EpicVehicleStatsVO) : Boolean
      {
         var _loc2_:PlatoonMemberListItemHolder = this.getHolderByVehicleID(param1.vehicleID);
         if(_loc2_)
         {
            _loc2_.setFrags(param1.frags);
            _loc2_.setRank(param1.rank + 1);
            _loc2_.setChatCommand(param1.chatCommand,param1.chatCommandFlags);
            return true;
         }
         return false;
      }
      
      public function setPlayerStatus(param1:Number, param2:uint) : void
      {
         var _loc3_:PlatoonMemberListItemHolder = this.getHolderByVehicleID(param1);
         if(_loc3_)
         {
            _loc3_.setPlayerStatus(param2);
         }
      }
      
      public function setPlayerHP(param1:Boolean, param2:int, param3:int) : void
      {
         var _loc4_:PlatoonMemberListItemHolder = this.getHolderByVehicleID(param2);
         if(_loc4_)
         {
            _loc4_.setPlayerHP(param3);
            this._itemsHealth[param2] = param3;
         }
         else
         {
            this._itemsHealth[param2] = param3;
         }
      }
      
      public function setOverrideExInfo(param1:Boolean) : void
      {
         var _loc2_:PlatoonMemberListItemHolder = null;
         for each(_loc2_ in this._items)
         {
            _loc2_.setOverrideExInfo(param1);
         }
      }
      
      public function setSpeaking(param1:Number, param2:Boolean) : void
      {
         var _loc3_:PlatoonMemberListItemHolder = this.getHolderByAccountID(param1);
         if(_loc3_)
         {
            _loc3_.listItem.setIsSpeaking(param2);
         }
      }
      
      public function setUserTags(param1:Number, param2:Array) : void
      {
         var _loc3_:PlatoonMemberListItemHolder = this.getHolderByVehicleID(param1);
         if(_loc3_)
         {
            _loc3_.setUserTags(param2);
         }
      }
      
      public function setVehicleData(param1:DAAPIVehicleInfoVO) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:PlatoonMemberListItemHolder = this.getHolderByVehicleID(param1.vehicleID);
         if(_loc3_ != null)
         {
            _loc3_.setVehicleData(param1);
         }
         else
         {
            this.addItem(param1);
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      public function setVehicleStatus(param1:Number, param2:uint) : void
      {
         var _loc3_:PlatoonMemberListItemHolder = this.getHolderByVehicleID(param1);
         if(_loc3_)
         {
            _loc3_.setVehicleStatus(param2);
         }
      }
      
      public function updateColorBlind() : void
      {
         var _loc1_:PlatoonMemberListItemHolder = null;
         for each(_loc1_ in this._items)
         {
            _loc1_.listItem.updateColorBlind();
         }
      }
      
      public function triggerChatCommand(param1:Number, param2:String) : void
      {
         var _loc3_:PlatoonMemberListItemHolder = this.getHolderByVehicleID(param1);
         if(_loc3_)
         {
            _loc3_.triggerChatCommand(param2);
         }
      }
      
      public function updateOrder(param1:Vector.<Number>) : void
      {
         var _loc3_:PlatoonMemberListItemHolder = null;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:PlatoonMemberListItemHolder = null;
         var _loc7_:int = 0;
         if(!param1)
         {
            return;
         }
         this._totalOrder = param1;
         var _loc2_:Vector.<Number> = new Vector.<Number>();
         for each(_loc3_ in this._items)
         {
            _loc2_.push(_loc3_.vehicleID);
         }
         _loc2_.sort(this.orderSortFunction);
         _loc4_ = this._items.length;
         _loc5_ = 0;
         _loc6_ = null;
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            _loc5_ = _loc2_[_loc7_];
            if(this._currOrder[_loc7_] != _loc5_)
            {
               _loc6_ = this.getHolderByVehicleID(_loc5_);
               if(_loc6_)
               {
                  _loc6_.listItem.y = STARTING_Y_OFFSET + ITEM_HEIGHT * _loc7_;
                  this._currOrder[_loc7_] = _loc5_;
               }
            }
            _loc7_++;
         }
         _loc2_.splice(0,_loc2_.length);
         _loc2_ = null;
      }
      
      public function setChatCommandsVisibility(param1:Boolean) : void
      {
         var _loc2_:PlatoonMemberListItemHolder = null;
         if(this._isChatCommVisible == param1)
         {
            return;
         }
         this._isChatCommVisible = param1;
         for each(_loc2_ in this._items)
         {
            _loc2_.setChatCommandsVisibility(param1);
         }
      }
      
      public function setPanelHPBarVisibilityState(param1:uint) : void
      {
         var _loc2_:PlatoonMemberListItemHolder = null;
         for each(_loc2_ in this._items)
         {
            _loc2_.setPanelHPBarVisibilityState(param1);
         }
      }
      
      private function orderSortFunction(param1:Number, param2:Number) : Number
      {
         var _loc3_:int = this._totalOrder.indexOf(param1);
         var _loc4_:int = this._totalOrder.indexOf(param2);
         if(_loc3_ == -1 && _loc4_ != -1)
         {
            return 1;
         }
         if(_loc3_ != -1 && _loc4_ == -1)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         return 0;
      }
      
      private function addItem(param1:DAAPIVehicleInfoVO) : void
      {
         var _loc2_:PlatoonMemberListItemRenderer = App.utils.classFactory.getComponent(Linkages.PLATOON_MEMBER_LIST_ITEM_UI,PlatoonMemberListItemRenderer);
         _loc2_.y = STARTING_Y_OFFSET + this._items.length * ITEM_HEIGHT;
         _loc2_.holderItemID = this._items.length;
         this.container.addChild(_loc2_);
         var _loc3_:PlatoonMemberListItemHolder = new PlatoonMemberListItemHolder(_loc2_);
         _loc3_.setVehicleData(param1);
         _loc3_.setChatCommandsVisibility(this._isChatCommVisible);
         var _loc4_:Number = param1.vehicleID;
         if(this._itemsHealth[_loc4_] !== undefined)
         {
            _loc3_.setPlayerHP(this._itemsHealth[_loc4_]);
         }
         this._items.push(_loc3_);
      }
      
      private function getHolderByVehicleID(param1:Number) : PlatoonMemberListItemHolder
      {
         var _loc2_:PlatoonMemberListItemHolder = null;
         for each(_loc2_ in this._items)
         {
            if(_loc2_.vehicleID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function getHolderByAccountID(param1:Number) : PlatoonMemberListItemHolder
      {
         var _loc2_:PlatoonMemberListItemHolder = null;
         for each(_loc2_ in this._items)
         {
            if(_loc2_.accountDBID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}
