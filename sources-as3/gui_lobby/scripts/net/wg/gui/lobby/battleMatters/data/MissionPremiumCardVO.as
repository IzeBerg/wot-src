package net.wg.gui.lobby.battleMatters.data
{
   import net.wg.gui.lobby.missions.data.MissionCardViewVO;
   
   public class MissionPremiumCardVO extends MissionCardViewVO
   {
       
      
      public var checkStates:Array = null;
      
      public function MissionPremiumCardVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this.checkStates != null)
         {
            this.checkStates.splice(0,this.checkStates.length);
            this.checkStates = null;
         }
         super.onDispose();
      }
   }
}
