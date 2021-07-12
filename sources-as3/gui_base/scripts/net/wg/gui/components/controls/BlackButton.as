package net.wg.gui.components.controls
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextFieldAutoSize;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   public class BlackButton extends SoundButtonEx
   {
      
      private static const IMAGE_SOURCE_INVALID:String = "imageSrcInv";
      
      private static const INDICATOR_INVALID:String = "indicatorInv";
      
      private static const IMAGE_ALPHA_INVALID:String = "imageAlphaInv";
      
      private static const FILTERS_GLOW_OFSET:int = -2;
       
      
      public var image:Image = null;
      
      public var states:MovieClip = null;
      
      public var toggleGlow:Sprite = null;
      
      public var toggleIndicator:ToggleIndicator = null;
      
      private var _toggleEnable:Boolean = false;
      
      private var _imageSource:String = "";
      
      private var _iconOffsetText:int = 3;
      
      private var _baseScaleX:Number = 1;
      
      private var _baseScaleY:Number = 1;
      
      private var _enabledImageAlpha:Number = 1;
      
      private var _disabledImageAlpha:Number = 1;
      
      public function BlackButton()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         if(this.states != null)
         {
            _labelHash = UIComponent.generateLabelHash(this.states);
            constraintsDisabled = true;
            preventAutosizing = true;
         }
         this.toggleGlow.visible = false;
         this.rescaleItems();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.toggleIndicator.visible = this._toggleEnable;
         this.toggleIndicator.mouseEnabled = this.toggleIndicator.mouseChildren = false;
         this.image.visible = false;
         this.image.addEventListener(Event.CHANGE,this.onIconChangeHandler);
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.STATE))
         {
            if(StringUtils.isNotEmpty(_newFrame))
            {
               App.utils.asserter.assert(_labelHash.hasOwnProperty(_newFrame),"Not found state " + _newFrame);
               this.states.gotoAndPlay(_newFrame);
               if(_baseDisposed)
               {
                  return;
               }
            }
         }
         super.draw();
         if(isInvalid(IMAGE_SOURCE_INVALID))
         {
            if(StringUtils.isNotEmpty(this._imageSource))
            {
               this.image.visible = true;
               this.image.source = this._imageSource;
            }
            else
            {
               this.image.visible = false;
            }
         }
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
      }
      
      override protected function updateDynamicSizeByText() : void
      {
         var _loc1_:Number = NaN;
         if(textField != null && StringUtils.isNotEmpty(textField.text))
         {
            _loc1_ = textField.textWidth + (!!this.image.visible ? this.image.width : _paddingHorizontal + textFieldPaddingHorizontal << 1);
            if(this.canChangeSize(_loc1_))
            {
               this.width = _loc1_;
               dispatchEvent(new Event(Event.RESIZE,true));
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
         this.toggleIndicator.dispose();
         this.toggleIndicator = null;
         this.states = null;
         this.toggleGlow = null;
         super.onDispose();
      }
      
      private function rescaleItems() : void
      {
         var _loc3_:DisplayObject = null;
         this._baseScaleX = this.scaleX;
         this._baseScaleY = this.scaleY;
         var _loc1_:int = this.numChildren;
         textField.autoSize = TextFieldAutoSize.LEFT;
         this.setActualScale(1,1);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.getChildAt(_loc2_);
            if(_loc3_ != textField || _loc3_ != this.image)
            {
               _loc3_.scaleX = this._baseScaleX;
               _loc3_.scaleY = this._baseScaleY;
            }
            _loc2_++;
         }
      }
      
      private function updatePositions() : void
      {
         textField.autoSize = TextFieldAutoSize.LEFT;
         var _loc1_:Number = 1 / this.scaleX;
         var _loc2_:Number = 1 / this.scaleY;
         this.image.scaleX = _loc1_;
         this.image.scaleY = _loc2_;
         this.toggleIndicator.scaleX = _loc1_;
         this.toggleIndicator.scaleY = _loc2_;
         textField.scaleX = _loc1_;
         textField.scaleY = _loc2_;
         var _loc3_:int = hitMc.width >> 1;
         this.layoutContent(_loc3_,_loc1_,_loc2_);
      }
      
      protected function layoutContent(param1:int, param2:Number, param3:Number) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Boolean = textField.text != null && StringUtils.isNotEmpty(textField.text);
         var _loc6_:Boolean = this.image.visible;
         textField.x = param1 - (textField.width >> 1);
         this.toggleGlow.scaleX = param2;
         this.toggleGlow.scaleY = param3;
         this.toggleGlow.width = hitMc.width + FILTERS_GLOW_OFSET;
         this.toggleGlow.height = hitMc.height + FILTERS_GLOW_OFSET;
         if(_loc5_)
         {
            _loc4_ = param1 - (textField.width >> 1);
            if(_loc6_)
            {
               _loc4_ -= this.image.width + this._iconOffsetText >> 1;
            }
         }
         else if(_loc6_)
         {
            _loc4_ = param1 - (this.image.width >> 1);
         }
         if(_loc6_)
         {
            this.image.x = _loc4_;
            this.image.y = hitMc.height - this.image.height >> 1;
            if(_loc5_)
            {
               textField.x = this.image.x + this.image.width + this._iconOffsetText;
            }
         }
         else if(_loc5_)
         {
            textField.x = _loc4_;
         }
         this.toggleIndicator.x = (hitMc.width - this.toggleIndicator.width >> 1) * param2;
         this.toggleIndicator.y = Math.round(hitMc.height - this.toggleIndicator.height);
      }
      
      private function updateIndicatorSelection() : void
      {
         if(this._toggleEnable)
         {
            this.toggleIndicator.selected = selected;
            this.toggleGlow.visible = selected;
         }
      }
      
      private function updateImageAlpha() : void
      {
         if(this._toggleEnable)
         {
            if(selected)
            {
               this.image.alpha = this._enabledImageAlpha;
            }
            else
            {
               this.image.alpha = this._disabledImageAlpha;
            }
         }
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
         return this.states != null ? Number(super.width * this._baseScaleX) : Number(super.width);
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         this.rescaleItems();
      }
      
      override public function get height() : Number
      {
         return this.states != null ? Number(super.height * this._baseScaleY) : Number(super.height);
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         this.rescaleItems();
      }
      
      public function set iconSource(param1:String) : void
      {
         if(this._imageSource != param1)
         {
            this._imageSource = param1;
            invalidate(IMAGE_SOURCE_INVALID);
         }
      }
      
      public function set toggleEnable(param1:Boolean) : void
      {
         this._toggleEnable = param1;
         this.toggleIndicator.visible = param1;
         invalidate(INDICATOR_INVALID);
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
         this.states.alpha = param1;
      }
      
      private function onIconChangeHandler(param1:Event) : void
      {
         invalidate(InvalidationType.LAYOUT);
      }
   }
}
