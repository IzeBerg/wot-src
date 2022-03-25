package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehiclesPanelMeta extends IEventDispatcher
   {
       
      
      function onSelectVehicleS(param1:Number) : void;
      
      function onSwitchVehicleS(param1:Number) : void;
      
      function setVehicleHighlightS(param1:Number, param2:Boolean) : void;
      
      function onUpdateVehicleOrderS(param1:Array) : void;
   }
}
