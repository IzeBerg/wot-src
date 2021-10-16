package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBCSecondaryHintMeta extends IEventDispatcher
   {
       
      
      function as_hideHint() : void;
      
      function as_showHint(param1:String) : void;
   }
}
