package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ICommanderHelpMeta extends IEventDispatcher
   {
       
      
      function onOrderButtonClickedS(param1:uint) : void;
      
      function as_setOrderItems(param1:Array) : void;
      
      function as_updateOrderState(param1:int, param2:Boolean, param3:Boolean, param4:Boolean) : void;
   }
}
