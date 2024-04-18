package net.wg.gui.lobby.rankedBattles19.view.rewards.ranks
{
   import net.wg.data.constants.generated.RANKEDBATTLES_CONSTS;
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   
   public class QualificationRewardsView extends GFInjectComponent
   {
      
      private static const MAX_COUNT:int = 13;
       
      
      public function QualificationRewardsView()
      {
         super();
         setManageSize(true);
      }
      
      public function get rewardsIconSize() : String
      {
         return RANKEDBATTLES_CONSTS.RANKED_REWARDS_REWARD_SIZE_BIG;
      }
      
      public function get rewardsCount() : int
      {
         return MAX_COUNT;
      }
   }
}
