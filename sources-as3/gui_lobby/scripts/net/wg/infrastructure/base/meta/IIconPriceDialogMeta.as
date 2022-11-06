package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IIconPriceDialogMeta extends IEventDispatcher
   {
       
      
      function as_setMessagePrice(param1:Object) : void;
      
      function as_setPriceLabel(param1:String) : void;
      
      function as_setOperationAllowed(param1:Boolean) : void;
   }
}
