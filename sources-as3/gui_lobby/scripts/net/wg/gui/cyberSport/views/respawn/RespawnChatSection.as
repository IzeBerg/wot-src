package net.wg.gui.cyberSport.views.respawn
{
   import net.wg.gui.rally.views.room.BaseChatSection;
   
   public class RespawnChatSection extends BaseChatSection
   {
       
      
      public function RespawnChatSection()
      {
         super();
      }
      
      override protected function getHeader() : String
      {
         return CYBERSPORT.RESPAWN_CHATHEADER;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         channelComponent.isReturnToNormalScale = true;
      }
   }
}
