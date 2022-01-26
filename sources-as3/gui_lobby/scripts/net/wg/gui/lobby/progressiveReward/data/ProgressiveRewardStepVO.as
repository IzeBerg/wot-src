package net.wg.gui.lobby.progressiveReward.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ProgressiveRewardStepVO extends DAAPIDataClass
   {
       
      
      public var stepState:String = "";
      
      public var rewardType:String = "";
      
      public function ProgressiveRewardStepVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
