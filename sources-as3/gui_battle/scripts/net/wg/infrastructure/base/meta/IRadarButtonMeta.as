package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRadarButtonMeta extends IEventDispatcher
   {
       
      
      function onClickS() : void;
      
      function as_init(param1:Number, param2:Number, param3:String, param4:String, param5:Boolean) : void;
      
      function as_setCoolDownTime(param1:Number, param2:Number, param3:Number, param4:int) : void;
      
      function as_updateEnable(param1:Boolean) : void;
      
      function as_setCoolDownPosAsPercent(param1:Number) : void;
      
      function as_setCoolDownTimeSnapshot(param1:int) : void;
   }
}
