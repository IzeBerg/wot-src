package net.wg.gui.lobby.battleResults.components
{
   public class ScrollbarTeamMemberItemRenderer extends TeamMemberItemRenderer
   {
      
      private static const SCROLL_BAR_OFFSET:int = 13;
      
      private static const SCROLL_PLAYER_NAME_WIDTH:int = 106;
       
      
      public function ScrollbarTeamMemberItemRenderer()
      {
         super();
         xOffset = -SCROLL_BAR_OFFSET;
         playerNameWidth = SCROLL_PLAYER_NAME_WIDTH;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         playerName.width = playerNameWidth;
      }
   }
}
