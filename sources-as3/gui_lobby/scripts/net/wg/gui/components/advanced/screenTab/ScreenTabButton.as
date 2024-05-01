package net.wg.gui.components.advanced.screenTab
{
   import flash.display.MovieClip;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.SoundButtonEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class ScreenTabButton extends SoundButtonEx
   {
      
      private static const TEXT_DEFAULT_W_OFFSET:int = 14;
      
      private static const LAST_LINE_INVALID:String = "lli";
       
      
      public var hit:MovieClip;
      
      public var highLight:MovieClip;
      
      public var backGround:ScreenTabButtonBg;
      
      protected var trueWidth:int = 0;
      
      private var _textWOffset:int = 14;
      
      private var _showLastLineItem:Boolean;
      
      private var _widthOffset:uint;
      
      public function ScreenTabButton()
      {
         super();
         preventAutosizing = true;
         constraintsDisabled = true;
         this._widthOffset = this.highLight.width - this.backGround.width;
      }
      
      override protected function onDispose() : void
      {
         this.backGround.dispose();
         this.hit = null;
         this.highLight = null;
         this.backGround = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         hitArea = this.hit;
         this.hit.visible = false;
      }
      
      override protected function draw() : void
      {
         if(_baseDisposed)
         {
            return;
         }
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            textField.autoSize = TextFieldAutoSize.LEFT;
            textField.x = this._textWOffset;
            this.trueWidth = this.receiveWidth();
            this.highLight.width = this.trueWidth + this._widthOffset;
            this.backGround.width = this.trueWidth;
            this.hit.width = this.trueWidth;
         }
         if(isInvalid(LAST_LINE_INVALID))
         {
            this.backGround.showLastLineItem(this._showLastLineItem);
         }
      }
      
      override protected function updateAfterStateChange() : void
      {
         super.updateAfterStateChange();
         this.backGround.selected = _selected;
         invalidate(LAST_LINE_INVALID);
         invalidateSize();
      }
      
      override protected function updateText() : void
      {
         super.updateText();
         invalidate(InvalidationType.SIZE);
      }
      
      private function receiveWidth() : uint
      {
         if(textField != null)
         {
            return textField.width + (this._textWOffset << 1);
         }
         return super.width;
      }
      
      override public function set data(param1:Object) : void
      {
         super.data = param1;
         if(data is String)
         {
            this.label = param1.toString();
         }
         else
         {
            this.label = data.label;
         }
      }
      
      override public function set label(param1:String) : void
      {
         super.label = App.utils.toUpperOrLowerCase(param1,true);
      }
      
      override public function get width() : Number
      {
         return this.receiveWidth();
      }
      
      public function set showLastLineItem(param1:Boolean) : void
      {
         this._showLastLineItem = param1;
         invalidate(LAST_LINE_INVALID);
      }
      
      public function get textWOffset() : int
      {
         return this._textWOffset;
      }
      
      public function set textWOffset(param1:int) : void
      {
         this._textWOffset = param1;
         invalidateSize();
      }
   }
}
