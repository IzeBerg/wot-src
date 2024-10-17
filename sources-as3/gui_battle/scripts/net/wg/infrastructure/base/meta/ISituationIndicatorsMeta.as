package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ISituationIndicatorsMeta extends IEventDispatcher
   {
       
      
      function as_setPerks(param1:Array) : void;
      
      function as_updatePerk(param1:String, param2:int, param3:Number, param4:Number) : void;
      
      function as_setWeather(param1:Array) : void;
      
      function as_updateWeather(param1:String, param2:int, param3:String) : void;
      
      function as_clearPanel() : void;
      
      function as_replayPause(param1:Boolean) : void;
   }
}
