package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleRoyaleTimersPanelMeta extends IEventDispatcher
   {
       
      
      function as_setIsReplay(param1:Boolean) : void;
      
      function as_setRespawnTime(param1:int) : void;
      
      function as_setAirDropTime(param1:int) : void;
   }
}
