package net.wg.gui.components.controls
{
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.ITextContainer;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ListItemRenderer;
   
   [InspectableList("useHtml")]
   public class TextFieldShort extends ListItemRenderer implements ITextContainer
   {
      
      protected static const INV_TEXT_SIZE:String = "InvTextSize";
      
      protected static const INV_TEXT_FONT:String = "InvTextFont";
      
      protected static const INV_TEXT_ALIGN:String = "InvTextAlign";
      
      protected static const INV_TEXT_COLOR:String = "InvTextColor";
      
      protected static const INV_TEXT_SHADOW:String = "InvTextShadow";
      
      protected static const TEXT_PADDING:uint = 2;
       
      
      protected var _toolTip:String = "";
      
      private var _useDropShadow:Boolean = true;
      
      private var _textFormat:TextFormat;
      
      private var _textFont:String;
      
      private var _useHtml:Boolean = false;
      
      private var _textSize:int = 12;
      
      private var _textAlign:String;
      
      private var _textColor:uint = 16777215;
      
      private var _shadowColor:String = "Black";
      
      private var _showToolTip:Boolean = true;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _shadowColorList:Object;
      
      private var _altToolTip:String = "";
      
      private var _widthAtStart:Number = 0;
      
      public function TextFieldShort()
      {
         this._tooltipMgr = App.toolTipMgr;
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
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         super.draw();
         if(textField)
         {
            _loc1_ = isInvalid(INV_TEXT_SIZE);
            _loc2_ = isInvalid(INV_TEXT_FONT);
            _loc3_ = isInvalid(INV_TEXT_COLOR);
            _loc4_ = isInvalid(INV_TEXT_FONT);
            _loc5_ = isInvalid(INV_TEXT_SHADOW);
            if(_loc1_)
            {
               this._textFormat.size = this._textSize;
            }
            if(_loc2_)
            {
               this._textFormat.font = this._textFont;
            }
            if(_loc3_)
            {
               this._textFormat.color = this._textColor;
            }
            if(_loc4_)
            {
               this._textFormat.align = this._textAlign;
            }
            if(_loc1_ || _loc2_ || _loc3_ || _loc4_)
            {
               textField.setTextFormat(this._textFormat);
            }
            if(_loc5_)
            {
               textField.filters = !!this._useDropShadow ? [this.getDropShadowFilter(this._shadowColor)] : [];
            }
            if(isInvalid(InvalidationType.DATA))
            {
               this.updateConstraints();
               App.utils.commons.truncateTextFieldText(textField,_label,true,this._useHtml,Values.THREE_DOTS,TEXT_PADDING);
               textField.setTextFormat(this._textFormat);
               this._toolTip = _label;
               invalidateSize();
            }
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
         this._tooltipMgr = null;
         super.onDispose();
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
      
      protected function displayToolTip() : void
      {
         if(this._showToolTip)
         {
            if(this._altToolTip)
            {
               this._tooltipMgr.show(this._altToolTip);
            }
            else if(this._toolTip)
            {
               this._tooltipMgr.show(this._toolTip);
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
            if(!constraintsDisabled && constraints)
            {
               constraints.update(_width,_height);
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
         _loc2_.quality = _loc3_.quality;
         return _loc2_;
      }
      
      private function tooltipHide() : void
      {
         this._tooltipMgr.hide();
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
         invalidate(INV_TEXT_FONT);
      }
      
      public function get useDropShadow() : Boolean
      {
         return this._useDropShadow;
      }
      
      public function set useDropShadow(param1:Boolean) : void
      {
         if(this._useDropShadow == param1)
         {
            return;
         }
         this._useDropShadow = param1;
         invalidate(INV_TEXT_SHADOW);
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
         invalidate(INV_TEXT_SIZE);
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
      
      [Inspectable(defaultValue="#E9E9DA",name="textColor",type="Color")]
      public function get textColor() : uint
      {
         return this._textColor;
      }
      
      public function set textColor(param1:uint) : void
      {
         if(this._textColor == param1)
         {
            return;
         }
         this._textColor = param1;
         invalidate(INV_TEXT_COLOR);
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
         invalidate(INV_TEXT_SHADOW);
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
   }
}
