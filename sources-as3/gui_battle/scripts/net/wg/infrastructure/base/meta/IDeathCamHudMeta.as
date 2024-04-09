package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IDeathCamHudMeta extends IEventDispatcher
   {
       
      
      function onAnimationFinishedS() : void;
      
      function as_setTexts(param1:String, param2:String) : void;
      
      function as_showBars() : void;
      
      function as_hideBars(param1:Boolean) : void;
   }
}
