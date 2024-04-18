package net.wg.gui.notification.custom
{
   import flash.events.Event;
   import flash.text.TextFormatAlign;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.notification.ServiceMessageContent;
   import scaleform.clik.constants.InvalidationType;
   
   public class NotificationAchievements extends ServiceMessageContent
   {
      
      private static const EMBLEM_ICON_WIDTH:int = 232;
      
      private static const EMBLEM_ICON_HEIGHT:int = 208;
      
      private static const MESSAGE_HEIGHT:uint = 290;
       
      
      public var emblemIcon:Image;
      
      public function NotificationAchievements()
      {
         super();
         buttonsAlign = TextFormatAlign.CENTER;
      }
      
      override public function get height() : Number
      {
         return MESSAGE_HEIGHT;
      }
      
      override protected function updateData() : void
      {
         super.updateData();
         this.emblemIcon.addEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.emblemIcon.source = data.messageVO.linkageData.icon;
         bgIcon.source = RES_ICONS.MAPS_ICONS_ACHIEVEMENTS_MESSENGER_GODRAYS;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.emblemIcon.width = EMBLEM_ICON_WIDTH;
            this.emblemIcon.height = EMBLEM_ICON_HEIGHT;
         }
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
      
      override protected function onBeforeDispose() : void
      {
         this.emblemIcon.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.emblemIcon.dispose();
         this.emblemIcon = null;
         super.onDispose();
      }
   }
}
