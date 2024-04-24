package net.wg.gui.lobby.fortifications.battleRoom
{
   import flash.events.MouseEvent;
   import net.wg.gui.rally.views.room.ChatSectionWithDescription;
   
   public class SortieChatSection extends ChatSectionWithDescription
   {
       
      
      public function SortieChatSection()
      {
         super();
      }
      
      private static function hideTooltip(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private static function onDescrBtnOver(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_CHAT_DESCRIPTION);
      }
      
      private static function onChatSubmitButton(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_CHAT_SENDMESSAGEBTN);
      }
      
      override protected function draw() : void
      {
         super.draw();
         editDescriptionButton.visible = false;
         editCommitButton.visible = false;
         descriptionInput.visible = false;
         descriptionTF.visible = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         editDescriptionButton.addEventListener(MouseEvent.ROLL_OVER,onDescrBtnOver);
         editDescriptionButton.addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
         editCommitButton.addEventListener(MouseEvent.ROLL_OVER,onDescrBtnOver);
         editCommitButton.addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
         chatSubmitButton.addEventListener(MouseEvent.ROLL_OVER,onChatSubmitButton);
         chatSubmitButton.addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
      }
      
      override protected function onDispose() : void
      {
         editDescriptionButton.removeEventListener(MouseEvent.ROLL_OVER,onDescrBtnOver);
         editDescriptionButton.removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
         editCommitButton.removeEventListener(MouseEvent.ROLL_OVER,onDescrBtnOver);
         editCommitButton.removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
         chatSubmitButton.removeEventListener(MouseEvent.ROLL_OVER,onDescrBtnOver);
         chatSubmitButton.removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
         chatSubmitButton.removeEventListener(MouseEvent.ROLL_OVER,onChatSubmitButton);
         chatSubmitButton.removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
         super.onDispose();
      }
      
      override protected function getHeader() : String
      {
         return FORTIFICATIONS.SORTIE_ROOM_CHAT;
      }
   }
}
