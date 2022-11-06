package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBCHighlightsMeta extends IEventDispatcher
   {
       
      
      function onComponentTriggeredS(param1:String) : void;
      
      function onHighlightAnimationCompleteS(param1:String) : void;
      
      function as_setDescriptors(param1:Object) : void;
      
      function as_addHighlight(param1:String) : void;
      
      function as_removeHighlight(param1:String) : void;
   }
}
