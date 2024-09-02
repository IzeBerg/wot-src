package net.wg.gui.notification
{
   import flash.display.Sprite;
   
   public class PostProgressionStyleMessageContent extends ServiceMessageContent
   {
      
      private static const BUTTONS_GROUP_PADDING_TOP:int = 10;
      
      private static const MESSAGE_PADDING_BOTTOM:int = 20;
      
      private static const DEFAULT_TEXTFIELD_HEIGHT:uint = 40;
       
      
      public var glow:Sprite = null;
      
      public var sparkles:Sprite = null;
      
      public var redGlow:Sprite = null;
      
      private var _heightOffset:uint = 0;
      
      private var _defaultHeight:uint = 0;
      
      private var _messageWidth:uint = 288;
      
      public function PostProgressionStyleMessageContent()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.redGlow.mouseChildren = this.redGlow.mouseEnabled = false;
         App.utils.commons.addEmptyHitArea(this.redGlow);
         this._defaultHeight = background.y + background.height;
         this._messageWidth = background.width;
      }
      
      override protected function onDispose() : void
      {
         this.glow = null;
         this.sparkles = null;
         this.redGlow = null;
         super.onDispose();
      }
      
      override protected function updateLayout() : void
      {
         if(timeComponent != null)
         {
            timeComponent.visible = false;
         }
         App.utils.commons.updateTextFieldSize(textField,false,true);
         this._heightOffset = textField.height > DEFAULT_TEXTFIELD_HEIGHT ? uint(textField.height - DEFAULT_TEXTFIELD_HEIGHT | 0) : uint(0);
         background.height = _bgDefHeight + this._heightOffset;
         hitArea.height = this._defaultHeight + this._heightOffset;
         if(buttonsGroup != null)
         {
            buttonsGroup.x = this._messageWidth - buttonsGroup.width >> 1;
            buttonsGroup.y = this._defaultHeight + this._heightOffset - buttonsGroup.height - MESSAGE_PADDING_BOTTOM | 0;
         }
         textField.y = buttonsGroup.y - BUTTONS_GROUP_PADDING_TOP - textField.height;
      }
      
      override protected function updateData() : void
      {
         super.updateData();
         if(messageInfo.linkageData != null)
         {
            this.glow.visible = this.sparkles.visible = messageInfo.linkageData.canClaimReward;
         }
      }
      
      override public function get width() : Number
      {
         return this._messageWidth;
      }
      
      override public function get height() : Number
      {
         return this._defaultHeight + this._heightOffset;
      }
   }
}
