package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRTSBattleQueueMeta extends IEventDispatcher
   {
       
      
      function onSwitchVehicleClickS() : void;
      
      function as_showSwitchVehicle(param1:Object) : void;
      
      function as_hideSwitchVehicle() : void;
      
      function as_setRTSDP(param1:Array) : void;
   }
}
