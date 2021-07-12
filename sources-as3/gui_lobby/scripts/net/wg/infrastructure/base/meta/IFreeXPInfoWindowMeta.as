package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IFreeXPInfoWindowMeta extends IEventDispatcher
   {
       
      
      function onSubmitButtonS() : void;
      
      function onCancelButtonS() : void;
      
      function as_setSubmitLabel(param1:String) : void;
      
      function as_setTitle(param1:String) : void;
      
      function as_setText(param1:Object) : void;
   }
}
