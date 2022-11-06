package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IWaitingTransitionMeta extends IEventDispatcher
   {
       
      
      function as_setTransitionText(param1:String) : void;
      
      function as_updateStage(param1:int, param2:int, param3:Number) : void;
      
      function as_showBG() : void;
      
      function as_hideBG() : void;
   }
}
