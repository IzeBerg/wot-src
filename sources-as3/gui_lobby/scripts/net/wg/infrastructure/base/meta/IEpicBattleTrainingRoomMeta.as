package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEpicBattleTrainingRoomMeta extends IEventDispatcher
   {
       
      
      function onChangeTeamLaneS(param1:int, param2:int, param3:int) : void;
      
      function onSwapTeamLaneS(param1:int, param2:int, param3:int, param4:int) : void;
   }
}
