package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IMissionsBattlePassViewMeta extends IEventDispatcher
   {
       
      
      function as_showView() : void;
      
      function as_setPlaceId(param1:uint) : void;
   }
}
