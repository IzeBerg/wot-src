package net.wg.gui.battle.eventBattle.views.battleHints
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.eventBattle.views.battleHints.data.HintInfoVO;
   
   public class InfoBaseContainer extends InfoContainer
   {
       
      
      public var glow:MovieClip = null;
      
      public function InfoBaseContainer()
      {
         super();
      }
      
      override public function showHint(param1:HintInfoVO) : void
      {
         super.showHint(param1);
         this.glow.gotoAndStop(param1.bgLabel);
      }
      
      override protected function onDispose() : void
      {
         this.glow = null;
         super.onDispose();
      }
   }
}
