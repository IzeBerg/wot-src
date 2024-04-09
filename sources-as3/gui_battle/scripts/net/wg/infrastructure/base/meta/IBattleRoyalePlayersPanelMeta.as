package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleRoyalePlayersPanelMeta extends IEventDispatcher
   {
       
      
      function switchToPlayerS(param1:int) : void;
      
      function as_setPlayersData(param1:Array, param2:int) : void;
      
      function as_setRespawnVisibility(param1:Boolean) : void;
      
      function as_setIsSquadMode(param1:Boolean) : void;
   }
}
