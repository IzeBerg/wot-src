package net.wg.white_tiger.gui.battle.views.wtTeamBasePanel
{
   import net.wg.data.constants.Linkages;
   import net.wg.gui.battle.random.views.teamBasesPanel.TeamBasesPanel;
   
   public class TeamBasesPanel extends net.wg.gui.battle.random.views.teamBasesPanel.TeamBasesPanel
   {
       
      
      public function TeamBasesPanel()
      {
         super();
      }
      
      override protected function getBarLinkage() : String
      {
         return Linkages.WT_CAPTURE_BAR_LINKAGE;
      }
   }
}
