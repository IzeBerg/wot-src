package net.wg.gui.cyberSport.views.unit
{
   import net.wg.gui.rally.views.room.ChatSectionWithDescription;
   
   public class ChatSection extends ChatSectionWithDescription
   {
       
      
      public function ChatSection()
      {
         super();
      }
      
      override protected function getHeader() : String
      {
         return CYBERSPORT.WINDOW_UNIT_CHAT;
      }
      
      override protected function changeTextFormat() : void
      {
      }
   }
}
