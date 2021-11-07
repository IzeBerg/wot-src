package net.wg.gui.components.controls
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.AlignType;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class ImageComponent extends UIComponentEx
   {
       
      
      public var image:Image;
      
      protected var _tooltipEnabled:Boolean = true;
      
      protected var _horizontalAlign:String = "left";
      
      protected var _verticalAlign:String = "top";
      
      protected var _paddingTop:int = 0;
      
      protected var _paddingBottom:int = 0;
      
      protected var _paddingLeft:int = 0;
      
      protected var _paddingRight:int = 0;
      
      protected var _horizontalCenter:int = 0;
      
      protected var _verticalCenter:int = 0;
      
      private var _toolTip:String = "";
      
      private var _adjustSize:Boolean = true;
      
      public function ImageComponent()
      {
         super();
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         this._adjustSize = false;
         super.setSize(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.image.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.image.dispose();
         this.image = null;
         super.onDispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.image.addEventListener(Event.CHANGE,this.onImageChangeHandler);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         useHandCursor = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE,InvalidationType.LAYOUT))
         {
            this.updateLayout();
         }
      }
      
      public function readjustSize() : void
      {
         this.adjustSizeToImage(true);
      }
      
      protected function updateLayout() : void
      {
         if(this._horizontalAlign == AlignType.LEFT)
         {
            this.image.x = this._paddingLeft;
         }
         else if(this._horizontalAlign == AlignType.CENTER)
         {
            this.image.x = (_width - this.image.width >> 1) + this._horizontalCenter;
         }
         else if(this._horizontalAlign == AlignType.RIGHT)
         {
            this.image.x = _width - this.image.width - this._paddingRight;
         }
         else if(this._horizontalAlign == AlignType.FIT_TO_SIZE)
         {
            this.image.x = this._paddingLeft;
            this.image.width = _width - this._paddingLeft - this._paddingRight;
         }
         else
         {
            App.utils.asserter.assert(false,"invalid horizontalAlign:" + this._horizontalAlign);
         }
         if(this._verticalAlign == AlignType.TOP)
         {
            this.image.y = this._paddingTop;
         }
         else if(this._verticalAlign == AlignType.CENTER)
         {
            this.image.y = (_height - this.image.height >> 1) + this._verticalCenter;
         }
         else if(this._verticalAlign == AlignType.BOTTOM)
         {
            this.image.y = _height - this.image.height - this._paddingBottom;
         }
         else if(this._verticalAlign == AlignType.FIT_TO_SIZE)
         {
            this.image.y = this._paddingTop;
            this.image.height = _height - this._paddingTop - this._paddingBottom;
         }
         else
         {
            App.utils.asserter.assert(false,"invalid verticalAlign:" + this._verticalAlign);
         }
      }
      
      private function adjustSizeToImage(param1:Boolean) : void
      {
         this._paddingTop = this._paddingBottom = this._paddingLeft = this._paddingRight = 0;
         this._horizontalCenter = -this.image.bitmapWidth >> 1;
         this._verticalCenter = -this.image.bitmapHeight >> 1;
         param1 = param1 || (this.image.bitmapWidth != _width || this.image.bitmapHeight != _height);
         super.setSize(this.image.bitmapWidth,this.image.bitmapHeight);
         if(param1)
         {
            dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function get toolTip() : String
      {
         return this._toolTip;
      }
      
      public function set toolTip(param1:String) : void
      {
         if(this._toolTip == param1)
         {
            return;
         }
         this._toolTip = param1;
      }
      
      public function get source() : String
      {
         return this.image.source;
      }
      
      public function set source(param1:String) : void
      {
         this.image.source = param1;
      }
      
      public function get sourceAlt() : String
      {
         return this.image.sourceAlt;
      }
      
      public function set sourceAlt(param1:String) : void
      {
         this.image.sourceAlt = param1;
      }
      
      public function get tooltipEnabled() : Boolean
      {
         return this._tooltipEnabled;
      }
      
      public function set tooltipEnabled(param1:Boolean) : void
      {
         if(param1 == this._tooltipEnabled)
         {
            return;
         }
         this._tooltipEnabled = param1;
         if(param1)
         {
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler,false,0,true);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler,false,0,true);
         }
         else
         {
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         }
      }
      
      public function get horizontalAlign() : String
      {
         return this._horizontalAlign;
      }
      
      public function set horizontalAlign(param1:String) : void
      {
         if(this._horizontalAlign != param1)
         {
            this._horizontalAlign = param1;
            invalidateLayout();
         }
      }
      
      public function get verticalAlign() : String
      {
         return this._verticalAlign;
      }
      
      public function set verticalAlign(param1:String) : void
      {
         if(this._verticalAlign != param1)
         {
            this._verticalAlign = param1;
            invalidateLayout();
         }
      }
      
      public function get verticalCenter() : int
      {
         return this._verticalCenter;
      }
      
      public function set verticalCenter(param1:int) : void
      {
         if(this._verticalCenter != param1)
         {
            this._verticalAlign = AlignType.CENTER;
            this._verticalCenter = param1;
            invalidateLayout();
         }
      }
      
      public function get horizontalCenter() : int
      {
         return this._horizontalCenter;
      }
      
      public function set horizontalCenter(param1:int) : void
      {
         if(this._horizontalCenter != param1)
         {
            this._horizontalAlign = AlignType.CENTER;
            this._horizontalCenter = param1;
            invalidateLayout();
         }
      }
      
      public function get paddingLeft() : int
      {
         return this._paddingLeft;
      }
      
      public function set paddingLeft(param1:int) : void
      {
         if(this._paddingLeft != param1)
         {
            this._paddingLeft = param1;
            invalidateLayout();
         }
      }
      
      public function get paddingRight() : int
      {
         return this._paddingLeft;
      }
      
      public function set paddingRight(param1:int) : void
      {
         if(this._paddingRight != param1)
         {
            this._paddingRight = param1;
            invalidateLayout();
         }
      }
      
      public function get paddingTop() : int
      {
         return this._paddingTop;
      }
      
      public function set paddingTop(param1:int) : void
      {
         if(this._paddingTop != param1)
         {
            this._paddingTop = param1;
            invalidateLayout();
         }
      }
      
      public function get paddingBottom() : int
      {
         return this._paddingBottom;
      }
      
      public function set paddingBottom(param1:int) : void
      {
         if(this._paddingBottom != param1)
         {
            this._paddingBottom = param1;
            invalidateLayout();
         }
      }
      
      public function get adjustSize() : Boolean
      {
         return this._adjustSize;
      }
      
      public function set adjustSize(param1:Boolean) : void
      {
         if(this._adjustSize != param1)
         {
            this._adjustSize = param1;
            if(param1)
            {
               this.adjustSizeToImage(true);
            }
         }
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(this._toolTip)
         {
            App.toolTipMgr.showComplex(this._toolTip);
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         if(this._toolTip)
         {
            App.toolTipMgr.hide();
         }
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         invalidateLayout();
         if(this._adjustSize)
         {
            this.adjustSizeToImage(false);
         }
         dispatchEvent(param1);
      }
   }
}
