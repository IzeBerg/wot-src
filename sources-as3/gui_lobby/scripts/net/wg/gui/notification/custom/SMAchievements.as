package net.wg.gui.notification.custom
{
   import flash.events.Event;
   import flash.text.TextFormatAlign;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.notification.ServiceMessageContent;
   import scaleform.clik.constants.InvalidationType;
   
   public class SMAchievements extends ServiceMessageContent
   {
      
      private static const EMBLEM_ICON_WIDTH:int = 290;
      
      private static const EMBLEM_ICON_HEIGHT:int = 260;
      
      private static const MESSAGE_WIDTH:uint = 289;
       
      
      public var emblemIcon:Image;
      
      public function SMAchievements()
      {
         super();
         buttonsAlign = TextFormatAlign.CENTER;
      }
      
      override protected function updateData() : void
      {
         super.updateData();
         this.emblemIcon.addEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.emblemIcon.source = data.messageVO.linkageData.icon;
         bgIcon.source = RES_ICONS.MAPS_ICONS_ACHIEVEMENTS_MESSENGER_BACKGROUND;
      }
      
      override public function get width() : Number
      {
         return MESSAGE_WIDTH;
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
