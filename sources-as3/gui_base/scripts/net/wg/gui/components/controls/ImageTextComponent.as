package net.wg.gui.components.controls
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.data.constants.AlignType;
   import net.wg.data.constants.IconTextPosition;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class ImageTextComponent extends UIComponentEx
   {
      
      private static const TEXT_STYLE_INVALID:String = "textStyleInvalid";
       
      
      public var textField:TextField;
      
      public var icon:ImageComponent;
      
      protected var _horizontalAlign:String = "left";
      
      protected var _verticalAlign:String = "top";
      
      protected var _paddingTop:int = 0;
      
      protected var _paddingBottom:int = 0;
      
      protected var _paddingLeft:int = 0;
      
      protected var _paddingRight:int = 0;
      
      protected var _horizontalCenter:int = 0;
      
      protected var _verticalCenter:int = 0;
      
      private var _text:String = null;
      
      private var _htmlText:String = null;
      
      private var _textFormat:TextFormat = null;
      
      private var _textAlign:String = "left";
      
      private var _textAutoSize:String = "left";
      
      private var _textFont:String = "$TextFont";
      
      private var _textSize:int = 12;
      
      private var _textColor:uint = 0;
      
      private var _styleSheet:StyleSheet = null;
      
      private var _antiAliasing:String = "advanced";
      
      private var _enabledTooltip:Boolean = true;
      
      private var _toolTip:String = "";
      
      private var _gap:int = 0;
      
      private var _iconPosition:String = "left";
      
      private var _updateTextFieldSize:Boolean = true;
      
      private var _textWidth:int = 0;
      
      private var _textHeight:int = 0;
      
      private var _iconOffsetX:int = 0;
      
      private var _iconOffsetY:int = 0;
      
      public function ImageTextComponent()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.icon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
         this._textWidth = this.textField.width;
         this._textHeight = this.textField.height;
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.icon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.icon.dispose();
         this.icon = null;
         this.textField = null;
         this._text = null;
         this._htmlText = null;
         this._textFormat = null;
         this._styleSheet = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._textFormat = this.textField.getTextFormat();
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = isInvalid(InvalidationType.DATA);
         var _loc2_:Boolean = isInvalid(InvalidationType.SIZE);
         var _loc3_:Boolean = isInvalid(TEXT_STYLE_INVALID);
         var _loc4_:Boolean = isInvalid(InvalidationType.LAYOUT);
         if(_loc3_)
         {
            if(!this._htmlText)
            {
               this._textFormat.color = this._textColor;
               this._textFormat.size = this._textSize;
               this._textFormat.font = this._textFont;
               this._textFormat.align = this._textAlign;
               this.textField.antiAliasType = this._antiAliasing;
            }
            else
            {
               _loc3_ = false;
            }
         }
         if(_loc1_)
         {
            if(this._htmlText)
            {
               this.textField.htmlText = this._htmlText;
            }
            else
            {
               this.textField.styleSheet = this._styleSheet;
               this.textField.text = this._text;
               _loc3_ = this._styleSheet == null;
            }
            _loc4_ = _loc4_ || (this._updateTextFieldSize || this._textWidth == 0 || this._textHeight == 0);
         }
         if(_loc3_)
         {
            this.textField.setTextFormat(this._textFormat);
         }
         if(_loc2_ || _loc4_)
         {
            this.updateLayout();
         }
         super.draw();
      }
      
      protected function updateLayout() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this._updateTextFieldSize)
         {
            App.utils.commons.updateTextFieldSize(this.textField);
         }
         else
         {
            this.textField.width = this._textWidth;
            this.textField.height = this._textHeight;
         }
         if(this._horizontalAlign == AlignType.LEFT)
         {
            this.icon.x = this.textField.x = this._paddingLeft;
            if(this._iconPosition == IconTextPosition.LEFT)
            {
               this.textField.x += this.icon.width + this._gap;
            }
            else if(this._iconPosition == IconTextPosition.RIGHT)
            {
               this.icon.x += this.textField.width + this._gap;
            }
         }
         else if(this._horizontalAlign == AlignType.CENTER)
         {
            _loc1_ = 0;
            if(this._iconPosition == IconTextPosition.LEFT)
            {
               _loc1_ = this.textField.width + this.icon.width + this._gap;
               this.icon.x = (_width - _loc1_ >> 1) + this._horizontalCenter + this._iconOffsetX;
               this.textField.x = this.icon.x + this.icon.width + this._gap;
            }
            else if(this._iconPosition == IconTextPosition.RIGHT)
            {
               _loc1_ = this.textField.width + this.icon.width + this._gap;
               this.textField.x = (_width - _loc1_ >> 1) + this._horizontalCenter;
               this.icon.x = this.textField.x + this.textField.width + this._gap + this._iconOffsetX;
            }
            else
            {
               _loc1_ = Math.max(this.icon.width,this.textField.width);
               _loc2_ = (_width - _loc1_ >> 1) + this._horizontalCenter;
               this.icon.x = _loc2_ + (_loc1_ - this.icon.width >> 1) + this._iconOffsetX;
               this.textField.x = _loc2_ + (_loc1_ - this.textField.width >> 1);
            }
         }
         else if(this._horizontalAlign == AlignType.RIGHT)
         {
            this.icon.x = _width - this.icon.width - this._paddingRight + this._iconOffsetX;
            this.textField.x = _width - this.textField.width - this._paddingRight;
            if(this._iconPosition == IconTextPosition.LEFT)
            {
               this.icon.x -= this.textField.width - this._gap + this._iconOffsetX;
            }
            else if(this._iconPosition == IconTextPosition.RIGHT)
            {
               this.textField.x -= this.icon.width - this._gap;
            }
         }
         else if(this._horizontalAlign == AlignType.FIT_TO_SIZE)
         {
            this.icon.x = this.textField.x = this._paddingLeft + this._iconOffsetX;
            if(this._iconPosition == IconTextPosition.LEFT)
            {
               this.textField.width = _width - this._paddingLeft - this._paddingRight - this.icon.width - this._gap;
               this.textField.x += this.icon.width + this._gap;
            }
            else if(this._iconPosition == IconTextPosition.RIGHT)
            {
               this.textField.width = _width - this._paddingLeft - this._paddingRight - this.icon.width - this._gap;
               this.icon.x += this.textField.width + this._gap + this._iconOffsetX;
            }
            else
            {
               this.icon.width = this.textField.width = _width;
            }
         }
         else
         {
            App.utils.asserter.assert(false,"invalid horizontalAlign:" + this._horizontalAlign);
         }
         if(this._verticalAlign == AlignType.TOP)
         {
            this.icon.y = this.textField.y = this._paddingTop + this._iconOffsetY;
            if(this._iconPosition == IconTextPosition.TOP)
            {
               this.textField.y += this.icon.height + this._gap;
            }
            else if(this._iconPosition == IconTextPosition.BOTTOM)
            {
               this.icon.y += this.textField.height + this._gap + this._iconOffsetY;
            }
         }
         else if(this._verticalAlign == AlignType.CENTER)
         {
            _loc3_ = 0;
            if(this._iconPosition == IconTextPosition.TOP)
            {
               _loc3_ = this.textField.height + this.icon.height + this._gap;
               this.icon.y = (_height - _loc3_ >> 1) + this._verticalCenter + this._iconOffsetY;
               this.textField.y = this.icon.y + this.icon.height + this._gap;
            }
            else if(this._iconPosition == IconTextPosition.BOTTOM)
            {
               _loc3_ = this.textField.height + this.icon.height + this._gap;
               this.textField.y = (_height - _loc3_ >> 1) + this._verticalCenter;
               this.icon.y = this.textField.y + this.textField.height + this._gap + this._iconOffsetY;
            }
            else
            {
               _loc3_ = Math.max(this.icon.height,this.textField.height);
               _loc4_ = (_height - _loc3_ >> 1) + this._verticalCenter;
               this.icon.y = _loc4_ + (_loc3_ - this.icon.height >> 1) + this._iconOffsetY;
               this.textField.y = _loc4_ + (_loc3_ - this.textField.height >> 1);
            }
         }
         else if(this._verticalAlign == AlignType.BOTTOM)
         {
            this.icon.y = _height - this.icon.height - this._paddingBottom + this._iconOffsetY;
            this.textField.y = _height - this.textField.height - this._paddingBottom;
            if(this._iconPosition == IconTextPosition.TOP)
            {
               this.icon.y -= this.textField.height - this._gap + this._iconOffsetY;
            }
            else if(this._iconPosition == IconTextPosition.BOTTOM)
            {
               this.textField.y -= this.icon.height - this._gap;
            }
         }
         else if(this._verticalAlign == AlignType.FIT_TO_SIZE)
         {
            this.icon.y = this.textField.y = this._paddingTop + this._iconOffsetY;
            if(this._iconPosition == IconTextPosition.TOP)
            {
               this.textField.height = _height - this._paddingTop - this._paddingBottom - this.icon.height - this._gap;
               this.textField.y += this.icon.height + this._gap;
            }
            else if(this._iconPosition == IconTextPosition.BOTTOM)
            {
               this.textField.height = _height - this._paddingTop - this._paddingBottom - this.icon.height - this._gap;
               this.icon.y += this.textField.height + this._gap + this._iconOffsetY;
            }
            else
            {
               this.icon.height = this.textField.height = _height;
            }
         }
         else
         {
            App.utils.asserter.assert(false,"invalid horizontalAlign:" + this._horizontalAlign);
         }
         this._textWidth = this.textField.width;
         this._textHeight = this.textField.height;
      }
      
      private function invalidateStyle() : void
      {
         invalidate(TEXT_STYLE_INVALID);
      }
      
      public function get multiline() : Boolean
      {
         return this.textField.multiline;
      }
      
      public function set multiline(param1:Boolean) : void
      {
         this.textField.multiline = param1;
      }
      
      public function get wordWrap() : Boolean
      {
         return this.textField.wordWrap;
      }
      
      public function set wordWrap(param1:Boolean) : void
      {
         this.textField.wordWrap = param1;
      }
      
      public function get updateTextFieldSize() : Boolean
      {
         return this._updateTextFieldSize;
      }
      
      public function set updateTextFieldSize(param1:Boolean) : void
      {
         if(this._updateTextFieldSize != param1)
         {
            this._updateTextFieldSize = param1;
            invalidateLayout();
         }
      }
      
      public function get textWidth() : int
      {
         return this._textWidth;
      }
      
      public function set textWidth(param1:int) : void
      {
         if(this.textField.width != param1)
         {
            this._textWidth = param1;
            invalidateLayout();
         }
      }
      
      public function get textHeight() : int
      {
         return this._textHeight;
      }
      
      public function set textHeight(param1:int) : void
      {
         if(this.textField.height != param1)
         {
            this._textHeight = param1;
            invalidateLayout();
         }
      }
      
      public function set iconWidth(param1:int) : void
      {
         if(this.icon.width != param1)
         {
            this.icon.width = param1;
            invalidateLayout();
         }
      }
      
      public function set iconHeight(param1:int) : void
      {
         if(this.icon.height != param1)
         {
            this.icon.height = param1;
            invalidateLayout();
         }
      }
      
      public function get iconSource() : String
      {
         return this.icon.source;
      }
      
      public function set iconSource(param1:String) : void
      {
         this.icon.source = param1;
      }
      
      public function get iconPosition() : String
      {
         return this._iconPosition;
      }
      
      public function set iconPosition(param1:String) : void
      {
         if(this._iconPosition != param1)
         {
            this._iconPosition = param1;
            invalidateLayout();
         }
      }
      
      public function get antiAliasing() : String
      {
         return this._antiAliasing;
      }
      
      public function set antiAliasing(param1:String) : void
      {
         if(this._antiAliasing != param1)
         {
            this._antiAliasing = param1;
            this.invalidateStyle();
         }
      }
      
      public function get textAlign() : String
      {
         return this._textAlign;
      }
      
      public function set textAlign(param1:String) : void
      {
         if(this._textAlign != param1)
         {
            this._textAlign = param1;
            this.invalidateStyle();
         }
      }
      
      public function get textAutoSize() : String
      {
         return this._textAutoSize;
      }
      
      public function set textAutoSize(param1:String) : void
      {
         if(this._textAutoSize != param1)
         {
            this._textAutoSize = param1;
            this.updateTextFieldSize = param1 != TextFieldAutoSize.NONE;
            switch(param1)
            {
               case TextFieldAutoSize.LEFT:
                  this.horizontalAlign = AlignType.LEFT;
                  break;
               case TextFieldAutoSize.RIGHT:
                  this.horizontalAlign = AlignType.RIGHT;
                  break;
               case TextFieldAutoSize.CENTER:
                  this.horizontalAlign = AlignType.CENTER;
            }
         }
      }
      
      public function get textFont() : String
      {
         return this._textFont;
      }
      
      public function set textFont(param1:String) : void
      {
         if(this._textFont != param1)
         {
            this._textFont = param1;
            this.invalidateStyle();
         }
      }
      
      public function get textSize() : int
      {
         return this._textSize;
      }
      
      public function set textSize(param1:int) : void
      {
         if(this._textSize != param1)
         {
            this._textSize = param1;
            this.invalidateStyle();
         }
      }
      
      public function get textColor() : uint
      {
         return this._textColor;
      }
      
      public function set textColor(param1:uint) : void
      {
         if(this._textColor != param1)
         {
            this._textColor = param1;
            this.invalidateStyle();
         }
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(param1:String) : void
      {
         if(this._text != param1)
         {
            this._text = param1;
            this._htmlText = null;
            invalidateData();
         }
      }
      
      public function get htmlText() : String
      {
         return this._htmlText;
      }
      
      public function set htmlText(param1:String) : void
      {
         if(this._htmlText != param1)
         {
            this._htmlText = param1;
            this._text = null;
            invalidateData();
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
      
      public function get enabledTooltip() : Boolean
      {
         return this._enabledTooltip;
      }
      
      public function set enabledTooltip(param1:Boolean) : void
      {
         this._enabledTooltip = param1;
      }
      
      public function get css() : StyleSheet
      {
         return this._styleSheet;
      }
      
      public function set css(param1:StyleSheet) : void
      {
         this._styleSheet = param1;
         this.invalidateStyle();
      }
      
      public function get gap() : int
      {
         return this._gap;
      }
      
      public function set gap(param1:int) : void
      {
         if(this._gap != param1)
         {
            this._gap = param1;
            invalidateLayout();
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
         if(this._verticalCenter != param1 || this._verticalAlign != AlignType.CENTER)
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
         if(this._horizontalCenter != param1 || this._horizontalAlign != AlignType.CENTER)
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
      
      public function get iconOffsetX() : int
      {
         return this._iconOffsetX;
      }
      
      public function set iconOffsetX(param1:int) : void
      {
         this._iconOffsetX = param1;
      }
      
      public function get iconOffsetY() : int
      {
         return this._iconOffsetY;
      }
      
      public function set iconOffsetY(param1:int) : void
      {
         this._iconOffsetY = param1;
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(this._toolTip && this._enabledTooltip)
         {
            App.toolTipMgr.showComplex(this._toolTip);
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         if(this._enabledTooltip)
         {
            App.toolTipMgr.hide();
         }
      }
      
      private function onIconChangeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
   }
}
