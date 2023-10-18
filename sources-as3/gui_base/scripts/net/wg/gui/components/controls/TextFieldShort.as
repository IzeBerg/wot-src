package net.wg.gui.components.controls
{
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.infrastructure.interfaces.ITextContainer;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ListItemRenderer;
   
   [InspectableList("useHtml")]
   public class TextFieldShort extends ListItemRenderer implements ITextContainer
   {
      
      private static const REPLACE_SYMBOLS:String = "...";
       
      
      public var useDropShadow:Boolean = true;
      
      protected var _toolTip:String = "";
      
      private var _textFormat:TextFormat;
      
      private var _textFont:String;
      
      private var _useHtml:Boolean = false;
      
      private var _textSize:Number = 12;
      
      private var _textAlign:String;
      
      private var _textColor:Number = 16777215;
      
      private var _shadowColor:String = "Black";
      
      private var _showToolTip:Boolean = true;
      
      private var _shadowColorList:Object;
      
      private var _altToolTip:String = "";
      
      private var _widthAtStart:Number = 0;
      
      private var _replaceSymbolsLen:Number = 0;
      
      public function TextFieldShort()
      {
         this._shadowColorList = {
            "White":{
               "color":16777215,
               "strange":0.4,
               "quality":3,
               "angle":90
            },
            "Black":{
               "color":0,
               "strange":1,
               "quality":2,
               "angle":270
            }
         };
         super();
         this._textFormat = textField.getTextFormat();
         this._replaceSymbolsLen = REPLACE_SYMBOLS.length;
      }
      
      override public function toString() : String
      {
         return "[WG TextFieldShort " + name + "]";
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._widthAtStart = _width;
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:Number = NaN;
         var _loc12_:DropShadowFilter = null;
         super.draw();
         if(textField && isInvalid(InvalidationType.DATA))
         {
            textField.wordWrap = true;
            textField.selectable = false;
            this.updateConstraints();
            _loc2_ = [];
            _loc3_ = [];
            _loc4_ = 0;
            if(this._useHtml)
            {
               _loc7_ = 0;
               _loc8_ = 0;
               _loc9_ = "";
               _loc10_ = _label;
               while(true)
               {
                  _loc4_ = _loc10_.indexOf("<");
                  if(_loc4_ < 0)
                  {
                     break;
                  }
                  _loc8_ = _loc10_.indexOf(">",_loc4_);
                  _loc9_ = _loc10_.substr(_loc4_,_loc8_ - _loc4_ + 1);
                  _loc2_.push(_loc9_);
                  _loc3_.push(_loc4_);
                  _loc10_ = _loc10_.substr(_loc7_,_loc4_) + _loc10_.substr(_loc8_ + 1,_loc10_.length);
               }
               textField.htmlText = _loc10_;
               _loc1_ = _loc10_;
            }
            else
            {
               textField.text = _label;
               _loc1_ = _label;
            }
            this._textFormat.size = this._textSize;
            this._textFormat.font = this._textFont;
            this._textFormat.align = this._textAlign;
            textField.setTextFormat(this._textFormat);
            _loc5_ = textField.getLineLength(0);
            _loc6_ = _loc1_;
            textField.wordWrap = _loc5_ == 1;
            if(_loc5_ > this._replaceSymbolsLen && _loc5_ < textField.text.length)
            {
               _loc6_ = textField.text.substring(0,_loc5_ - this._replaceSymbolsLen) + REPLACE_SYMBOLS;
            }
            if(this._useHtml)
            {
               _loc11_ = _loc2_.length - 1;
               while(_loc11_ >= 0)
               {
                  _loc4_ = _loc3_[_loc11_];
                  _loc6_ = _loc6_.substr(0,_loc4_) + _loc2_[_loc11_] + _loc6_.substr(_loc4_);
                  _loc11_--;
               }
            }
            this.showText(_loc6_);
            textField.setTextFormat(this._textFormat);
            textField.textColor = this._textColor;
            if(this.useDropShadow)
            {
               _loc12_ = this.getDropShadowFilter(this._shadowColor);
               textField.filters = [_loc12_];
            }
            this._toolTip = _label;
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateConstraints();
         }
      }
      
      override protected function updateText() : void
      {
         this.showText(_label);
      }
      
      override protected function onDispose() : void
      {
         App.utils.data.cleanupDynamicObject(this._shadowColorList);
         this._shadowColorList = null;
         this._textFormat = null;
         super.onDispose();
      }
      
      public function checkHitTestPoint() : void
      {
         var _loc1_:Point = new Point(mouseX,mouseY);
         _loc1_ = this.localToGlobal(_loc1_);
         if(this.hitTestPoint(_loc1_.x,_loc1_.y,true))
         {
            dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
         }
      }
      
      protected function displayToolTip() : void
      {
         if(this._showToolTip)
         {
            if(this._altToolTip)
            {
               App.toolTipMgr.show(this._altToolTip);
            }
            else if(this._toolTip)
            {
               App.toolTipMgr.show(this._toolTip);
            }
         }
      }
      
      private function updateConstraints() : void
      {
         if(autoSize != TextFieldAutoSize.NONE)
         {
            if(!preventAutosizing)
            {
               _width = this._widthAtStart;
               setActualSize(_width,_height);
            }
            if(!constraintsDisabled)
            {
               if(constraints)
               {
                  constraints.update(_width,_height);
               }
            }
         }
      }
      
      private function showText(param1:String) : void
      {
         if(param1 != null && textField != null)
         {
            if(this._useHtml)
            {
               textField.htmlText = param1;
            }
            else
            {
               textField.text = param1;
            }
         }
      }
      
      private function getDropShadowFilter(param1:String) : DropShadowFilter
      {
         var _loc2_:DropShadowFilter = new DropShadowFilter();
         var _loc3_:Object = this._shadowColorList[param1];
         _loc2_.color = _loc3_.color;
         _loc2_.angle = _loc3_.angle;
         _loc2_.alpha = 1;
         _loc2_.blurX = 0;
         _loc2_.blurY = 0;
         _loc2_.distance = 1;
         _loc2_.strength = _loc3_.strange;
         _loc2_.inner = false;
         _loc2_.knockout = false;
         _loc2_.quality = int(_loc3_.quality);
         return _loc2_;
      }
      
      private function tooltipHide() : void
      {
         App.toolTipMgr.hide();
      }
      
      public function get showToolTip() : Boolean
      {
         return this._showToolTip;
      }
      
      public function set showToolTip(param1:Boolean) : void
      {
         this._showToolTip = param1;
      }
      
      [Inspectable(defaultValue="$FieldFont",name="textFont",type="list",enumeration="$TextFont,$FieldFont,$TitleFont")]
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
         invalidateData();
      }
      
      [Inspectable(defaultValue="false",name="useHtml",type="Boolean")]
      public function get useHtml() : Boolean
      {
         return this._useHtml;
      }
      
      public function set useHtml(param1:Boolean) : void
      {
         if(this._useHtml == param1)
         {
            return;
         }
         this._useHtml = param1;
         invalidateData();
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
         invalidateData();
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
         invalidateData();
      }
      
      [Inspectable(defaultValue="#E9E9DA",name="textColor",type="Color")]
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
         invalidateData();
      }
      
      [Inspectable(defaultValue="Black",name="shadowColor",type="list",enumeration="White, Black")]
      public function get shadowColor() : String
      {
         return this._shadowColor;
      }
      
      public function set shadowColor(param1:String) : void
      {
         if(this._shadowColor == param1)
         {
            return;
         }
         this._shadowColor = param1;
         invalidateData();
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
         this._toolTip = App.utils.locale.makeString(param1);
      }
      
      public function get altToolTip() : String
      {
         return this._altToolTip;
      }
      
      public function set altToolTip(param1:String) : void
      {
         if(this._altToolTip == param1)
         {
            return;
         }
         this._altToolTip = App.utils.locale.makeString(param1);
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         this.tooltipHide();
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         this.displayToolTip();
      }
      
      override protected function handleMousePress(param1:MouseEvent) : void
      {
         super.handleMousePress(param1);
         this.tooltipHide();
      }
   }
}
