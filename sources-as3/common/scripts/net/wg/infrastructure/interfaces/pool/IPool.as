package net.wg.infrastructure.interfaces.pool
{
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IPool extends IDisposable, IEventDispatcher
   {
       
      
      function getItem() : IPoolItem;
      
      function releaseItem(param1:IPoolItem) : void;
   }
}
