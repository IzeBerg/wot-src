package net.wg.gui.notification
{
   import flash.display.Sprite;
   import net.wg.gui.lobby.prestige.components.common.PrestigeEmblem;
   
   public class PrestigeStyleMessageContent extends ServiceMessageContent
   {
      
      private static const BUTTONS_GROUP_PADDING_TOP:int = 10;
      
      private static const MESSAGE_PADDING_BOTTOM:int = 20;
      
      private static const EMBLEM_X_OFFSET:uint = 55;
      
      private static const EMBLEM_Y_OFFSET:uint = 15;
      
      private static const DEFAULT_TEXTFIELD_HEIGHT:uint = 40;
      
      private static const EMBLEM_NAME:String = "emblem";
       
      
      public var sparkles:Sprite = null;
      
      public var emblemShadow:Sprite = null;
      
      public var redGlow:Sprite = null;
      
      private var _emblem:PrestigeEmblem = null;
      
      private var _heightOffset:uint = 0;
      
      private var _defaultHeight:uint = 0;
      
      private var _messageWidth:uint = 288;
      
      public function PrestigeStyleMessageContent()
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
         this._emblem = new PrestigeEmblem();
         this._emblem.name = EMBLEM_NAME;
         this._emblem.x = this.emblemShadow.x + EMBLEM_X_OFFSET;
         this._emblem.y = this.emblemShadow.y - EMBLEM_Y_OFFSET;
         this._emblem.size = PrestigeEmblem.SIZE_MEDIUM;
         addChildAt(this._emblem,getChildIndex(this.emblemShadow) + 1);
      }
      
      override protected function onDispose() : void
      {
         this.sparkles = null;
         this.emblemShadow = null;
         this.redGlow = null;
         if(this._emblem)
         {
            removeChild(this._emblem);
            this._emblem.dispose();
            this._emblem = null;
         }
         super.onDispose();
      }
      
      override protected function updateLayout() : void
      {
         icon.visible = false;
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
      
      override protected function processCustomData(param1:Object) : void
      {
         if(param1 != null)
         {
            this._emblem.setData(param1.type,param1.grade,param1.lvl);
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
