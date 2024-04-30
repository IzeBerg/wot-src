package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IHBPlayersPanelMeta extends IEventDispatcher
   {
       
      
      function acceptSquadS(param1:String) : void;
      
      function addToSquadS(param1:String) : void;
      
      function switchToOtherPlayerS(param1:Number) : void;
      
      function as_getDP() : Object;
      
      function as_setPlayerHp(param1:int, param2:int, param3:int, param4:Boolean) : void;
      
      function as_setPlayerCountLives(param1:int, param2:int) : void;
      
      function as_setChatCommand(param1:int, param2:String, param3:uint) : void;
      
      function as_setChatCommandsVisibility(param1:Boolean) : void;
      
      function as_setPlayersSwitchingAllowed(param1:Boolean) : void;
   }
}
