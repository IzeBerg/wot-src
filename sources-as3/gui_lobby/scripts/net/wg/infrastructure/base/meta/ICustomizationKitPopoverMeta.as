package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ICustomizationKitPopoverMeta extends IEventDispatcher
   {
       
      
      function removeCustomizationKitS() : void;
      
      function updateAutoProlongationS() : void;
      
      function as_setHeader(param1:String) : void;
      
      function as_getDP() : Object;
      
      function as_showClearMessage(param1:Boolean, param2:String) : void;
      
      function as_setAutoProlongationCheckboxSelected(param1:Boolean) : void;
      
      function as_setAutoProlongationCheckboxEnabled(param1:Boolean) : void;
   }
}
