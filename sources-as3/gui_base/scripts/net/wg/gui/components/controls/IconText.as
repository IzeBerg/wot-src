package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import net.wg.data.Colors;
   import net.wg.data.constants.IconTextPosition;
   import net.wg.data.constants.IconsTypes;
   import net.wg.gui.components.controls.helpers.IconTextHelper;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.ITextContainer;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.utils.Constraints;
   
   public class IconText extends UIComponentEx implements ITextContainer
   {
      
      protected static const INV_TEXT:String = "InvText";
      
      protected static const INV_ANTIALIAS:String = "InvAntialias";
      
      protected static const INV_TEXT_SIZE:String = "InvTextSize";
      
      protected static const INV_TEXT_FONT:String = "InvTextFont";
      
      protected static const INV_TEXT_ALIGN:String = "InvTextAlign";
      
      protected static const INV_TEXT_COLOR:String = "InvTextColor";
      
      protected static const INV_POSITION:String = "InvPosition";
      
      protected static const INV_ICON:String = "InvIcon";
      
      private static const ALPHA_ENABLED:Number = 1;
      
      private static const ALPHA_DISABLED:Number = 0.3;
      
      public static const BASE_COLOR:Number = 0;
       
      
      public var textField:TextField;
      
      public var iconClip:MovieClip;
      
      private var _iconWidth:Number = 0;
      
      private var _iconPosition:String = "left";
      
      private var _fitIconPosition:Boolean = false;
      
      private var _textFormat:TextFormat;
      
      private var _textAlign:String = "left";
      
      private var _textFont:String = "$TextFont";
      
      private var _textSize:Number = 12;
      
      private var _textColor:Number = 0;
      
      private var _toolTip:String = "";
      
      private var _text:String = "";
      
      private var _useHtmlText:Boolean = false;
      
      private var _icon:String = "";
      
      private var _antiAliasing:String = "advanced";
      
      private var _styleSheet:StyleSheet = null;
      
      private var _xCorrect:Number = 0;
      
      private var _enabledTooltip:Boolean = true;
      
      private var _textFieldYOffset:Number = 0;
      
      private var _iconYOffset:int = 0;
      
      private var _useFixedIconWidth:Boolean = false;
      
      public function IconText()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.textField = null;
         this.iconClip = null;
         this._textFormat = null;
         this._styleSheet = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._textFormat = this.textField.getTextFormat();
         if(this._iconWidth == 0)
         {
            this._iconWidth = this.iconClip.width;
         }
         this.iconClip.visible = false;
         useHandCursor = false;
         constraints = new Constraints(this,ConstrainMode.COUNTER_SCALE);
         constraints.addElement(this.iconClip.name,this.iconClip,Constraints.LEFT);
         constraints.addElement(this.textField.name,this.textField,Constraints.ALL);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler,false,0,true);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         super.draw();
         if(this.textField)
         {
            _loc1_ = isInvalid(InvalidationType.SIZE);
            _loc2_ = isInvalid(INV_ICON);
            _loc3_ = isInvalid(INV_TEXT);
            _loc4_ = isInvalid(INV_TEXT_SIZE);
            _loc5_ = isInvalid(INV_TEXT_COLOR);
            _loc6_ = isInvalid(INV_TEXT_FONT);
            if(_loc1_)
            {
               constraints.update(_width,_height);
               this.textField.scaleX = 1 / scaleX;
               this.textField.height = _height;
            }
            if(!this._useHtmlText)
            {
               if(_loc5_ || _loc2_)
               {
                  _loc7_ = IconsTypes.getTextColor(this._icon);
                  this._textFormat.color = _loc7_ > -1 && this._textColor != Colors.ERROR_COLOR ? _loc7_ : this._textColor;
               }
               if(_loc4_)
               {
                  this._textFormat.size = this._textSize;
               }
               if(_loc6_)
               {
                  this._textFormat.font = this._textFont;
               }
            }
            if(isInvalid(INV_TEXT_ALIGN))
            {
               this._textFormat.align = this._textAlign;
               this.textField.autoSize = this._textAlign;
            }
            if(isInvalid(INV_ANTIALIAS))
            {
               this.textField.antiAliasType = this._antiAliasing;
            }
            if(_loc3_)
            {
               if(this._useHtmlText)
               {
                  this.textField.htmlText = this._text;
               }
               else
               {
                  if(this._styleSheet)
                  {
                     this.textField.styleSheet = this._styleSheet;
                  }
                  this.textField.text = this._text;
               }
            }
            if(!this._styleSheet && !this._useHtmlText && (_loc5_ || _loc2_ || _loc3_ || _loc6_))
            {
               this.textField.setTextFormat(this._textFormat);
            }
            if(isInvalid(INV_POSITION))
            {
               this.textField.y = this._textFieldYOffset;
               if(this.iconClip)
               {
                  _loc8_ = Math.round(this.textField.width * scaleX);
                  if(this._fitIconPosition)
                  {
                     _loc8_ = Math.min(this.textField.textWidth,_loc8_);
                  }
                  _loc9_ = 0;
                  if(this._iconPosition == IconTextPosition.LEFT)
                  {
                     if(this._textAlign == TextFormatAlign.LEFT)
                     {
                        _loc9_ = 0;
                     }
                     else if(this._textAlign == TextFormatAlign.RIGHT)
                     {
                        _loc9_ = _width - _loc8_ - this._iconWidth;
                     }
                     else
                     {
                        _loc9_ = _width - _loc8_ - this._iconWidth >> 1;
                     }
                  }
                  else if(this._textAlign == TextFormatAlign.RIGHT)
                  {
                     _loc9_ = _width - this._iconWidth;
                  }
                  else if(this._textAlign == TextFormatAlign.LEFT)
                  {
                     _loc9_ = _loc8_;
                  }
                  else
                  {
                     _loc9_ = _width + _loc8_ - this._iconWidth >> 1;
                  }
                  this.iconClip.x = _loc9_ * this.iconClip.scaleX ^ 0;
                  this.iconClip.y = this._iconYOffset;
                  if(_loc2_)
                  {
                     this.iconClip.gotoAndStop(this._icon);
                     if(_baseDisposed)
                     {
                        return;
                     }
                     this.iconClip.visible = IconTextHelper.getInstance().isIconClipVisible(this._icon);
                  }
                  if(this._iconPosition == IconTextPosition.LEFT)
                  {
                     this.textField.x = this.iconClip.x + (!!this._useFixedIconWidth ? this._iconWidth : this.iconClip.width) + this._xCorrect;
                  }
                  else
                  {
                     this.textField.x = this.iconClip.x - this._xCorrect - this.textField.width;
                  }
               }
               else
               {
                  this.textField.x = 0;
                  this.textField.width = _width;
               }
            }
         }
      }
      
      public function invalidatePosition() : void
      {
         invalidate(INV_POSITION);
      }
      
      public function getVisibleWidth() : Number
      {
         return this.iconClip.width + this.textField.textWidth | 0;
      }
      
      public function setFixedIconWidth(param1:Boolean, param2:int = 0) : void
      {
         this._useFixedIconWidth = param1;
         this._iconWidth = param2;
         invalidate(INV_POSITION);
      }
      
      public function setTextMultiline(param1:Boolean, param2:Boolean) : void
      {
         this.textField.multiline = param1;
         this.textField.wordWrap = param2;
      }
      
      public function setTextWidth(param1:Number) : void
      {
         this.textField.width = param1;
         invalidate(INV_POSITION);
      }
      
      private function isUpdateIconPosition() : Boolean
      {
         return this._textAlign == TextFormatAlign.RIGHT && this._iconPosition == IconTextPosition.LEFT || this._textAlign == TextFormatAlign.LEFT && this._iconPosition == IconTextPosition.RIGHT;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 == super.enabled)
         {
            return;
         }
         super.enabled = param1;
         alpha = !!enabled ? Number(ALPHA_ENABLED) : Number(ALPHA_DISABLED);
      }
      
      [Inspectable(defaultValue="left",name="iconPosition",type="list",enumeration="left,right")]
      public function get iconPosition() : String
      {
         return this._iconPosition;
      }
      
      public function set iconPosition(param1:String) : void
      {
         if(this._iconPosition == param1)
         {
            return;
         }
         this._iconPosition = param1;
         invalidate(INV_POSITION);
      }
      
      [Inspectable(defaultValue="advanced",name="Anti-alias",type="list",enumeration="advanced,normal")]
      public function get antiAliasing() : String
      {
         return this._antiAliasing;
      }
      
      public function set antiAliasing(param1:String) : void
      {
         if(this._antiAliasing == param1)
         {
            return;
         }
         this._antiAliasing = param1;
         invalidate(INV_ANTIALIAS);
      }
      
      [Inspectable(defaultValue="false",name="fitIconPosition",type="Boolean")]
      public function get fitIconPosition() : Boolean
      {
         return this._fitIconPosition;
      }
      
      public function set fitIconPosition(param1:Boolean) : void
      {
         if(this._fitIconPosition == param1)
         {
            return;
         }
         this._fitIconPosition = param1;
         invalidate(INV_POSITION);
      }
      
      [Inspectable(defaultValue="left",name="textAlign",type="list",enumeration="left,right,center")]
      public function get textAlign() : String
      {
         return this._textAlign;
      }
      
      public function set textAlign(param1:String) : void
      {
         if(this._textAlign == param1)
         {
            return;
         }
         this._textAlign = param1;
         invalidate(INV_TEXT_ALIGN);
      }
      
      [Inspectable(defaultValue="$TextFont",name="textFont",type="list",enumeration="$TextFont,$FieldFont,$TitleFont")]
      public function get textFont() : String
      {
         return this._textFont;
      }
      
      public function set textFont(param1:String) : void
      {
         if(this._textFont == param1)
         {
            return;
         }
         this._textFont = param1;
         invalidate(INV_TEXT_FONT);
      }
      
      [Inspectable(defaultValue="12",name="textSize",type="Number")]
      public function get textSize() : Number
      {
         return this._textSize;
      }
      
      public function set textSize(param1:Number) : void
      {
         if(this._textSize == param1)
         {
            return;
         }
         this._textSize = param1;
         invalidate(INV_TEXT_SIZE);
      }
      
      [Inspectable(name="textColor",type="Color")]
      public function get textColor() : Number
      {
         return this._textColor;
      }
      
      public function set textColor(param1:Number) : void
      {
         if(this._textColor == param1)
         {
            return;
         }
         this._textColor = param1;
         invalidate(INV_TEXT_COLOR);
      }
      
      [Inspectable(defaultValue="",name="toolTip")]
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
      
      [Inspectable(defaultValue="",name="text")]
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(param1:String) : void
      {
         if(this._text == param1)
         {
            return;
         }
         this._text = param1;
         if(StringUtils.isNotEmpty(this._text))
         {
            this.iconClip.visible = true;
         }
         if(this.isUpdateIconPosition())
         {
            invalidate(INV_TEXT,INV_POSITION);
         }
         else
         {
            invalidate(INV_TEXT);
         }
      }
      
      public function get useHtmlText() : Boolean
      {
         return this._useHtmlText;
      }
      
      public function set useHtmlText(param1:Boolean) : void
      {
         if(this._useHtmlText == param1)
         {
            return;
         }
         this._useHtmlText = param1;
         if(this.isUpdateIconPosition())
         {
            invalidate(INV_TEXT,INV_POSITION);
         }
         else
         {
            invalidate(INV_TEXT);
         }
      }
      
      [Inspectable(defaultValue="credits",name="icon")]
      public function get icon() : String
      {
         return this._icon;
      }
      
      public function set icon(param1:String) : void
      {
         if(this._icon == param1)
         {
            return;
         }
         this._icon = param1;
         invalidate(INV_POSITION,INV_ICON);
      }
      
      [Inspectable(defaultValue="true")]
      public function get enabledTooltip() : Boolean
      {
         return this._enabledTooltip;
      }
      
      public function set enabledTooltip(param1:Boolean) : void
      {
         if(param1 == this._enabledTooltip)
         {
            return;
         }
         this._enabledTooltip = param1;
      }
      
      [Inspectable]
      public function get textFieldYOffset() : Number
      {
         return this._textFieldYOffset;
      }
      
      public function set textFieldYOffset(param1:Number) : void
      {
         if(param1 == this._textFieldYOffset)
         {
            return;
         }
         this._textFieldYOffset = param1;
         invalidate(INV_POSITION);
      }
      
      public function get iconYOffset() : int
      {
         return this._iconYOffset;
      }
      
      public function set iconYOffset(param1:int) : void
      {
         if(param1 != this.iconClip.y)
         {
            this._iconYOffset = param1;
            invalidate(INV_POSITION);
         }
      }
      
      public function get css() : StyleSheet
      {
         return this._styleSheet;
      }
      
      public function set css(param1:StyleSheet) : void
      {
         this._styleSheet = param1;
         invalidate(INV_TEXT);
      }
      
      public function get xCorrect() : Number
      {
         return this._xCorrect;
      }
      
      public function set xCorrect(param1:Number) : void
      {
         this._xCorrect = param1;
         invalidate(INV_POSITION);
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
   }
}
