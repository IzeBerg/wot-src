package net.wg.gui.battle.historicalBattles.teamBasesPanel
{
   import net.wg.gui.battle.random.views.teamBasesPanel.TeamBasesPanel;
   import net.wg.gui.battle.random.views.teamBasesPanel.TeamCaptureBar;
   import scaleform.clik.motion.Tween;
   
   public class HBTeamBasesPanel extends TeamBasesPanel
   {
      
      private static const ALPHA_FADE_SPEED:Number = 500;
      
      private static const EXIT_TWEEN_Y:int = -50;
      
      private static const EXIT_TWEEN_DELAY:Number = 800;
       
      
      private var _exitTween:Tween = null;
      
      public function HBTeamBasesPanel()
      {
         super();
      }
      
      override public function as_setCaptured(param1:Number, param2:String) : void
      {
         super.as_setCaptured(param1,param2);
         var _loc3_:TeamCaptureBar = getCaptureBarById(param1);
         this._exitTween = new Tween(ALPHA_FADE_SPEED,_loc3_,{
            "y":EXIT_TWEEN_Y,
            "alpha":0
         },{
            "delay":EXIT_TWEEN_DELAY,
            "onComplete":this.clearExitTween
         });
      }
      
      override protected function onDispose() : void
      {
         this.clearExitTween();
         super.onDispose();
      }
      
      private function clearExitTween() : void
      {
         if(this._exitTween)
         {
            this._exitTween.dispose();
            this._exitTween = null;
         }
      }
   }
}
