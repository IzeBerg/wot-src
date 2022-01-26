package net.wg.gui.bootcamp.battleResult.containers.bottomReward
{
   import flash.display.MovieClip;
   import net.wg.gui.bootcamp.battleResult.containers.base.BaseRenderer;
   
   public class BottomRewardRenderer extends BaseRenderer
   {
       
      
      public var glowMC:MovieClip = null;
      
      public var glowOverMC:MovieClip = null;
      
      public function BottomRewardRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.glowMC.mouseEnabled = false;
         this.glowOverMC.mouseEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         this.glowMC = null;
         this.glowOverMC = null;
         super.onDispose();
      }
   }
}
