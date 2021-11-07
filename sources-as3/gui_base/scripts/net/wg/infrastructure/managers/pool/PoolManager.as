package net.wg.infrastructure.managers.pool
{
   import flash.utils.Dictionary;
   import net.wg.infrastructure.interfaces.pool.IPool;
   import net.wg.infrastructure.interfaces.pool.IPoolItem;
   import net.wg.infrastructure.interfaces.pool.IPoolManager;
   
   public class PoolManager implements IPoolManager
   {
       
      
      private var _pools:Dictionary;
      
      public function PoolManager()
      {
         super();
         this._pools = new Dictionary();
      }
      
      public function addPool(param1:String, param2:IPool) : void
      {
         var _loc3_:IPool = this.getPool(param1);
         if(_loc3_ != null)
         {
            this.assert(false,"Pool \'" + param1 + "\' was already added earlier.");
         }
         this._pools[param1] = param2;
      }
      
      public function containsPool(param1:String) : Boolean
      {
         var _loc2_:Object = this._pools[param1];
         return _loc2_ != null && _loc2_ is IPool;
      }
      
      public final function dispose() : void
      {
         var _loc1_:IPool = null;
         for each(_loc1_ in this._pools)
         {
            _loc1_.dispose();
         }
         App.utils.data.cleanupDynamicObject(this._pools);
         this._pools = null;
         this.onDispose();
      }
      
      public function getItem(param1:String) : IPoolItem
      {
         var _loc2_:IPool = this.getPool(param1);
         if(_loc2_ == null)
         {
            this.assert(false,"Pool \'" + param1 + "\' isn\'t created.");
         }
         return _loc2_.getItem();
      }
      
      public function releaseItem(param1:String, param2:IPoolItem) : void
      {
         var _loc3_:IPool = this.getPool(param1);
         if(_loc3_ == null)
         {
            this.assert(false,"Pool \'" + param1 + "\' isn\'t created.");
         }
         return _loc3_.releaseItem(param2);
      }
      
      protected function onDispose() : void
      {
      }
      
      private function assert(param1:Boolean, param2:String, param3:Class = null) : void
      {
         App.utils.asserter.assert(param1,param2,param3);
      }
      
      private function getPool(param1:String) : IPool
      {
         return IPool(this._pools[param1]);
      }
   }
}
