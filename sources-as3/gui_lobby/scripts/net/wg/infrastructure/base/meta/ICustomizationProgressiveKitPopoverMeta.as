package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ICustomizationProgressiveKitPopoverMeta extends IEventDispatcher
   {
       
      
      function removeS(param1:int, param2:Object, param3:int) : void;
      
      function removeAllS() : void;
      
      function setToDefaultS() : void;
      
      function onFilterChangedS(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void;
      
      function as_setHeader(param1:String) : void;
      
      function as_showClearMessage(param1:String) : void;
      
      function as_setDefaultButtonEnabled(param1:Boolean) : void;
      
      function as_setItems(param1:Object) : void;
   }
}
