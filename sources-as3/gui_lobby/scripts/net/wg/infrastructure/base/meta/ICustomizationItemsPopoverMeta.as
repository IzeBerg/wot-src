package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ICustomizationItemsPopoverMeta extends IEventDispatcher
   {
       
      
      function removeS(param1:int, param2:Object) : void;
      
      function removeAllS() : void;
      
      function showNonHistoricAndFantasticalS(param1:Boolean, param2:Boolean) : void;
      
      function as_setHeaderData(param1:Object) : void;
      
      function as_getDP() : Object;
      
      function as_showClearMessage(param1:Boolean, param2:String) : void;
   }
}
