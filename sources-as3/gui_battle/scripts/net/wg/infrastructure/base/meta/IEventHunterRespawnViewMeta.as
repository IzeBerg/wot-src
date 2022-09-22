package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventHunterRespawnViewMeta extends IEventDispatcher
   {
       
      
      function onRespawnPointClickS(param1:String) : void;
      
      function as_updateTimer(param1:Number, param2:Number, param3:Number) : void;
      
      function as_setIcon(param1:String) : void;
   }
}
