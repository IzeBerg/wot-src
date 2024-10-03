package net.wg.white_tiger.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IWTHunterRespawnViewMeta extends IEventDispatcher
   {
       
      
      function onRespawnPointClickS(param1:String) : void;
      
      function as_updateTimer(param1:Number, param2:Number, param3:Number) : void;
   }
}
