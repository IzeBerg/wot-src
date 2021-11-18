package net.wg.gui.lobby.rankedBattles19.view.rewards.ranks
{
   import flash.display.Sprite;
   import net.wg.gui.components.common.FrameStateCmpnt;
   
   public class RankShieldLevel extends FrameStateCmpnt
   {
       
      
      public var hitAreaMc:Sprite = null;
      
      public function RankShieldLevel()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         hitArea = this.hitAreaMc;
      }
      
      override protected function onDispose() : void
      {
         hitArea = null;
         this.hitAreaMc = null;
         super.onDispose();
      }
   }
}
