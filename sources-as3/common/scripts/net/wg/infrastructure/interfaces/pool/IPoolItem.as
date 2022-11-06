package net.wg.infrastructure.interfaces.pool
{
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.interfaces.IReusable;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IPoolItem extends IEventDispatcher, IReusable, IDisposable
   {
       
      
      function get isInPool() : Boolean;
      
      function set isInPool(param1:Boolean) : void;
   }
}
