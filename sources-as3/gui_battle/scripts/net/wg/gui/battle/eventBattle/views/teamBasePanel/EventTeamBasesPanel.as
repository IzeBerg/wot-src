package net.wg.gui.battle.eventBattle.views.teamBasePanel
{
   import net.wg.data.constants.Linkages;
   import net.wg.gui.battle.random.views.teamBasesPanel.TeamBasesPanel;
   
   public class EventTeamBasesPanel extends TeamBasesPanel
   {
       
      
      public function EventTeamBasesPanel()
      {
         super();
      }
      
      override protected function getBarLinkage() : String
      {
         return Linkages.EVENT_CAPTURE_BAR_LINKAGE;
      }
   }
}
