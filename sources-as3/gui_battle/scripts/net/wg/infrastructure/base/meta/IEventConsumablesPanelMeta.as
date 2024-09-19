package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventConsumablesPanelMeta extends IEventDispatcher
   {
       
      
      function as_setChargeProgress(param1:int, param2:Number, param3:Boolean) : void;
      
      function as_setSelected(param1:int, param2:Boolean) : void;
      
      function as_setDebuffView(param1:int, param2:Boolean) : void;
      
      function as_setInspired(param1:Boolean) : void;
   }
}
