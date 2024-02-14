package net.wg.gui.bootcamp.battleResult.containers.bottomReward
{
   import net.wg.gui.bootcamp.battleResult.containers.base.BattleResultGroupLayout;
   
   public class BottomRewardGroupLayout extends BattleResultGroupLayout
   {
       
      
      public function BottomRewardGroupLayout(param1:int = 0, param2:int = 0)
      {
         super(param1,param2);
      }
      
      override protected function rendererHeight() : int
      {
         return imageSize;
      }
   }
}
