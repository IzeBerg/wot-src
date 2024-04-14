package net.wg.gui.lobby.profile.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class LineTextComponent extends UIComponentEx
   {
      
      private static const TEXT_INV:String = "textInv";
       
      
      public var leftLine:MovieClip;
      
      public var rightLine:MovieClip;
      
      public var textField:TextField;
      
      private var _text:String = "";
      
      public function LineTextComponent()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         super.draw();
         if(isInvalid(TEXT_INV))
         {
            this.textField.autoSize = TextFieldAutoSize.LEFT;
            this.textField.text = this._text;
            invalidate(InvalidationType.SIZE);
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = _width - this.textField.width >> 1;
            this.leftLine.width = this.rightLine.width = Math.round(_loc1_);
            this.textField.x = _loc1_;
            this.rightLine.x = _width - _loc1_;
         }
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(param1:String) : void
      {
         this._text = param1;
         invalidate(TEXT_INV);
      }
      
      override protected function onDispose() : void
      {
         this.leftLine = null;
         this.rightLine = null;
         this.textField = null;
         super.onDispose();
      }
   }
}
