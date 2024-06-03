package net.wg.gui.notification
{
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class BondEquipmentChoosingMessageContent extends ServiceMessageContent
   {
      
      private static const BUTTONS_GROUP_PADDING_TOP:int = 17;
      
      private static const MESSAGE_PADDING_BOTTOM:int = 24;
      
      private static const MESSAGE_WIDTH:uint = 288;
       
      
      public var headerIcon:Sprite;
      
      public function BondEquipmentChoosingMessageContent()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.headerIcon.mouseEnabled = this.headerIcon.mouseChildren = false;
      }
      
      override protected function onDispose() : void
      {
         this.headerIcon = null;
         super.onDispose();
      }
      
      override public function get width() : Number
      {
         return MESSAGE_WIDTH;
      }
      
      override public function get height() : Number
      {
         return background.y + background.height;
      }
      
      override protected function updateLayout() : void
      {
         icon.visible = false;
         if(timeComponent != null)
         {
            timeComponent.visible = false;
         }
         App.utils.commons.updateTextFieldSize(textField,false,true);
         var _loc1_:uint = textField.y + textField.height + MESSAGE_PADDING_BOTTOM;
         if(buttonsGroup != null)
         {
            buttonsGroup.x = MESSAGE_WIDTH - buttonsGroup.width >> 1;
            buttonsGroup.y = textField.y + textField.height + BUTTONS_GROUP_PADDING_TOP | 0;
            _loc1_ += BUTTONS_GROUP_PADDING_TOP + buttonsGroup.height;
         }
         var _loc2_:uint = bgIcon.y;
         if(bgIcon.source)
         {
            _loc2_ += !!data.messageVO.bgIconSizeAuto ? bgIcon.height : data.messageVO.bgIconHeight;
         }
         var _loc3_:uint = Math.max(_loc1_,_loc2_) - background.y;
         if(_loc3_ != background.height)
         {
            background.height = _loc3_;
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
   }
}
