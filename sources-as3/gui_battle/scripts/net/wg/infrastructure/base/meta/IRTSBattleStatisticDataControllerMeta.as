package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRTSBattleStatisticDataControllerMeta extends IEventDispatcher
   {
       
      
      function as_setRTSCommanderInfo(param1:Object) : void;
      
      function as_setRTSCommanderData(param1:Object) : void;
      
      function as_setRTSOrder(param1:Number, param2:Number, param3:Boolean) : void;
      
      function as_setDeviceDamaged(param1:Number, param2:String) : void;
      
      function as_setDeviceRepaired(param1:Number, param2:String) : void;
      
      function as_setRTSCommanderMode(param1:Boolean) : void;
      
      function as_setRTSPlayerCommander(param1:Boolean) : void;
      
      function as_setRTSSupplyData(param1:Object) : void;
      
      function as_setRTSVehicleGroup(param1:int, param2:int) : void;
      
      function as_setRTSSelectedVehicles(param1:Array) : void;
      
      function as_setRTSVehicleInFocus(param1:int) : void;
      
      function as_setRTSVehiclesInFocus(param1:Array, param2:Boolean) : void;
      
      function as_setRTSReloading(param1:int, param2:Number, param3:Number, param4:Number) : void;
      
      function as_setRTSSpeakingVehicle(param1:int, param2:Boolean) : void;
      
      function as_setRTSVehicleDisabled(param1:int, param2:Boolean) : void;
      
      function as_setRTSClipData(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean) : void;
      
      function as_setRTSVehicleCondition(param1:Number, param2:String) : void;
   }
}
