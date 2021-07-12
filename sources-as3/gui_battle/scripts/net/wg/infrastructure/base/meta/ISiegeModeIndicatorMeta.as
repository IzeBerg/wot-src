package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ISiegeModeIndicatorMeta extends IEventDispatcher
   {
       
      
      function as_switchSiegeState(param1:Number, param2:Number, param3:int, param4:String, param5:Boolean) : void;
      
      function as_setAutoSiegeModeState(param1:int, param2:String) : void;
      
      function as_switchSiegeStateSnapshot(param1:Number, param2:Number, param3:int, param4:String, param5:Boolean) : void;
      
      function as_updateDeviceState(param1:String, param2:String) : void;
      
      function as_updateLayout(param1:Number, param2:Number) : void;
      
      function as_setVisible(param1:Boolean) : void;
      
      function as_setSiegeModeType(param1:String) : void;
   }
}
