package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRankedBattlesIntroMeta extends IEventDispatcher
   {
       
      
      function onCloseS() : void;
      
      function onAcceptClickS() : void;
      
      function onDetailedClickS() : void;
      
      function onPlayVideoClickS() : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setAlertMessageBlockData(param1:Object) : void;
      
      function as_setBeforeSeasonBlockData(param1:Object) : void;
   }
}
