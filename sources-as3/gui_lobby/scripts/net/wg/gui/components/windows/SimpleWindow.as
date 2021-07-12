package net.wg.gui.components.windows
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getQualifiedClassName;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.windows.vo.SimpleWindowBtnVo;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.base.meta.ISimpleWindowMeta;
   import net.wg.infrastructure.base.meta.impl.SimpleWindowMeta;
   import net.wg.infrastructure.constants.WindowViewInvalidationType;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.utils.Padding;
   
   public class SimpleWindow extends SimpleWindowMeta implements ISimpleWindowMeta
   {
      
      public static const INVALID_CONTENT_SIZE:String = "invalidContentSize";
      
      public static const INVALID_LAYOUT:String = "invalidLayout";
      
      public static const INVALID_BUTTONS:String = "invalidButtons";
      
      public static const DESCRIPTION_HORIZONTAL_MARGIN:int = 20;
      
      private static const HEADER_MARGIN:int = 10;
      
      private static const DESCRIPTION_VERTICAL_MARGIN:int = 25;
      
      private static const MARGIN_BETWEEN_BUTTONS:int = 4;
      
      private static const TEXT_FIELD_ADD_SIZE_FOR_FONT:int = 4;
      
      private static const WND_FORM_PADDING_BOTTOM:int = 13;
      
      private static const IO_ERROR_MESSAGE:String = "Flash :: Couldn\'t Load Image, ";
       
      
      public var headerTf:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      public var wndBounds:Sprite = null;
      
      public var image:UILoaderAlt = null;
      
      private var _imgBottomMargin:int = 25;
      
      private var _btnWidth:int = 120;
      
      private var _buttons:Vector.<SoundButtonEx> = null;
      
      private var _btnAlign:String = "left";
      
      private var _itemForFocus:InteractiveObject = null;
      
      private var _contentBottomMargin:int = 0;
      
      public function SimpleWindow()
      {
         super();
         this._itemForFocus = this;
         this.contentBottomMargin = DESCRIPTION_VERTICAL_MARGIN;
         this.initTexts();
      }
      
      override public function setWindow(param1:IWindow) : void
      {
         super.setWindow(param1);
         this.initWindowProps();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         DisplayObject(window).visible = false;
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         setFocus(this._itemForFocus);
      }
      
      override protected function onSetModalFocus(param1:InteractiveObject) : void
      {
         super.onSetModalFocus(this._itemForFocus);
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.showWindow);
         this.clearButtons();
         this.wndBounds = null;
         this.descriptionTF = null;
         this.headerTf = null;
         this.image.removeEventListener(UILoaderEvent.COMPLETE,this.onImageCompleteHandler);
         this.image.removeEventListener(UILoaderEvent.IOERROR,this.onImageIoErrorHandler);
         this.image.dispose();
         this.image = null;
         this._itemForFocus = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         var _loc1_:Rectangle = new Rectangle();
         if(isInvalid(INVALID_LAYOUT))
         {
            _loc1_ = this.updateContentLayout();
            _loc1_.height += this.contentBottomMargin;
            invalidate(INVALID_BUTTONS);
         }
         if(isInvalid(INVALID_BUTTONS))
         {
            this.updateLayoutButtons(_loc1_);
            invalidate(INVALID_CONTENT_SIZE);
         }
         if(isInvalid(INVALID_CONTENT_SIZE))
         {
            this.updateWindowSize();
            invalidate(WindowViewInvalidationType.POSITION_INVALID);
         }
         if(window != null && isInvalid(WindowViewInvalidationType.POSITION_INVALID))
         {
            this.repositionWindow();
            if(!DisplayObject(window).visible)
            {
               App.utils.scheduler.scheduleOnNextFrame(this.showWindow);
            }
         }
      }
      
      override protected function setButtons(param1:Vector.<SimpleWindowBtnVo>, param2:String, param3:int) : void
      {
         this._btnAlign = param2;
         this._btnWidth = param3;
         this.clearButtons();
         this.setupButtons(param1);
         invalidate(INVALID_BUTTONS);
      }
      
      public function as_setImage(param1:String, param2:int) : void
      {
         this._imgBottomMargin = param2;
         this.image.visible = true;
         this.image.addEventListener(UILoaderEvent.COMPLETE,this.onImageCompleteHandler);
         this.image.addEventListener(UILoaderEvent.IOERROR,this.onImageIoErrorHandler);
         this.image.source = param1;
      }
      
      public function as_setText(param1:String, param2:String) : void
      {
         this.headerTf.visible = param1 && param1 != Values.EMPTY_STR;
         if(this.headerTf.visible)
         {
            this.headerTf.htmlText = param1;
         }
         this.descriptionTF.htmlText = param2;
         invalidate(INVALID_LAYOUT);
      }
      
      public function as_setWindowTitle(param1:String) : void
      {
         window.title = param1;
      }
      
      protected function initTexts() : void
      {
         this.descriptionTF.multiline = true;
         this.descriptionTF.wordWrap = true;
         this.descriptionTF.autoSize = TextFieldAutoSize.LEFT;
         this.descriptionTF.x = DESCRIPTION_HORIZONTAL_MARGIN;
         this.headerTf.multiline = true;
         this.headerTf.wordWrap = true;
         this.headerTf.autoSize = TextFieldAutoSize.LEFT;
         this.headerTf.x = DESCRIPTION_HORIZONTAL_MARGIN;
      }
      
      protected function initWindowProps() : void
      {
         var _loc1_:Padding = null;
         if(window != null)
         {
            _loc1_ = window.formBgPadding;
            _loc1_.bottom = WND_FORM_PADDING_BOTTOM;
            window.formBgPadding = _loc1_;
            window.getConstraints().scaleMode = ConstrainMode.COUNTER_SCALE;
            window.useBottomBtns = true;
         }
      }
      
      protected function addBtnListeners(param1:SoundButtonEx) : void
      {
         param1.addEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
      }
      
      protected function cleanBtnListeners(param1:SoundButtonEx) : void
      {
         param1.removeEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         param1.dispose();
         param1 = null;
      }
      
      protected function repositionWindow() : void
      {
         window.x = App.appWidth - window.width >> 1;
         window.y = App.appHeight - window.getBackground().height >> 1;
      }
      
      protected function updateCustomLayout(param1:Number, param2:Number) : Rectangle
      {
         var _loc3_:int = param1 - 2 * DESCRIPTION_HORIZONTAL_MARGIN;
         param2 += DESCRIPTION_VERTICAL_MARGIN ^ 0;
         if(this.headerTf.visible)
         {
            this.headerTf.width = _loc3_;
            this.headerTf.height = this.headerTf.textHeight + TEXT_FIELD_ADD_SIZE_FOR_FONT ^ 0;
            this.headerTf.y = param2;
            param2 += this.headerTf.height + HEADER_MARGIN ^ 0;
         }
         this.descriptionTF.width = _loc3_;
         this.descriptionTF.height = this.descriptionTF.textHeight + TEXT_FIELD_ADD_SIZE_FOR_FONT;
         this.descriptionTF.y = param2;
         param2 = this.descriptionTF.y + this.descriptionTF.textHeight ^ 0;
         return new Rectangle(0,0,param1,param2);
      }
      
      protected function isBtnHasCustomAction(param1:String) : Boolean
      {
         return false;
      }
      
      protected function updateContentLayout() : Rectangle
      {
         var _loc1_:int = 0;
         if(this.image.source != Values.EMPTY_STR)
         {
            _loc1_ = this.image.y + this.image.height + this._imgBottomMargin;
         }
         var _loc2_:int = Math.max(this.width,this.image.width);
         return this.updateCustomLayout(_loc2_,_loc1_);
      }
      
      private function updateLayoutButtons(param1:Rectangle) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:SoundButtonEx = null;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         if(this._buttons != null)
         {
            _loc2_ = 3;
            _loc3_ = 1;
            _loc4_ = 0;
            _loc5_ = this._btnWidth + MARGIN_BETWEEN_BUTTONS;
            if(this._btnAlign == TextFieldAutoSize.RIGHT)
            {
               _loc4_ = param1.width - (this._btnWidth * this._buttons.length + MARGIN_BETWEEN_BUTTONS * (this._buttons.length - 1)) + _loc3_;
            }
            else if(this._btnAlign == TextFieldAutoSize.LEFT)
            {
               _loc4_ = -_loc3_;
            }
            else
            {
               _loc4_ = param1.width - this._btnWidth * this._buttons.length - MARGIN_BETWEEN_BUTTONS * (this._buttons.length - 1) >> 1;
            }
            _loc6_ = null;
            _loc7_ = this._buttons.length;
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               _loc6_ = this._buttons[_loc8_];
               _loc6_.y = param1.height ^ 0;
               _loc6_.x = _loc4_ + _loc5_ * _loc8_;
               _loc8_++;
            }
            param1.height = _loc6_.y + _loc6_.height - _loc2_ ^ 0;
         }
         this.updateBounds(param1);
      }
      
      private function updateBounds(param1:Rectangle) : void
      {
         this.wndBounds.width = param1.width;
         this.wndBounds.height = param1.height;
      }
      
      private function clearButtons() : void
      {
         var _loc1_:int = 0;
         if(this._buttons != null)
         {
            _loc1_ = this._buttons.length;
            while(_loc1_)
            {
               this.cleanBtnListeners(this._buttons.pop());
               _loc1_--;
            }
            this._buttons = null;
         }
      }
      
      private function setupButtons(param1:Vector.<SimpleWindowBtnVo>) : void
      {
         var _loc2_:SoundButtonEx = null;
         var _loc3_:SimpleWindowBtnVo = null;
         this._buttons = new Vector.<SoundButtonEx>(0);
         if(this._itemForFocus == null)
         {
            this._itemForFocus = this;
         }
         for each(_loc3_ in param1)
         {
            _loc2_ = App.utils.classFactory.getObject(_loc3_.btnLinkage) as SoundButtonEx;
            App.utils.asserter.assertNotNull(_loc2_,"btn" + Errors.CANT_NULL);
            _loc2_.label = _loc3_.label;
            _loc2_.data = _loc3_.action;
            _loc2_.width = this._btnWidth;
            _loc2_.tooltip = _loc3_.tooltip;
            _loc2_.mouseEnabledOnDisabled = _loc3_.mouseEnabledOnDisabled;
            _loc2_.enabled = _loc3_.enabled;
            if(_loc3_.btnName != Values.EMPTY_STR)
            {
               _loc2_.name = _loc3_.btnName;
            }
            this._buttons.push(_loc2_);
            this.addBtnListeners(_loc2_);
            addChild(_loc2_);
            if(_loc3_.isFocused)
            {
               setFocus(_loc2_);
               this._itemForFocus = _loc2_;
            }
         }
      }
      
      private function showWindow() : void
      {
         DisplayObject(window).visible = true;
      }
      
      private function updateWindowSize() : void
      {
         window.updateSize(this.wndBounds.width,this.wndBounds.height,true);
      }
      
      public function get contentBottomMargin() : int
      {
         return this._contentBottomMargin;
      }
      
      public function set contentBottomMargin(param1:int) : void
      {
         this._contentBottomMargin = param1;
      }
      
      protected function get itemForFocus() : InteractiveObject
      {
         return this._itemForFocus;
      }
      
      protected function set itemForFocus(param1:InteractiveObject) : void
      {
         this._itemForFocus = param1;
      }
      
      private function onImageIoErrorHandler(param1:UILoaderEvent) : void
      {
         DebugUtils.LOG_ERROR(IO_ERROR_MESSAGE + getQualifiedClassName(this));
      }
      
      private function onButtonClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:String = String(SoundButtonEx(param1.target).data);
         if(!this.isBtnHasCustomAction(_loc2_))
         {
            onBtnClickS(_loc2_);
         }
      }
      
      private function onImageCompleteHandler(param1:UILoaderEvent) : void
      {
         invalidate(INVALID_LAYOUT);
      }
   }
}
