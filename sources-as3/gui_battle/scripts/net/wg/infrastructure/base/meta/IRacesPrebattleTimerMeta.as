package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRacesPrebattleTimerMeta extends IEventDispatcher
   {
       
      
      function onFirstLightS() : void;
      
      function onLastLightsS() : void;
      
      function as_setColorBlind(param1:Boolean) : void;
   }
}
