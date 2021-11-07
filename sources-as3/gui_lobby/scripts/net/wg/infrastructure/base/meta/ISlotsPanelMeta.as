package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ISlotsPanelMeta extends IEventDispatcher
   {
       
      
      function getSlotTooltipBodyS(param1:String) : String;
      
      function as_setPanelProps(param1:Object) : void;
      
      function as_setSlots(param1:Array) : void;
      
      function as_updateSlot(param1:Object) : void;
   }
}
