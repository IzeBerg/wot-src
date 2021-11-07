package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventPlayersPanelMeta extends IEventDispatcher
   {
       
      
      function as_setPlayerPanelInfo(param1:Object) : void;
      
      function as_setPlayerPanelHp(param1:int, param2:int, param3:int) : void;
      
      function as_setPlayerDead(param1:int) : void;
      
      function as_setPlayerPanelCountSouls(param1:int, param2:int) : void;
      
      function as_setCollectorGoal(param1:int) : void;
      
      function as_setCollectorNeedValue(param1:int) : void;
      
      function as_updateTriggeredChatCommands(param1:Object) : void;
      
      function as_setChatCommand(param1:Number, param2:String, param3:uint) : void;
   }
}
