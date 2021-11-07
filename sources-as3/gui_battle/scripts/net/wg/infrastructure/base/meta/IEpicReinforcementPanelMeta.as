package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEpicReinforcementPanelMeta extends IEventDispatcher
   {
       
      
      function as_setPlayerLives(param1:int) : void;
      
      function as_setTimestamp(param1:Number, param2:Number) : void;
      
      function as_setTime(param1:String) : void;
   }
}
