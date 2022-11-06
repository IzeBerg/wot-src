package net.wg.gui.components.tooltips
{
   import flash.display.Sprite;
   import net.wg.infrastructure.events.PoolItemEvent;
   import net.wg.infrastructure.interfaces.pool.IPoolItem;
   
   public class Separator extends Sprite implements IPoolItem
   {
       
      
      private var _isInPool:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function Separator()
      {
         super();
      }
      
      public function cleanUp() : void
      {
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         if(this._isInPool)
         {
            dispatchEvent(new PoolItemEvent(PoolItemEvent.ITEM_TURN_OUT,this));
         }
      }
      
      public function get isInPool() : Boolean
      {
         return this._isInPool;
      }
      
      public function set isInPool(param1:Boolean) : void
      {
         this._isInPool = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
