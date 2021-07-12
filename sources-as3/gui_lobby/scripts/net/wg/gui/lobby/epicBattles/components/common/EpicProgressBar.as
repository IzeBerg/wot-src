package net.wg.gui.lobby.epicBattles.components.common
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.gui.components.advanced.vo.ProgressBarAnimVO;
   import net.wg.gui.components.controls.BitmapFill;
   import net.wg.gui.components.controls.IProgressBar;
   import net.wg.gui.components.controls.StatusIndicatorEx;
   
   public class EpicProgressBar extends StatusIndicatorEx implements IProgressBar
   {
      
      private static const INVALID_RANGE:String = "invalidRange";
      
      private static const FILL_SRC:String = "EpicProgressBmp";
      
      private static const FILL_GREEN_SRC:String = "EpicProgressGreenBmp";
      
      private static const GREEN_MARKER_FRAME_LABEL:String = "green";
      
      private static const ORANGE_MARKER_FRAME_LABEL:String = "orange";
       
      
      public var marker:MovieClip = null;
      
      public var commonBar:BitmapFill = null;
      
      public var bg:BitmapFill = null;
      
      public var gradient:Sprite = null;
      
      [Inspectable(defaultValue="false",verbose="1")]
      public var showBorder:Boolean = false;
      
      public var bgLeftBorder:BitmapFill = null;
      
      public var bgRightBorder:BitmapFill = null;
      
      private var _onePercent:Number = 0;
      
      private var _onePercentWidth:Number = 0;
      
      public function EpicProgressBar()
      {
         super();
      }
      
      override protected function draw() : void
      {
         if(isInvalid(INVALID_RANGE))
         {
            this._onePercent = (_maximum - _minimum) / 100;
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         this.bg.dispose();
         this.commonBar.dispose();
         this.bgLeftBorder.dispose();
         this.bgRightBorder.dispose();
         this.bg = null;
         this.gradient = null;
         this.commonBar = null;
         this.marker = null;
         super.onDispose();
      }
      
      override protected function updatePosition() : void
      {
         this._onePercentWidth = this.width / scaleX / 100;
         this.commonBar.width = _value / this._onePercent * this._onePercentWidth ^ 0;
         this.marker.visible = value > 0;
         this.marker.x = this.commonBar.widthFill;
         this.gradient.width = value > 0 ? Number(this.commonBar.widthFill) : Number(0);
         if(this.bgLeftBorder.visible != this.showBorder)
         {
            this.bgLeftBorder.visible = this.showBorder;
         }
         if(this.bgRightBorder.visible != this.showBorder)
         {
            this.bgRightBorder.visible = this.showBorder;
         }
         if(this.showBorder)
         {
            this.bgRightBorder.x = this.bg.widthFill - this.bgRightBorder.widthFill | 0;
         }
      }
      
      public function setData(param1:ProgressBarAnimVO) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.minimum = param1.minValue;
         this.maximum = param1.maxValue;
         value = param1.value;
         this.isGreen = param1.isGreen;
      }
      
      override public function set minimum(param1:Number) : void
      {
         if(param1 != super.minimum)
         {
            super.minimum = param1;
            invalidate(INVALID_RANGE);
         }
      }
      
      override public function set maximum(param1:Number) : void
      {
         if(param1 != super.maximum)
         {
            super.maximum = param1;
            invalidate(INVALID_RANGE);
         }
      }
      
      override public function get width() : Number
      {
         return this.bg.widthFill;
      }
      
      override public function set width(param1:Number) : void
      {
         this.bg.widthFill = param1;
      }
      
      override public function get height() : Number
      {
         return this.bg.heightFill;
      }
      
      override public function set height(param1:Number) : void
      {
         this.bg.heightFill = param1;
      }
      
      public function set isGreen(param1:Boolean) : void
      {
         if(param1)
         {
            this.marker.gotoAndStop(GREEN_MARKER_FRAME_LABEL);
            this.commonBar.source = FILL_GREEN_SRC;
         }
         else
         {
            this.marker.gotoAndStop(ORANGE_MARKER_FRAME_LABEL);
            this.commonBar.source = FILL_SRC;
         }
      }
   }
}
