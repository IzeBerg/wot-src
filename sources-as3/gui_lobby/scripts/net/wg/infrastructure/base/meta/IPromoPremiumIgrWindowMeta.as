package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPromoPremiumIgrWindowMeta extends IEventDispatcher
   {
       
      
      function as_setTitle(param1:String) : void;
      
      function as_setText(param1:String) : void;
      
      function as_setWindowTitle(param1:String) : void;
      
      function as_setApplyButtonLabel(param1:String) : void;
   }
}
