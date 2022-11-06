package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEpicRandomPlayersPanelMeta extends IEventDispatcher
   {
       
      
      function focusedColumnChangedS(param1:int) : void;
      
      function as_setPlayersSwitchingAllowed(param1:Boolean) : void;
   }
}
