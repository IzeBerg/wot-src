package net.wg.gui.battle.views.minimap.components.entries.personal
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class SimpleAttentionToFlashMinimapEntry extends BattleUIComponent
   {
      
      private static const _START_ANIMATION_FRAME:uint = 1;
       
      
      public var mcAnimation:MovieClip = null;
      
      public function SimpleAttentionToFlashMinimapEntry()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.mcAnimation = null;
         super.onDispose();
      }
      
      public function playAnimation() : void
      {
         if(this.mcAnimation != null)
         {
            this.mcAnimation.gotoAndPlay(_START_ANIMATION_FRAME);
         }
      }
   }
}
