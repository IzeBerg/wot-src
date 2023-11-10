package net.wg.gui.lobby.missions
{
   import fl.motion.easing.Cubic;
   import net.wg.infrastructure.base.meta.IBattleMattersViewMeta;
   import net.wg.infrastructure.base.meta.impl.BattleMattersViewMeta;
   import scaleform.clik.motion.Tween;
   
   public class MissionsBattleMattersView extends BattleMattersViewMeta implements IBattleMattersViewMeta
   {
      
      private static const FADE_IN_DURATION:Number = 400;
       
      
      public function MissionsBattleMattersView()
      {
         super();
         alpha = 0;
      }
      
      override protected function playFadeInTween() : void
      {
         alpha = 0;
         this.setFadeInTween(0);
         _hasBeenShownBefore = true;
      }
      
      override protected function setFadeInTween(param1:int) : void
      {
         _fadeInTween = new Tween(FADE_IN_DURATION,this,{"alpha":1},{
            "paused":false,
            "ease":Cubic.easeOut,
            "delay":param1,
            "onComplete":null
         });
         _fadeInTween.fastTransform = false;
      }
      
      private function hideView() : void
      {
         alpha = 0;
      }
      
      public function as_hideView() : void
      {
         this.hideView();
      }
   }
}
