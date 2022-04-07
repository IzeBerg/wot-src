package net.wg.gui.lobby.battleResults.components
{
   import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
   
   public class RTSTankersTeamMemberItemRenderer extends ScrollbarTeamMemberItemRenderer
   {
       
      
      public function RTSTankersTeamMemberItemRenderer()
      {
         super();
      }
      
      override protected function showData(param1:TeamMemberItemVO) : void
      {
         super.showData(param1);
         medalIcon.visible = false;
      }
   }
}
