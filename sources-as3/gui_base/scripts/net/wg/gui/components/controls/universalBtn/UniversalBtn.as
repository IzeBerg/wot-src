package net.wg.gui.components.controls.universalBtn
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.BitmapFill;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.infrastructure.events.UniversalBtnEvent;
   import net.wg.infrastructure.interfaces.IUniversalBtn;
   import net.wg.infrastructure.interfaces.IUniversalBtnToggleIndicator;
   import net.wg.utils.IUniversalBtnStyledDisplayObjects;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   public class UniversalBtn extends SoundButtonEx implements IUniversalBtn, ISoundButtonEx
   {
      
      private static const IMAGE_SOURCE_INVALID:String = "imageSrcInv";
      
      private static const INDICATOR_INVALID:String = "indicatorInv";
      
      private static const IMAGE_ALPHA_INVALID:String = "imageAlphaInv";
      
      private static const FILTERS_GLOW_OFFSET:int = 1;
      
      private static const DISPLAY_LIST_CHILD_INDEX_SHIFT:int = 2;
      
      private static const BIT_MASK_RESCALE_BY_HEIGHT:uint = 1;
      
      private static const BIT_MASK_RESCALE_BY_WIDTH:uint = 2;
      
      private static const TEXT_FIELD_ADDITIONAL_HEIGHT:int = 2;
      
      private static const TEXT_FIELD_TEMPORARY_TEXT:String = "0";
      
      private static const TEXT_FIELD_DISPLAY_NAME:String = "textField";
      
      private static const TEXT_FIELD_LAYOUT_INDEX:uint = 3;
      
      private static const INV_ALERT_INDICATOR:String = "invAlertIndicator";
      
      private static const ALERT_INDICATOR_NAME:String = "alertIndicatorName";
       
      
      public var image:Image = null;
      
      private var _states:MovieClip = null;
      
      private var _toggleGlow:Sprite = null;
      
      private var _toggleIndicator:IUniversalBtnToggleIndicator = null;
      
      private var _imageSource:String = "";
      
      private var _iconAlign:String = "left";
      
      private var _iconOffsetText:int = 3;
      
      private var _baseScaleX:Number = 1;
      
      private var _baseScaleY:Number = 1;
      
      private var _enabledImageAlpha:Number = 1;
      
      private var _disabledImageAlpha:Number = 1;
      
      private var _styleInitComplete:Boolean = false;
      
      private var _tFormat:TextFormat = null;
      
      private var _styleID:String = "";
      
      private var _styledDisplayObjects:IUniversalBtnStyledDisplayObjects = null;
      
      private var _textFieldAlphaMap:Dictionary = null;
      
      private var _frameState:String = "up";
      
      private var _visibilityBeforeInitialized:Boolean = true;
      
      private var _needRestoreVisibilityAfterCreate:Boolean = false;
      
      private var _alertIndicator:MovieClip = null;
      
      private var _alertIndicatorVisible:Boolean;
      
      private var _dispatchResizeEvent:Boolean = true;
      
      private var _placeIconFromBorder:Boolean = false;
      
      private var _iconOffsetX:int = 0;
      
      private var _currentFont:String = "$TitleFont";
      
      public function UniversalBtn()
      {
         super();
      }
      
      override public function gotoAndPlay(param1:Object, param2:String = null) : void
      {
         this._states.gotoAndPlay(param1);
         this._frameState = String(param1);
      }
      
      override public function gotoAndStop(param1:Object, param2:String = null) : void
      {
         this._states.gotoAndStop(param1);
         this._frameState = String(param1);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         textField = new TextField();
         textField.name = TEXT_FIELD_DISPLAY_NAME;
         textField.selectable = false;
         this._tFormat = textField.defaultTextFormat;
         this._tFormat.font = this._currentFont;
         this._tFormat.align = TextFormatAlign.CENTER;
         textField.defaultTextFormat = this._tFormat;
         this.addChildAt(textField,TEXT_FIELD_LAYOUT_INDEX);
         _labelHash = {};
         constraintsDisabled = true;
         preventAutosizing = true;
         this.rescaleItems(BIT_MASK_RESCALE_BY_HEIGHT | BIT_MASK_RESCALE_BY_WIDTH);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.image.visible = false;
         this.image.addEventListener(Event.CHANGE,this.onIconChangeHandler);
         disableMc.repeat = BitmapFill.REPEAT_ALL;
      }
      
      override protected function updateText() : void
      {
         textField.alpha = this.getStateTextAlpha(this._frameState);
         textField.defaultTextFormat = this._tFormat;
         super.updateText();
      }
      
      override protected function draw() : void
      {
         if(!this._styleInitComplete)
         {
            return;
         }
         if(isInvalid(IMAGE_SOURCE_INVALID))
         {
            this.image.visible = StringUtils.isNotEmpty(this._imageSource);
            this.image.source = this._imageSource;
         }
         super.draw();
         if(isInvalid(INDICATOR_INVALID))
         {
            this.updateIndicatorSelection();
         }
         if(isInvalid(IMAGE_ALPHA_INVALID))
         {
            this.updateImageAlpha();
         }
         if(isInvalid(InvalidationType.LAYOUT) || isInvalid(InvalidationType.SIZE) || isInvalid(InvalidationType.DATA))
         {
            this.updatePositions();
         }
         if(isInvalid(INV_ALERT_INDICATOR))
         {
            if(this._alertIndicatorVisible)
            {
               if(!this._alertIndicator && focusIndicator)
               {
                  this._alertIndicator = App.utils.classFactory.getComponent(Linkages.BTN_ALERT_INDICATOR,MovieClip,{"name":ALERT_INDICATOR_NAME});
                  addChildAt(this._alertIndicator,getChildIndex(focusIndicator));
                  this.updateAlertIndicatorSize();
               }
               this._alertIndicator.visible = true;
            }
            else if(this._alertIndicator)
            {
               this._alertIndicator.visible = false;
            }
         }
      }
      
      override protected function updateDynamicSizeByText() : void
      {
         var _loc1_:int = this.height;
         if(textField.text || this.image.visible)
         {
            _loc1_ = textField.textWidth + (_paddingHorizontal + textFieldPaddingHorizontal << 1);
            if(this.image.visible)
            {
               _loc1_ += this.image.width + this._iconOffsetText;
            }
         }
         if(this.canChangeSize(_loc1_))
         {
            this.width = _loc1_;
            if(this._dispatchResizeEvent)
            {
               dispatchEvent(new Event(Event.RESIZE,true));
            }
            if(this._needRestoreVisibilityAfterCreate)
            {
               this.visible = this._visibilityBeforeInitialized;
               this._needRestoreVisibilityAfterCreate = false;
            }
         }
      }
      
      override protected function canChangeSize(param1:Number) : Boolean
      {
         return this.width != param1 && (!changeSizeOnlyUpwards || changeSizeOnlyUpwards && param1 > this.width);
      }
      
      override protected function onDispose() : void
      {
         this.image.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.image.dispose();
         this.image = null;
         this._alertIndicator = null;
         this._tFormat = null;
         this._textFieldAlphaMap = null;
         this.clearStyledDisplayObjects();
         super.onDispose();
      }
      
      public function setStyle(param1:String, param2:IUniversalBtnStyledDisplayObjects, param3:uint, param4:uint, param5:Dictionary, param6:String, param7:DropShadowFilter) : void
      {
         textField.filters = null;
         textField.filters = new Array(param7);
         this._styleInitComplete = false;
         this.clearStyledDisplayObjects();
         var _loc8_:int = this.getChildIndex(disableMc);
         this._styleID = param1;
         this._styledDisplayObjects = param2;
         this._states = param2.states;
         this._textFieldAlphaMap = param5;
         this._toggleGlow = param2.toggleGlow;
         this._toggleIndicator = param2.toggleIndicator;
         this.height = this._states.height;
         this.updateTextFieldStyle(param3,param4);
         this.rescaleDynamicItems();
         addChildAt(this._states,_loc8_);
         _labelHash = UIComponent.generateLabelHash(this._states);
         this._toggleGlow.visible = false;
         this._toggleGlow.x = this._toggleGlow.y = FILTERS_GLOW_OFFSET;
         _loc8_ += DISPLAY_LIST_CHILD_INDEX_SHIFT;
         addChildAt(this._toggleGlow,_loc8_);
         this._toggleIndicator.mouseEnabled = this._toggleIndicator.mouseChildren = false;
         this._toggleIndicator.visible = toggle;
         _loc8_++;
         this.addChildAt(DisplayObject(this._toggleIndicator),_loc8_);
         disableMc.source = param6;
         this._styleInitComplete = true;
         if(_state)
         {
            setState(_state);
         }
         invalidate(InvalidationType.LAYOUT);
      }
      
      public function switchAlertIndicatorVisible(param1:Boolean) : void
      {
         this._alertIndicatorVisible = param1;
         invalidate(INV_ALERT_INDICATOR);
      }
      
      private function updateTextFieldStyle(param1:uint, param2:uint) : void
      {
         if(this._tFormat.size == param1 && this._tFormat.color == param2)
         {
            return;
         }
         this._tFormat.color = param2;
         this._tFormat.size = param1;
         textField.alpha = Values.ZERO;
         textField.text = TEXT_FIELD_TEMPORARY_TEXT;
         textField.setTextFormat(this._tFormat);
         textField.height = textField.textHeight + TEXT_FIELD_ADDITIONAL_HEIGHT ^ 0;
         textField.y = this.height - textField.height >> 1;
         textField.alpha = Values.DEFAULT_ALPHA;
         textField.text = Values.EMPTY_STR;
         this.updateText();
      }
      
      private function getStateTextAlpha(param1:String) : Number
      {
         if(param1 in this._textFieldAlphaMap)
         {
            return this._textFieldAlphaMap[param1];
         }
         return Values.ZERO;
      }
      
      private function clearStyledDisplayObjects() : void
      {
         if(this._styledDisplayObjects)
         {
            removeChild(this._states);
            removeChild(this._toggleGlow);
            removeChild(DisplayObject(this._toggleIndicator));
            dispatchEvent(new UniversalBtnEvent(UniversalBtnEvent.CLEAR_STYLE));
            this._states = null;
            this._toggleIndicator = null;
            this._toggleGlow = null;
            this._styledDisplayObjects = null;
         }
      }
      
      private function rescaleDynamicItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this._states)
         {
            _loc1_ = this.width;
            _loc2_ = this.height;
            this._states.width = _loc1_;
            this._states.height = _loc2_;
         }
         this.updateAlertIndicatorSize();
      }
      
      private function updateAlertIndicatorSize() : void
      {
         if(this._alertIndicator)
         {
            this._alertIndicator.scaleX = this._baseScaleX;
            this._alertIndicator.scaleY = this._baseScaleY;
         }
      }
      
      private function rescaleItems(param1:uint) : void
      {
         var _loc4_:DisplayObject = null;
         if((param1 & BIT_MASK_RESCALE_BY_WIDTH) == BIT_MASK_RESCALE_BY_WIDTH)
         {
            this._baseScaleX = this.scaleX;
         }
         if((param1 & BIT_MASK_RESCALE_BY_HEIGHT) == BIT_MASK_RESCALE_BY_HEIGHT)
         {
            this._baseScaleY = this.scaleY;
         }
         var _loc2_:int = this.numChildren;
         textField.autoSize = TextFieldAutoSize.LEFT;
         this.setActualScale(1,1);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.getChildAt(_loc3_);
            if(_loc4_ != textField && _loc4_ != this.image && _loc4_ != this._states && _loc4_ != this._toggleGlow)
            {
               if((param1 & BIT_MASK_RESCALE_BY_WIDTH) == BIT_MASK_RESCALE_BY_WIDTH)
               {
                  _loc4_.scaleX = this._baseScaleX;
               }
               if((param1 & BIT_MASK_RESCALE_BY_HEIGHT) == BIT_MASK_RESCALE_BY_HEIGHT)
               {
                  _loc4_.scaleY = this._baseScaleY;
               }
            }
            _loc3_++;
         }
         this.rescaleDynamicItems();
      }
      
      private function updatePositions() : void
      {
         textField.autoSize = TextFieldAutoSize.LEFT;
         var _loc1_:Number = 1 / this.scaleX;
         var _loc2_:Number = 1 / this.scaleY;
         this.image.scaleX = _loc1_;
         this.image.scaleY = _loc2_;
         this._toggleIndicator.scaleX = _loc1_;
         this._toggleIndicator.scaleY = _loc2_;
         textField.scaleX = _loc1_;
         textField.scaleY = _loc2_;
         this._toggleGlow.width = hitMc.width - (FILTERS_GLOW_OFFSET << 1);
         this._toggleGlow.height = hitMc.height - (FILTERS_GLOW_OFFSET << 1);
         var _loc3_:int = hitMc.width >> 1;
         var _loc4_:int = 0;
         var _loc5_:Boolean = StringUtils.isNotEmpty(textField.text);
         var _loc6_:Boolean = this.image.visible;
         if(_loc5_)
         {
            _loc4_ = _loc3_ - (textField.width >> 1);
            if(_loc6_)
            {
               if(this._placeIconFromBorder)
               {
                  if(this._iconAlign == TextFieldAutoSize.RIGHT)
                  {
                     _loc4_ = hitMc.width - this._iconOffsetX - this.image.width;
                  }
                  else
                  {
                     _loc4_ = this._iconOffsetX;
                  }
               }
               else if(this._iconAlign == TextFieldAutoSize.RIGHT)
               {
                  _loc4_ += textField.width + (this._iconOffsetText - this.image.width >> 1);
               }
               else
               {
                  _loc4_ -= this.image.width + this._iconOffsetText >> 1;
               }
            }
            textField.y = this.height - textField.height >> 1;
         }
         else if(_loc6_)
         {
            _loc4_ = _loc3_ - (this.image.width >> 1);
         }
         if(_loc6_)
         {
            this.image.x = _loc4_;
            this.image.y = Math.floor((hitMc.height - this.image.height) / 2);
            if(_loc5_)
            {
               if(this._iconAlign == TextFieldAutoSize.RIGHT)
               {
                  textField.x = this.image.x - this._iconOffsetText - textField.width;
               }
               else
               {
                  textField.x = this.image.x + this.image.width + this._iconOffsetText;
               }
            }
         }
         else if(_loc5_)
         {
            textField.x = _loc4_;
         }
         this._toggleIndicator.x = (hitMc.width - this._toggleIndicator.width >> 1) * _loc1_;
         this._toggleIndicator.y = Math.round(hitMc.height - this._toggleIndicator.height);
      }
      
      private function updateIndicatorSelection() : void
      {
         if(toggle)
         {
            this._toggleIndicator.selected = selected;
            this._toggleGlow.visible = selected;
         }
      }
      
      private function updateImageAlpha() : void
      {
         var _loc1_:Number = NaN;
         if(toggle)
         {
            _loc1_ = !!selected ? Number(this._enabledImageAlpha) : Number(this._disabledImageAlpha);
         }
         else
         {
            _loc1_ = !!enabled ? Number(this._enabledImageAlpha) : Number(this._disabledImageAlpha);
         }
         this.image.alpha = _loc1_;
      }
      
      override public function set selected(param1:Boolean) : void
      {
         if(selected != param1)
         {
            super.selected = param1;
            invalidate(INDICATOR_INVALID,IMAGE_ALPHA_INVALID);
         }
      }
      
      override public function get width() : Number
      {
         return this._states != null ? Number(super.width * this._baseScaleX) : Number(super.width);
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         this.rescaleItems(BIT_MASK_RESCALE_BY_WIDTH);
      }
      
      override public function get height() : Number
      {
         return this._states != null ? Number(super.height * this._baseScaleY) : Number(super.height);
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         this.rescaleItems(BIT_MASK_RESCALE_BY_HEIGHT);
      }
      
      override public function set dynamicSizeByText(param1:Boolean) : void
      {
         super.dynamicSizeByText = param1;
         this._needRestoreVisibilityAfterCreate = param1 && !initialized;
         if(this._needRestoreVisibilityAfterCreate)
         {
            this._visibilityBeforeInitialized = this.visible;
            this.visible = false;
         }
      }
      
      override public function set toggle(param1:Boolean) : void
      {
         super.toggle = param1;
         this._toggleIndicator.visible = param1;
         invalidate(INDICATOR_INVALID);
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         invalidate(IMAGE_ALPHA_INVALID);
      }
      
      public function get styledDisplayObjects() : IUniversalBtnStyledDisplayObjects
      {
         return this._styledDisplayObjects;
      }
      
      public function set iconSource(param1:String) : void
      {
         if(this._imageSource != param1)
         {
            this._imageSource = param1;
            invalidate(IMAGE_SOURCE_INVALID);
         }
      }
      
      public function set iconAlign(param1:String) : void
      {
         if(this._iconAlign != param1)
         {
            this._iconAlign = param1;
            isInvalid(InvalidationType.LAYOUT);
         }
      }
      
      public function set iconOffsetText(param1:int) : void
      {
         this._iconOffsetText = param1;
         invalidate(InvalidationType.LAYOUT);
      }
      
      public function set enabledImageAlpha(param1:Number) : void
      {
         this._enabledImageAlpha = param1;
         invalidate(IMAGE_ALPHA_INVALID);
      }
      
      public function set disabledImageAlpha(param1:Number) : void
      {
         this._disabledImageAlpha = param1;
         invalidate(IMAGE_ALPHA_INVALID);
      }
      
      public function set backgroundAlpha(param1:Number) : void
      {
         this._states.alpha = param1;
      }
      
      public function get styleID() : String
      {
         return this._styleID;
      }
      
      public function set dispatchResizeEvent(param1:Boolean) : void
      {
         this._dispatchResizeEvent = param1;
      }
      
      public function set placeIconFromBorder(param1:Boolean) : void
      {
         this._placeIconFromBorder = param1;
      }
      
      public function set iconOffsetX(param1:int) : void
      {
         this._iconOffsetX = param1;
      }
      
      public function set currentFont(param1:String) : void
      {
         if(this._currentFont != param1)
         {
            this._currentFont = param1;
            this._tFormat.font = param1;
            textField.defaultTextFormat = this._tFormat;
         }
      }
      
      private function onIconChangeHandler(param1:Event) : void
      {
         invalidate(InvalidationType.LAYOUT);
      }
   }
}
