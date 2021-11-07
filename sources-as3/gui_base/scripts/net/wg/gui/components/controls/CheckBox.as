package net.wg.gui.components.controls
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.constants.ToolTipShowType;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.ITextContainer;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.CheckBox;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ResizeEvent;
   
   public class CheckBox extends scaleform.clik.controls.CheckBox implements ISoundable, ITextContainer
   {
      
      private static const VISIBILITY_INV:String = "visibilityInv";
      
      private static const TEXT_FORMAT_INV:String = "textFormatInv";
      
      private static const INVALIDATION_MULTILINE:String = "invalidationMultiline";
      
      private static const INVALIDATION_WORD_WRAP:String = "invalidationWordWrap";
      
      private static const INVALIDATION_TEXT_FIELD_SIZE:String = "invalidationTextFieldSize";
      
      private static const INVALIDATION_LABEL_VISIBILITY:String = "invalidationLabelVisibility";
      
      private static const INFO_INV:String = "infoInv";
      
      private static const HIT_MARGIN_WIDTH:Number = 4;
      
      private static const HIT_MARGIN_HEIGHT:Number = 4;
      
      private static const INV_MOUSE_ENABLED:String = "invMouseEnabled";
      
      private static const EMPTY_STR:String = "";
      
      private static const LINKAGE_INFO_ICON_UI:String = "InfoIconUI";
      
      private static const TEXT_ALIGN_EXCEPTION:String = "setter CheckBox::textAlign";
      
      private static const HEIGHT_PADDING:int = 5;
       
      
      [Inspectable(type="String")]
      public var soundId:String = "";
      
      public var hit:Sprite = null;
      
      public var tooltipType:ToolTipShowType;
      
      private var _textColor:Number = 9868935;
      
      private var _disabledTextAlpha:Number = 0.5;
      
      private var _soundType:String = "checkBox";
      
      private var _textFont:String = "$TextFont";
      
      private var _textSize:Number = 12;
      
      private var _textLineSpacing:Number = 0.0;
      
      private var _dynamicFrameUpdating:Boolean = false;
      
      private var _multiline:Boolean = false;
      
      private var _wordWrap:Boolean = false;
      
      private var _tooltip:String = "";
      
      private var _infoIcoType:String = "";
      
      private var _hitHeight:int;
      
      private var _hitWidth:int;
      
      private var _infoIco:InfoIcon = null;
      
      private var _showLabel:Boolean = true;
      
      public function CheckBox()
      {
         this.tooltipType = ToolTipShowType.COMPLEX;
         super();
      }
      
      override protected function onBeforeDispose() : void
      {
         this.hit = null;
         this.tooltipType = null;
         if(App.soundMgr)
         {
            App.soundMgr.removeSoundHdlrs(this);
         }
         if(this._infoIco)
         {
            this.removeInfoIco();
         }
         if(constraints != null)
         {
            constraints.removeEventListener(ResizeEvent.RESIZE,this.onConstraintsResizeHandler);
         }
         super.onBeforeDispose();
      }
      
      override protected function updateText() : void
      {
         if(_label != null && textField != null && this._showLabel)
         {
            textField.htmlText = _label;
            invalidate(INVALIDATION_TEXT_FIELD_SIZE);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         buttonMode = enabled;
         mouseEnabled = true;
         hitArea = this.hit;
         if(this.hit)
         {
            this._hitHeight = this.hit.height;
            this._hitWidth = this.hit.width;
         }
         if(App.soundMgr != null)
         {
            App.soundMgr.addSoundsHdlrs(this);
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:TextFormat = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.repositionInfoIcon();
         }
         if(isInvalid(INV_MOUSE_ENABLED))
         {
            mouseEnabled = true;
         }
         if(isInvalid(TEXT_FORMAT_INV))
         {
            if(textField)
            {
               textField.textColor = this._textColor;
               _loc1_ = new TextFormat();
               _loc1_.font = this._textFont;
               _loc1_.size = this._textSize;
               _loc1_.leading = this._textLineSpacing;
               textField.setTextFormat(_loc1_);
               textField.alpha = !!enabled ? Number(1) : Number(this._disabledTextAlpha);
               invalidate(INVALIDATION_TEXT_FIELD_SIZE);
            }
         }
         if(isInvalid(INFO_INV))
         {
            if(this._infoIcoType != EMPTY_STR && this._tooltip != EMPTY_STR)
            {
               if(!this._infoIco)
               {
                  this.createInfoIco();
                  isInvalid(VISIBILITY_INV);
               }
               this._infoIco.tooltipType = this.tooltipType;
               this._infoIco.tooltip = this._tooltip;
               this._infoIco.icoType = this._infoIcoType;
               this.repositionInfoIcon();
            }
            else
            {
               this.removeInfoIco();
            }
         }
         if(isInvalid(VISIBILITY_INV) && this._infoIco)
         {
            this._infoIco.visible = this.visible;
         }
         if(textField != null)
         {
            if(isInvalid(INVALIDATION_LABEL_VISIBILITY) || isInvalid(InvalidationType.STATE))
            {
               if(textField.visible != this._showLabel)
               {
                  textField.visible = this._showLabel;
                  if(this._showLabel)
                  {
                     this.updateText();
                  }
                  else
                  {
                     this.resetText();
                  }
               }
            }
            if(isInvalid(INVALIDATION_MULTILINE))
            {
               textField.multiline = this._multiline;
               invalidate(INVALIDATION_TEXT_FIELD_SIZE);
            }
            if(isInvalid(INVALIDATION_WORD_WRAP))
            {
               textField.wordWrap = this._wordWrap;
               invalidate(INVALIDATION_TEXT_FIELD_SIZE);
            }
            if(isInvalid(INVALIDATION_TEXT_FIELD_SIZE))
            {
               this.updateTextFieldSize();
               this.repositionInfoIcon();
            }
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         invalidate(VISIBILITY_INV);
      }
      
      override protected function updateAfterStateChange() : void
      {
         super.updateAfterStateChange();
         invalidate(TEXT_FORMAT_INV,INVALIDATION_MULTILINE,INVALIDATION_WORD_WRAP);
      }
      
      override protected function preInitialize() : void
      {
         super.preInitialize();
         if(constraints != null)
         {
            constraints.scaleMode = ConstrainMode.REFLOW;
         }
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         return this.enabled;
      }
      
      public function enableDynamicFrameUpdating() : void
      {
         this._dynamicFrameUpdating = true;
      }
      
      public final function getSoundId() : String
      {
         return this.soundId;
      }
      
      public final function getSoundType() : String
      {
         return this.soundType;
      }
      
      public function hideTooltip() : void
      {
         if(App.toolTipMgr)
         {
            App.toolTipMgr.hide();
         }
      }
      
      public function showTooltip() : void
      {
         if(this._tooltip && App.toolTipMgr && !this._infoIco)
         {
            if(this.tooltipType.value == ToolTipShowType.COMPLEX.value)
            {
               App.toolTipMgr.showComplex(this._tooltip);
            }
            else if(this.tooltipType.value == ToolTipShowType.SPECIAL.value)
            {
               App.toolTipMgr.showSpecial(this._tooltip,null);
            }
         }
      }
      
      private function updateTextFieldSize() : void
      {
         textField.height = textField.textHeight + HEIGHT_PADDING;
         if(this.hit)
         {
            if(textField.textWidth > 0)
            {
               this.hit.width = textField.x + textField.textWidth + HIT_MARGIN_WIDTH;
            }
            else
            {
               this.hit.width = this._hitWidth;
            }
            if(textField.textHeight > 0)
            {
               this.hit.height = textField.y + textField.textHeight + HIT_MARGIN_HEIGHT;
            }
            else
            {
               this.hit.height = this._hitHeight;
            }
         }
      }
      
      private function repositionInfoIcon() : void
      {
         if(this._infoIco)
         {
            this._infoIco.x = this.x + textField.x + textField.textWidth + InfoIcon.CHECK_BOX_MARGIN ^ 0;
            this._infoIco.y = this.y + (textField.y + textField.height >> 1);
         }
      }
      
      private function createInfoIco() : void
      {
         if(!owner && parent)
         {
            owner = UIComponent(parent);
            App.utils.asserter.assertNotNull(owner,"owner" + Errors.CANT_NULL);
         }
         this._infoIco = InfoIcon(App.utils.classFactory.getComponent(LINKAGE_INFO_ICON_UI,InfoIcon));
         owner.addChild(this._infoIco);
      }
      
      private function removeInfoIco() : void
      {
         if(this._infoIco)
         {
            this._infoIco.dispose();
            owner.removeChild(this._infoIco);
            this._infoIco = null;
         }
      }
      
      override public function set label(param1:String) : void
      {
         if(!this._dynamicFrameUpdating || param1.length > 0)
         {
            super.label = param1;
         }
      }
      
      override public function set data(param1:Object) : void
      {
         if(!this._dynamicFrameUpdating || param1.length > 0)
         {
            super.data = param1;
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         if(!param1 && _focusIndicator)
         {
            _focusIndicator.visible = false;
         }
         buttonMode = enabled;
         mouseEnabled = false;
         invalidate(INV_MOUSE_ENABLED);
      }
      
      public function get textAlign() : String
      {
         return textField.getTextFormat().align;
      }
      
      public function set textAlign(param1:String) : void
      {
         throw new AbstractException(TEXT_ALIGN_EXCEPTION + Errors.ABSTRACT_INVOKE);
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
         invalidate(TEXT_FORMAT_INV);
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
         invalidate(TEXT_FORMAT_INV);
      }
      
      [Inspectable(defaultValue="#969687",name="textColor",type="Color")]
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
         invalidate(TEXT_FORMAT_INV);
      }
      
      [Inspectable(defaultValue="0.5",name="disabledTextAlpha",type="Number")]
      public function get disabledTextAlpha() : Number
      {
         return this._disabledTextAlpha;
      }
      
      public function set disabledTextAlpha(param1:Number) : void
      {
         if(this._disabledTextAlpha == param1)
         {
            return;
         }
         this._disabledTextAlpha = param1;
         invalidate(TEXT_FORMAT_INV);
      }
      
      [Inspectable(defaultValue="checkBox",type="String")]
      public function get soundType() : String
      {
         return this._soundType;
      }
      
      public function set soundType(param1:String) : void
      {
         if(param1 && param1 != this._soundType)
         {
            this._soundType = param1;
         }
      }
      
      public function get infoIcoType() : String
      {
         return this._infoIcoType;
      }
      
      [Inspectable(defaultValue="",type="String")]
      public function set infoIcoType(param1:String) : void
      {
         if(param1 == this._infoIcoType)
         {
            return;
         }
         this._infoIcoType = param1;
         invalidate(INFO_INV);
      }
      
      public function get toolTip() : String
      {
         return this._tooltip;
      }
      
      [Inspectable(defaultValue="",type="String")]
      public function set toolTip(param1:String) : void
      {
         if(param1 != this._tooltip)
         {
            this._tooltip = param1;
            invalidate(INFO_INV);
         }
      }
      
      public function get multiline() : Boolean
      {
         return this._multiline;
      }
      
      public function set multiline(param1:Boolean) : void
      {
         if(this._multiline == param1)
         {
            return;
         }
         this._multiline = param1;
         invalidate(INVALIDATION_MULTILINE);
         if(constraints != null)
         {
            constraints.addEventListener(ResizeEvent.RESIZE,this.onConstraintsResizeHandler);
         }
      }
      
      public function get wordWrap() : Boolean
      {
         return this._wordWrap;
      }
      
      public function set wordWrap(param1:Boolean) : void
      {
         if(this._wordWrap == param1)
         {
            return;
         }
         this._wordWrap = param1;
         invalidate(INVALIDATION_WORD_WRAP);
      }
      
      public function get textLineSpacing() : Number
      {
         return this._textLineSpacing;
      }
      
      public function set textLineSpacing(param1:Number) : void
      {
         if(this._textLineSpacing == param1)
         {
            return;
         }
         this._textLineSpacing = param1;
         invalidate(TEXT_FORMAT_INV);
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         this.showTooltip();
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         this.hideTooltip();
      }
      
      override protected function handleMousePress(param1:MouseEvent) : void
      {
         super.handleMousePress(param1);
         this.hideTooltip();
      }
      
      private function onConstraintsResizeHandler(param1:ResizeEvent) : void
      {
         invalidate(INVALIDATION_TEXT_FIELD_SIZE);
      }
      
      public function set showLabel(param1:Boolean) : void
      {
         if(this._showLabel == param1)
         {
            return;
         }
         this._showLabel = param1;
         invalidate(INVALIDATION_LABEL_VISIBILITY);
      }
      
      public function get showLabel() : Boolean
      {
         return this._showLabel;
      }
      
      private function resetText() : void
      {
         if(textField && textField.text && textField.text.length > 0)
         {
            textField.text = EMPTY_STR;
            invalidate(INVALIDATION_TEXT_FIELD_SIZE);
         }
      }
   }
}
