package net.wg.infrastructure.events
{
   import flash.events.Event;
   import net.wg.infrastructure.interfaces.pool.IPoolItem;
   
   public class PoolItemEvent extends Event
   {
      
      public static const ITEM_TURN_OUT:String = "itemTurnOut";
       
      
      private var _item:IPoolItem;
      
      public function PoolItemEvent(param1:String, param2:IPoolItem, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._item = param2;
      }
      
      public function get item() : IPoolItem
      {
         return this._item;
      }
   }
}
