package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventBoardsAwardsOverlayMeta extends IEventDispatcher
   {
       
      
      function changeFilterS(param1:int) : void;
      
      function as_setHeader(param1:Object) : void;
      
      function as_setVehicle(param1:Object) : void;
      
      function as_setData(param1:Object) : void;
   }
}
