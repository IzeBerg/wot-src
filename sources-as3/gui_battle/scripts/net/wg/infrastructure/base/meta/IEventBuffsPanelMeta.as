package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventBuffsPanelMeta extends IEventDispatcher
   {
       
      
      function as_addBuffSlot(param1:uint, param2:String, param3:String) : void;
      
      function as_removeBuffSlot(param1:uint) : void;
   }
}
