package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleTypeSelectorMeta extends IEventDispatcher
   {
       
      
      function startFirstShowAnimationS() : void;
      
      function startIdleAnimationS() : void;
      
      function setIsVisible(param1:Boolean) : void;
   }
}
