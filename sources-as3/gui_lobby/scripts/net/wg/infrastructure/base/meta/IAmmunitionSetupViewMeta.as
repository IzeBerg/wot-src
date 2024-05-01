package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IAmmunitionSetupViewMeta extends IEventDispatcher
   {
       
      
      function onCloseS() : void;
      
      function onEscapePressS() : void;
      
      function as_gfSizeUpdated(param1:int, param2:int) : void;
      
      function as_showCloseAnim() : void;
      
      function as_onAnimationEnd() : void;
      
      function as_toggleParams(param1:Boolean) : void;
   }
}
