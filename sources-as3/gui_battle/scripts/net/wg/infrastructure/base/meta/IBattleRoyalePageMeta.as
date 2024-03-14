package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleRoyalePageMeta extends IEventDispatcher
   {
       
      
      function as_updateDamageScreen(param1:Boolean) : void;
      
      function as_setCrosshairMode(param1:int) : void;
   }
}
