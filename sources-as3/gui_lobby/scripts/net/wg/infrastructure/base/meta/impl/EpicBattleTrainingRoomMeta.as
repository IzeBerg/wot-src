package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.training.TrainingRoomBase;
   
   public class EpicBattleTrainingRoomMeta extends TrainingRoomBase
   {
       
      
      public var onChangeTeamLane:Function;
      
      public var onSwapTeamLane:Function;
      
      public function EpicBattleTrainingRoomMeta()
      {
         super();
      }
      
      public function onChangeTeamLaneS(param1:int, param2:int, param3:int) : void
      {
         App.utils.asserter.assertNotNull(this.onChangeTeamLane,"onChangeTeamLane" + Errors.CANT_NULL);
         this.onChangeTeamLane(param1,param2,param3);
      }
      
      public function onSwapTeamLaneS(param1:int, param2:int, param3:int, param4:int) : void
      {
         App.utils.asserter.assertNotNull(this.onSwapTeamLane,"onSwapTeamLane" + Errors.CANT_NULL);
         this.onSwapTeamLane(param1,param2,param3,param4);
      }
   }
}
