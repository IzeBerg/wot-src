package net.wg.white_tiger.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IWTBossWidgetMeta extends IEventDispatcher
   {
       
      
      function as_setWidgetData(param1:Object) : void;
      
      function as_updateHp(param1:Number) : void;
      
      function as_updateKills(param1:Number) : void;
      
      function as_updateGenerators(param1:Number) : void;
      
      function as_updateDebuff(param1:Number, param2:Number) : void;
      
      function as_updateHyperionCharge(param1:Number, param2:Number) : void;
      
      function as_updateGeneratorsCharging(param1:int, param2:Number, param3:Number, param4:Number, param5:Number) : void;
      
      function as_resetGeneratorCaptureTimer(param1:int) : void;
   }
}
