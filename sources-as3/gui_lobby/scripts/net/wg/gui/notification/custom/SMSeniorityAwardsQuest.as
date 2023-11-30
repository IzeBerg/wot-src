package net.wg.gui.notification.custom
{
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.notification.ServiceMessageContent;
   import scaleform.clik.controls.Button;
   
   public class SMSeniorityAwardsQuest extends ServiceMessageContent
   {
      
      private static const CONTENT_TOP_OFFSET:int = 0;
      
      private static const CONTENT_BOTTOM_OFFSET:int = 33;
      
      private static const MESSAGE_WIDTH:uint = 289;
       
      
      public var closeBtn:Button = null;
      
      public function SMSeniorityAwardsQuest()
      {
         super();
         contentTopOffset = CONTENT_TOP_OFFSET;
         contentBottomOffset = CONTENT_BOTTOM_OFFSET;
         buttonsAlign = TextFormatAlign.CENTER;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.closeBtn.addEventListener(MouseEvent.ROLL_OVER,this.onCloseBtnRollOverHandler);
         this.closeBtn.addEventListener(MouseEvent.CLICK,this.onCloseBtnClickHandler);
      }
      
      override protected function updateData() : void
      {
         super.updateData();
         bgIcon.source = RES_ICONS.MAPS_ICONS_SENIORITYAWARDS_MESSENGER_POPUP_NOTIFICATION_QUEST_BG;
      }
      
      override protected function onDispose() : void
      {
         this.closeBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onCloseBtnRollOverHandler);
         this.closeBtn.removeEventListener(MouseEvent.CLICK,this.onCloseBtnClickHandler);
         this.closeBtn.dispose();
         this.closeBtn = null;
         super.onDispose();
      }
      
      override public function get width() : Number
      {
         return MESSAGE_WIDTH;
      }
      
      private function onCloseBtnRollOverHandler(param1:MouseEvent) : void
      {
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.CLOSE_WINDOW,null);
      }
      
      private function onCloseBtnClickHandler(param1:MouseEvent) : void
      {
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,SoundTypes.OK_BTN,null);
      }
   }
}
