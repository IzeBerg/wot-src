package net.wg.white_tiger.gui.battle.views.wtTeamBasePanel
{
   import net.wg.gui.battle.random.views.teamBasesPanel.TeamCaptureProgressReset;
   
   public class TeamCaptureProgressReset extends net.wg.gui.battle.random.views.teamBasesPanel.TeamCaptureProgressReset
   {
      
      private static const RESET_BITMAP_SRC:String = "ResetBaseLine_";
       
      
      public function TeamCaptureProgressReset()
      {
         super();
      }
      
      override protected function getBitmapSrcPrefix() : String
      {
         return RESET_BITMAP_SRC;
      }
   }
}
