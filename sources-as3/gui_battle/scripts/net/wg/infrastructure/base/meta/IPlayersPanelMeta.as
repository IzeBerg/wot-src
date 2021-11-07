package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPlayersPanelMeta extends IEventDispatcher
   {
       
      
      function tryToSetPanelModeByMouseS(param1:int) : void;
      
      function switchToOtherPlayerS(param1:Number) : void;
      
      function as_setPanelMode(param1:int) : void;
      
      function as_setChatCommandsVisibility(param1:Boolean) : void;
      
      function as_setPlayerHP(param1:Boolean, param2:int, param3:int) : void;
      
      function as_setOverrideExInfo(param1:Boolean) : void;
      
      function as_setPanelHPBarVisibilityState(param1:uint) : void;
   }
}
