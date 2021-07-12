package net.wg.infrastructure.managers.pool
{
   import flash.events.EventDispatcher;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.events.PoolItemEvent;
   import net.wg.infrastructure.exceptions.ArgumentException;
   import net.wg.infrastructure.interfaces.pool.IPool;
   import net.wg.infrastructure.interfaces.pool.IPoolItem;
   
   public class Pool extends EventDispatcher implements IPool
   {
      
      private static const EXPAND_COEF:Number = 1;
      
      private static const ERROR_POOL_EMPTY:String = "Pool numItems can\'t be equal to zero";
       
      
      private var _items:Vector.<IPoolItem>;
      
      private var _numAvailableItems:uint;
      
      private var _creator:Function;
      
      private var _recommendedNumItems:uint;
      
      public function Pool(param1:uint, param2:Function)
      {
         super();
         this.assert(param1 > 0,ERROR_POOL_EMPTY,ArgumentException);
         this._creator = param2;
         this._items = new Vector.<IPoolItem>(param1);
         this.fillEmptyItems(0,param1);
         this._recommendedNumItems = param1 * EXPAND_COEF;
         this._numAvailableItems = param1;
      }
      
      public final function dispose() : void
      {
         var _loc1_:IPoolItem = null;
         for each(_loc1_ in this._items)
         {
            this.disposeItem(_loc1_);
         }
         this._items.fixed = false;
         this._items.splice(0,this._items.length);
         this._items = null;
         this._creator = null;
         this.onDispose();
      }
      
      public function getItem() : IPoolItem
      {
         if(this._numAvailableItems == 0)
         {
            this.expand();
         }
         return this._items[--this._numAvailableItems];
      }
      
      public function releaseItem(param1:IPoolItem) : void
      {
         var _loc5_:Vector.<IPoolItem> = null;
         var _loc6_:IPoolItem = null;
         param1.cleanUp();
         var _loc2_:int = this._items.indexOf(param1);
         if(_loc2_ < 0)
         {
            this.assert(false,param1 + Errors.WASNT_FOUND,ArgumentException);
         }
         var _loc3_:IPoolItem = this._items[this._numAvailableItems];
         var _loc7_:* = this._numAvailableItems++;
         this._items[_loc7_] = param1;
         this._items[_loc2_] = _loc3_;
         var _loc4_:int = this._numAvailableItems - this._recommendedNumItems;
         if(_loc4_ > 0)
         {
            this._numAvailableItems -= _loc4_;
            _loc5_ = this._items.splice(0,_loc4_);
            for each(_loc6_ in _loc5_)
            {
               this.disposeItem(_loc6_);
            }
         }
      }
      
      protected function onDispose() : void
      {
      }
      
      private function disposeItem(param1:IPoolItem) : void
      {
         param1.removeEventListener(PoolItemEvent.ITEM_TURN_OUT,this.onItemTurnOutHandler);
         param1.isInPool = false;
         param1.dispose();
      }
      
      private function assert(param1:Boolean, param2:String, param3:Class = null) : void
      {
         App.utils.asserter.assert(param1,param2,param3);
      }
      
      private function getItemTypeStr() : String
      {
         return this._items.length > 0 ? String(this._items[0]) : Values.EMPTY_STR;
      }
      
      private function initItem(param1:IPoolItem) : void
      {
         param1.isInPool = true;
         param1.addEventListener(PoolItemEvent.ITEM_TURN_OUT,this.onItemTurnOutHandler);
      }
      
      private function fillEmptyItems(param1:int, param2:int) : void
      {
         var _loc4_:IPoolItem = null;
         var _loc3_:int = param1 + param2;
         var _loc5_:int = param1;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = this._creator();
            this._items[_loc5_] = _loc4_;
            this.initItem(_loc4_);
            _loc5_++;
         }
      }
      
      private function expand() : void
      {
         var _loc1_:int = this._items.length;
         var _loc2_:int = this._recommendedNumItems;
         var _loc3_:int = _loc1_ + _loc2_;
         var _loc4_:Vector.<IPoolItem> = this._items;
         this._items = new Vector.<IPoolItem>(_loc3_);
         this.fillEmptyItems(0,_loc2_);
         var _loc5_:int = _loc2_;
         while(_loc5_ < _loc3_)
         {
            this._items[_loc5_] = _loc4_[_loc5_ - _loc2_];
            _loc5_++;
         }
         this._numAvailableItems += _loc2_;
         _loc4_.fixed = false;
         _loc4_.splice(0,_loc4_.length);
      }
      
      private function onItemTurnOutHandler(param1:PoolItemEvent) : void
      {
         this.releaseItem(param1.item);
      }
   }
}
