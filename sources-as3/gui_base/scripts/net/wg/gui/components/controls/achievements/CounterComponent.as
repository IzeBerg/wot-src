package net.wg.gui.components.controls.achievements
{
   import flash.display.MovieClip;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.interfaces.ICounterComponent;
   
   public class CounterComponent extends SoundButtonEx implements ICounterComponent
   {
      
      private static const LAYOUT_INV:String = "layoutInvalid";
      
      private static const COUNT_INV:String = "countInvalid";
       
      
      public var background:MovieClip;
      
      private var _minBgWindowWidth:uint = 20;
      
      private var _text:String = "0";
      
      private var originalBgWidth:uint = 0;
      
      public function CounterComponent()
      {
         super();
         this.originalBgWidth = this.background.width;
      }
      
      override protected function onDispose() : void
      {
         this.background = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         super.draw();
         if(isInvalid(COUNT_INV))
         {
            textField.autoSize = TextFieldAutoSize.LEFT;
            textField.text = this._text.toString();
            invalidate(LAYOUT_INV);
         }
         if(isInvalid(LAYOUT_INV))
         {
            _loc1_ = textField.width - this._minBgWindowWidth;
            if(_loc1_ > 0)
            {
               _loc2_ = this.originalBgWidth + _loc1_;
            }
            else
            {
               _loc2_ = this.originalBgWidth;
            }
            this.background.width = _loc2_;
            textField.x = _loc2_ - textField.width >> 1;
         }
      }
      
      override public function get width() : Number
      {
         return actualWidth;
      }
      
      [Inspectable(defaultValue="10",type="Number")]
      public function get minBgWindowWidth() : uint
      {
         return this._minBgWindowWidth;
      }
      
      public function set minBgWindowWidth(param1:uint) : void
      {
         this._minBgWindowWidth = param1;
         invalidate(LAYOUT_INV);
      }
      
      [Inspectable(defaultValue="0",type="String")]
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(param1:String) : void
      {
         this._text = param1;
         invalidate(COUNT_INV);
      }
      
      public function receiveBottomPadding() : Number
      {
         return 0;
      }
   }
}
