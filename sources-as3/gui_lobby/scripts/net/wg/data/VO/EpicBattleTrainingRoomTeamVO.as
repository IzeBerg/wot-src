package net.wg.data.VO
{
   public class EpicBattleTrainingRoomTeamVO extends TrainingRoomTeamBaseVO
   {
       
      
      public var listData:Array = null;
      
      public var lane:int = -1;
      
      public function EpicBattleTrainingRoomTeamVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this.listData != null)
         {
            this.listData.splice(0);
            this.listData = null;
         }
         super.onDispose();
      }
   }
}
