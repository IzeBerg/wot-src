package net.wg.gui.battle.eventBattle.views.teamBasePanel
{
   import net.wg.gui.battle.random.views.teamBasesPanel.TeamCaptureProgressReset;
   
   public class EventTeamCaptureProgressReset extends TeamCaptureProgressReset
   {
      
      private static const RESET_BITMAP_SRC:String = "ResetBaseLine_";
       
      
      public function EventTeamCaptureProgressReset()
      {
         super();
      }
      
      override protected function getBitmapSrcPrefix() : String
      {
         return RESET_BITMAP_SRC;
      }
   }
}
