package net.wg.gui.battle.views.ribbonsPanel
{
   import flash.utils.Dictionary;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.views.ribbonsPanel.data.RibbonQueueItem;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RibbonQueue implements IDisposable
   {
      
      private static const DEFAULT_COUNT_ITEMS_IN_POOL:int = 10;
      
      private static const COUNT_ADDITIONAL_ITEMS_IN_POOL:int = 5;
       
      
      private var _pool:Vector.<RibbonQueueItem> = null;
      
      private var _queue:Vector.<RibbonQueueItem> = null;
      
      private var _queueMapById:Dictionary = null;
      
      private var _disposed:Boolean = false;
      
      public function RibbonQueue()
      {
         super();
         this._queueMapById = new Dictionary();
         this._pool = new Vector.<RibbonQueueItem>(0);
         this._queue = new Vector.<RibbonQueueItem>(0);
         this.createAdditionalItemsInPool(DEFAULT_COUNT_ITEMS_IN_POOL);
      }
      
      public function clear() : void
      {
         App.utils.data.cleanupDynamicObject(this._queueMapById);
         this._queue.splice(0,this._queue.length);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.clear();
         this._queueMapById = null;
         this._pool.splice(0,this._pool.length);
         this._pool = null;
         this._queue = null;
      }
      
      public function pushShow(param1:String, param2:Number, param3:String, param4:String, param5:String, param6:String, param7:Boolean, param8:String, param9:String) : void
      {
         var _loc10_:RibbonQueueItem = this._queueMapById[param2];
         if(_loc10_ == null)
         {
            _loc10_ = this.getItemFromPool();
            this._queueMapById[param2] = _loc10_;
            this._queue.push(_loc10_);
         }
         _loc10_.setData(RibbonQueueItem.SHOW,param1,param2,param3,param4,param5,param6,param7,param8,param9);
      }
      
      public function readNext() : RibbonQueueItem
      {
         var _loc1_:RibbonQueueItem = null;
         if(this._queue.length > 0)
         {
            _loc1_ = this._queue[0];
         }
         return _loc1_;
      }
      
      public function shiftQueue() : void
      {
         var _loc1_:RibbonQueueItem = this._queue.shift();
         delete this._queueMapById[_loc1_.ribbonId];
         if(_loc1_ != null)
         {
            this._pool.push(_loc1_);
         }
      }
      
      public function unShiftHide(param1:Number) : void
      {
         var _loc2_:RibbonQueueItem = this.getItemFromPool();
         _loc2_.setData(RibbonQueueItem.HIDE,Values.EMPTY_STR,param1,Values.EMPTY_STR,Values.EMPTY_STR,Values.EMPTY_STR,Values.EMPTY_STR,false,Values.EMPTY_STR,Values.EMPTY_STR);
         this._queue.unshift(_loc2_);
      }
      
      private function getItemFromPool() : RibbonQueueItem
      {
         if(this._pool.length == 0)
         {
            this.createAdditionalItemsInPool(COUNT_ADDITIONAL_ITEMS_IN_POOL);
         }
         return this._pool.shift();
      }
      
      private function createAdditionalItemsInPool(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1)
         {
            this._pool.push(new RibbonQueueItem());
            _loc2_++;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
