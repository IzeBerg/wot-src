package net.wg.gui.components.windows
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import net.wg.data.constants.DragType;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.CloseButton;
   import net.wg.gui.components.controls.SoundButton;
   import net.wg.gui.components.controls.TextFieldShort;
   import net.wg.infrastructure.interfaces.IAbstractWindowView;
   import net.wg.infrastructure.interfaces.IAbstractWrapperView;
   import net.wg.infrastructure.interfaces.IManagedContent;
   import net.wg.infrastructure.interfaces.ITextContainer;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   import scaleform.clik.controls.Window;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.utils.ConstrainedElement;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.utils.Padding;
   
   public class Window extends scaleform.clik.controls.Window implements IWindow
   {
      
      public static const INVALID_SRC_VIEW:String = "windowContent";
      
      private static const DRAG_BOUND_UP:Number = 0;
      
      private static const INVALID_TITLE:String = "titleInv";
      
      private static const INVALID_PADDING:String = "padding";
      
      private static const INVALID_RESIZE_BTN_STATE:String = "resizeBtnState";
      
      private static const CLOSE_BTN:String = "closeBtn";
      
      private static const BG_FORM:String = "bgForm";
      
      private static const MINIMIZE_BTN:String = "minimizeBtn";
      
      private static const TITLE_BTN:String = "titleBtn";
      
      private static const CONTENT:String = "content";
      
      private static const BTN_PADDING_Y:Number = 26;
       
      
      public var iconMovie:MovieClip = null;
      
      public var minimizeBtn:SoundButton = null;
      
      public var titleBtnEx:TextFieldShort = null;
      
      public var closeBtnEx:CloseButton = null;
      
      public var resizeBtnEx:SoundButton = null;
      
      public var bgForm:Sprite = null;
      
      private var _isDisposing:Boolean = false;
      
      private var _formBgPadding:Padding = null;
      
      private var _useBottomBtns:Boolean = false;
      
      private var _showBgForm:Boolean = true;
      
      private var _draggingRegistered:Boolean = false;
      
      private var _windowContent:IAbstractWindowView = null;
      
      private var _topButtonOffsets:Vector.<Number> = null;
      
      private var _titleUseHtml:Boolean = false;
      
      private var _isScaleXFirsttimeSetted:Boolean = false;
      
      private var _isScaleYFirsttimeSetted:Boolean = false;
      
      private var _explicitWidth:Number = NaN;
      
      private var _explicitHeight:Number = NaN;
      
      public function Window()
      {
         super();
         this._formBgPadding = this.getBgFormDefPadding();
         _contentPadding = this.getContentDefPadding();
         maxWidth = 1024;
         maxHeight = 720;
         titleBtn = this.titleBtnEx;
         closeBtn = this.closeBtnEx;
         resizeBtn = this.resizeBtnEx;
      }
      
      override protected function onDispose() : void
      {
         if(_content && contains(_content))
         {
            removeChild(_content);
         }
         if(this.windowContent.canDrag && initialized)
         {
            App.cursor.unRegisterDragging(this);
         }
         this._isDisposing = true;
         this.minimizeBtn.removeEventListener(ButtonEvent.CLICK,this.onMinimizeButtonClick);
         titleBtn.removeEventListener(MouseEvent.MOUSE_DOWN,onWindowStartDrag);
         closeBtn.removeEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
         closeBtn.removeEventListener(ButtonEvent.CLICK,this.closeButtonClickHandler);
         resizeBtn.removeEventListener(MouseEvent.MOUSE_DOWN,onResizeStartDrag);
         resizeBtn.removeEventListener(ButtonEvent.PRESS,this.onResizeBtnPress);
         resizeBtn.removeEventListener(ButtonEvent.RELEASE_OUTSIDE,this.onResizeBtnReleaseOutsize);
         if(okBtn)
         {
            okBtn.removeEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
            okBtn.dispose();
            okBtn = null;
         }
         this.titleBtnEx.dispose();
         titleBtn = this.titleBtnEx = null;
         this.resizeBtnEx.dispose();
         resizeBtn = this.resizeBtnEx = null;
         this.closeBtnEx.dispose();
         closeBtn = this.closeBtnEx = null;
         this.minimizeBtn.dispose();
         this.minimizeBtn = null;
         this._formBgPadding = null;
         this.bgForm = null;
         this._topButtonOffsets.splice(0,this._topButtonOffsets.length);
         this._topButtonOffsets = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._topButtonOffsets = new Vector.<Number>();
         if(closeBtn != null)
         {
            closeBtn.removeEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
            closeBtn.addEventListener(ButtonEvent.CLICK,this.closeButtonClickHandler,false,0,true);
            constraints.addElement(CLOSE_BTN,closeBtn,Constraints.TOP | Constraints.RIGHT);
            this._topButtonOffsets.push(constraints.getElement(CLOSE_BTN).right);
         }
         if(this.bgForm != null)
         {
            constraints.addElement(BG_FORM,this.bgForm,Constraints.ALL);
            this.bgForm.mouseEnabled = false;
            this.bgForm.mouseChildren = false;
            this.bgForm.tabEnabled = false;
            this.bgForm.tabChildren = false;
         }
         if(this.minimizeBtn != null)
         {
            constraints.addElement(MINIMIZE_BTN,this.minimizeBtn,Constraints.TOP | Constraints.RIGHT);
            this.minimizeBtn.addEventListener(ButtonEvent.CLICK,this.onMinimizeButtonClick);
            this._topButtonOffsets.push(constraints.getElement(MINIMIZE_BTN).right);
         }
         if(hit)
         {
            hitArea = hit;
         }
         if(background)
         {
            background.mouseEnabled = false;
            background.mouseChildren = false;
            background.tabEnabled = false;
            background.tabChildren = false;
         }
         if(titleBtn)
         {
            titleBtn.removeEventListener(MouseEvent.MOUSE_DOWN,onWindowStartDrag);
         }
         resizeBtn.addEventListener(ButtonEvent.PRESS,this.onResizeBtnPress);
         resizeBtn.addEventListener(ButtonEvent.RELEASE_OUTSIDE,this.onResizeBtnReleaseOutsize);
         if(this._explicitWidth === this._explicitWidth || this._explicitHeight === this._explicitHeight)
         {
            this.updateSize(this._explicitWidth,this._explicitHeight,false);
         }
      }
      
      override protected function draw() : void
      {
         var buttonPositionsChanged:Boolean = false;
         if(isInvalid(INVALID_SRC_VIEW) && this.windowContent)
         {
            this.updateSource();
            this.showBgForm = this.windowContent.showWindowBgForm;
            background.visible = this.windowContent.showWindowBg;
            titleBtn.visible = this.windowContent.showWindowBg;
            this.minimizeBtn.visible = this.windowContent.canMinimize;
            resizeBtn.visible = this.windowContent.canResize;
            closeBtn.visible = this.windowContent.canClose;
            closeBtn.enabled = this.windowContent.enabledCloseBtn;
            buttonPositionsChanged = this.updateTopButtonPositions();
            if(this.windowContent.canDrag && !this._draggingRegistered)
            {
               try
               {
                  App.cursor.registerDragging(this);
                  this._draggingRegistered = true;
               }
               catch(e:Error)
               {
               }
            }
            if(this.windowContent.isSourceTracked)
            {
               this.windowContent.onSourceLoadedS();
            }
         }
         if(isInvalid(INVALID_PADDING,INVALID_SRC_VIEW))
         {
            this.reflowContent();
         }
         if(!this._isDisposing && (isInvalid(InvalidationType.SIZE) || buttonPositionsChanged))
         {
            constraints.update(_width,_height);
         }
         if(isInvalid(INVALID_TITLE))
         {
            this.titleBtnEx.useHtml = this._titleUseHtml;
            titleBtn.label = _title != null ? _title : Values.EMPTY_STR;
            if(this.iconMovie.currentFrame > 1 || currentLabel != null)
            {
               titleBtn.x = this.iconMovie.x + this.iconMovie.width;
               titleBtn.width = this.minimizeBtn.x - titleBtn.x;
            }
            titleBtn.validateNow();
         }
         if(isInvalid(INVALID_RESIZE_BTN_STATE))
         {
            resizeBtn.lockDragStateChange = false;
         }
      }
      
      override protected function reflowContent() : void
      {
         var _loc1_:Padding = null;
         var _loc2_:ConstrainedElement = null;
         this.bgForm.visible = this._showBgForm;
         if(this.showBgForm && this.bgForm != null)
         {
            _loc1_ = this.formBgPadding;
            _loc2_ = constraints.getElement(BG_FORM);
            this.bgForm.x = _loc2_.left = _loc1_.left;
            this.bgForm.y = _loc2_.top = _loc1_.top;
            _loc2_.right = _loc1_.right;
            _loc2_.bottom = _loc1_.bottom;
            this.bgForm.width = _width - _loc1_.horizontal;
            this.bgForm.height = _height - _loc1_.vertical;
         }
         super.reflowContent();
      }
      
      public function getBackground() : MovieClip
      {
         return background;
      }
      
      public function getBtnsBounds() : Rectangle
      {
         var _loc1_:Rectangle = new Rectangle();
         _loc1_.x = !!this.minimizeBtn.visible ? Number(this.minimizeBtn.x) : Number(closeBtn.x);
         _loc1_.y = closeBtn.y;
         _loc1_.width = closeBtn.x + closeBtn.width - _loc1_.x ^ 0;
         _loc1_.height = closeBtn.height;
         return _loc1_;
      }
      
      public function getCloseBtn() : Button
      {
         return closeBtn;
      }
      
      public function getConstraints() : Constraints
      {
         return constraints;
      }
      
      public function getDragType() : String
      {
         return DragType.SOFT;
      }
      
      public function getHitArea() : InteractiveObject
      {
         return this.titleBtnEx;
      }
      
      public function getIconMovie() : MovieClip
      {
         return this.iconMovie;
      }
      
      public function getMinHeight() : Number
      {
         return minHeight;
      }
      
      public function getMinWidth() : Number
      {
         return minWidth;
      }
      
      public function getTitleBtn() : Button
      {
         return titleBtn;
      }
      
      public function getTitleBtnEx() : ITextContainer
      {
         return this.titleBtnEx;
      }
      
      public function onDragging(param1:Number, param2:Number) : void
      {
      }
      
      public function onEndDrag() : void
      {
         stopDrag();
         if(y < DRAG_BOUND_UP)
         {
            y = DRAG_BOUND_UP;
         }
         if(y > App.appHeight - this.bgForm.y)
         {
            y = App.appHeight - this.bgForm.y;
         }
      }
      
      public function onStartDrag() : void
      {
         startDrag();
      }
      
      public function setMaxHeight(param1:Number) : void
      {
         maxHeight = param1;
      }
      
      public function setMaxWidth(param1:Number) : void
      {
         maxWidth = param1;
      }
      
      public function setMinHeight(param1:Number) : void
      {
         minHeight = param1;
      }
      
      public function setMinWidth(param1:Number) : void
      {
         minWidth = param1;
      }
      
      public function setTitleIcon(param1:String) : void
      {
         this.iconMovie.gotoAndStop(param1);
         invalidate(INVALID_TITLE);
      }
      
      public function setWindow(param1:IWindow) : void
      {
      }
      
      public function setWindowContent(param1:IAbstractWindowView) : void
      {
         this._windowContent = param1;
         if(_content != null)
         {
            constraints.removeElement(CONTENT);
            removeChild(_content);
         }
         if(this._windowContent != null)
         {
            _content = DisplayObject(this.windowContent);
            addChild(_content);
            if(this.windowContent.canResize)
            {
               setChildIndex(resizeBtn,numChildren - 1);
            }
            constraints.addElement(CONTENT,_content,Constraints.ALL);
            invalidate(INVALID_SRC_VIEW);
         }
      }
      
      public function updateSize(param1:Number, param2:Number, param3:Boolean = false) : void
      {
         if(param3)
         {
            param1 += contentPadding.horizontal;
            param2 += contentPadding.vertical;
         }
         if(this.initialized)
         {
            _originalWidth = param1;
            _originalHeight = param2;
            setActualSize(param1,param2);
            setActualScale(1,1);
         }
         else
         {
            this._explicitWidth = param1;
            this._explicitHeight = param2;
         }
      }
      
      protected function updateSource() : void
      {
         if(this.windowContent != null)
         {
            minWidth = _content.width + contentPadding.horizontal;
            minHeight = _content.height + contentPadding.vertical;
            if(this._explicitWidth === this._explicitWidth)
            {
               minWidth = Math.max(minWidth,this._explicitWidth);
            }
            if(this._explicitHeight === this._explicitHeight)
            {
               minHeight = Math.max(minHeight,this._explicitHeight);
            }
            this._explicitWidth = Number.NaN;
            this._explicitHeight = Number.NaN;
            this.windowContent.geometry.setSize(this);
         }
      }
      
      private function updateTopButtonPositions() : Boolean
      {
         var _loc3_:int = 0;
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         if(closeBtn && closeBtn.visible)
         {
            _loc2_++;
         }
         if(this.minimizeBtn && this.minimizeBtn.visible)
         {
            if(this.updateButtonConstraints(MINIMIZE_BTN,this._topButtonOffsets[_loc2_]))
            {
               _loc1_ = true;
            }
         }
         if(titleBtn && titleBtn.visible)
         {
            _loc3_ = !!this.minimizeBtn.visible ? int(this.minimizeBtn.width) : int(0);
            if(this.updateButtonConstraints(TITLE_BTN,this._topButtonOffsets[_loc2_] + _loc3_))
            {
               _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      private function updateButtonConstraints(param1:String, param2:int) : Boolean
      {
         var _loc3_:ConstrainedElement = constraints.getElement(param1);
         if(_loc3_.right != param2)
         {
            _loc3_.right = param2;
            return true;
         }
         return false;
      }
      
      private function getBgFormDefPadding() : Padding
      {
         return new Padding(33,11,16,10);
      }
      
      private function getContentDefPadding() : Padding
      {
         return new Padding(35,13,19,12);
      }
      
      override public function set scaleX(param1:Number) : void
      {
         if(this._isScaleXFirsttimeSetted && super.scaleX == param1)
         {
            return;
         }
         var _loc2_:Number = width;
         super.scaleX = param1;
         dispatchEvent(new WindowEvent(WindowEvent.SCALE_X_CHANGED,_loc2_));
         this._isScaleXFirsttimeSetted = true;
      }
      
      override public function set scaleY(param1:Number) : void
      {
         if(this._isScaleYFirsttimeSetted && super.scaleY == param1)
         {
            return;
         }
         var _loc2_:Number = height;
         super.scaleY = param1;
         dispatchEvent(new WindowEvent(WindowEvent.SCALE_Y_CHANGED,_loc2_));
         this._isScaleYFirsttimeSetted = true;
      }
      
      override public function set title(param1:String) : void
      {
         _title = param1;
         invalidate(INVALID_TITLE);
      }
      
      public function set titleUseHtml(param1:Boolean) : void
      {
         this._titleUseHtml = param1;
         invalidate(INVALID_TITLE);
      }
      
      public function get wrapperContent() : IAbstractWrapperView
      {
         return this._windowContent;
      }
      
      public function set wrapperContent(param1:IAbstractWrapperView) : void
      {
         this.setWindowContent(IAbstractWindowView(param1));
      }
      
      public function get isModal() : Boolean
      {
         return this._windowContent.isModal;
      }
      
      public function get modalAlpha() : Number
      {
         return Values.DEFAULT_ALPHA;
      }
      
      public function get window() : IManagedContent
      {
         return this;
      }
      
      public function get sourceView() : IView
      {
         return this._windowContent;
      }
      
      public function get windowContent() : IAbstractWindowView
      {
         return this._windowContent;
      }
      
      public function get containerContent() : IManagedContent
      {
         return this;
      }
      
      public function get formBgPadding() : Padding
      {
         return this._formBgPadding;
      }
      
      public function set formBgPadding(param1:Padding) : void
      {
         this._formBgPadding = param1;
         invalidate(INVALID_PADDING);
      }
      
      public function get useBottomBtns() : Boolean
      {
         return this._useBottomBtns;
      }
      
      public function set useBottomBtns(param1:Boolean) : void
      {
         if(this._useBottomBtns == param1)
         {
            return;
         }
         this._useBottomBtns = param1;
         this.formBgPadding.bottom = !!this._useBottomBtns ? Number(this.getBgFormDefPadding().bottom + BTN_PADDING_Y) : Number(this.getBgFormDefPadding().bottom);
         invalidate(INVALID_PADDING);
      }
      
      public function get showBgForm() : Boolean
      {
         return this._showBgForm;
      }
      
      public function set showBgForm(param1:Boolean) : void
      {
         if(param1 == this.showBgForm)
         {
            return;
         }
         this._showBgForm = param1;
         _contentPadding = !!this._showBgForm ? this.getContentDefPadding() : _contentPadding;
         invalidate(INVALID_PADDING);
      }
      
      override protected function onCloseButtonClick(param1:MouseEvent) : void
      {
         if(this.windowContent != null)
         {
            this.windowContent.handleWindowClose();
         }
      }
      
      protected function closeButtonClickHandler(param1:ButtonEvent) : void
      {
         this.onCloseButtonClick(null);
      }
      
      protected function onMinimizeButtonClick(param1:ButtonEvent) : void
      {
         if(this.windowContent != null && this.windowContent.canMinimize)
         {
            this.windowContent.handleWindowMinimize();
         }
      }
      
      private function onResizeBtnPress(param1:ButtonEvent) : void
      {
         resizeBtn.lockDragStateChange = true;
      }
      
      private function onResizeBtnReleaseOutsize(param1:ButtonEvent) : void
      {
         invalidate(INVALID_RESIZE_BTN_STATE);
      }
   }
}
