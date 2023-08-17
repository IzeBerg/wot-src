package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ICrewSkinsCompensationDialogMeta extends IEventDispatcher
   {
       
      
      function as_setList(param1:Array) : void;
      
      function as_setMessagePrice(param1:Object) : void;
      
      function as_setPriceLabel(param1:String) : void;
      
      function as_setOperationAllowed(param1:Boolean) : void;
   }
}
