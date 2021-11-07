package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ICheckBoxDialogMeta extends IEventDispatcher
   {
       
      
      function onCheckBoxChangeS(param1:Boolean) : void;
      
      function as_setCheckBoxLabel(param1:String) : void;
      
      function as_setCheckBoxSelected(param1:Boolean) : void;
      
      function as_setCheckBoxEnabled(param1:Boolean) : void;
   }
}
