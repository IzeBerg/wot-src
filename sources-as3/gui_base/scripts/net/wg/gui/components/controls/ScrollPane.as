package net.wg.gui.components.controls
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.events.ScrollPaneEvent;
   import net.wg.gui.interfaces.IContentSize;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IScrollBar;
   
   public class ScrollPane extends UIComponentEx
   {
      
      private static const SCROLL_UPDATE_INV:String = "scrollUpdInv";
      
      private static const SCROLL_POSITION_INV:String = "scrollPosInv";
      
      private static const TARGET_INVALID_INV:String = "targetInv";
      
      private static const THUMB_INV:String = "thumbInv";
      
      private static const DISPLAY_OBJ_NAME_MASK:String = "maskObject";
      
      private static const DISPLAY_OBJ_NAME_BACKGROUND:String = "background";
       
      
      public var thumbOffset:Object = null;
      
      public var maskObject:MovieClip = null;
      
      public var background:Sprite = null;
      
      protected var _scrollBar:IScrollBar = null;
      
      protected var _scrollBarValue:Object = null;
      
      protected var _scrollPosition:Number = 0;
      
      protected var _scrollStepFactor:Number = 1.0;
      
      protected var _target:DisplayObject = null;
      
      protected var _autoScrollBar:Boolean = false;
      
      private var _showThumb:Boolean = false;
      
      private var _isScrollBarHaveToBeShown:Boolean = false;
      
      private var _scrollBarMargin:Number = 0;
      
      private var _scrollBarShiftHorizontal:Number = 0;
      
      private var _scrollBarShiftVertical:Number = 0;
      
      private var _isSmoothScroll:Boolean = true;
      
      private var _isTargetHorizontalCentered:Boolean = false;
      
      public function ScrollPane()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.maskObject == null)
         {
            this.maskObject = new MovieClip();
            this.maskObject.name = DISPLAY_OBJ_NAME_MASK;
            addChild(this.maskObject);
         }
         if(this.background == null)
         {
            this.background = new Sprite();
            this.background.name = DISPLAY_OBJ_NAME_BACKGROUND;
            addChildAt(this.background,0);
            this.background.addEventListener(MouseEvent.MOUSE_WHEEL,this.onTargetMouseWheelHandler,false,0,true);
         }
         mask = this.maskObject;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(TARGET_INVALID_INV))
         {
            this.applyTargetChanges();
         }
         if(isInvalid(InvalidationType.SCROLL_BAR))
         {
            this.createScrollBar();
            invalidate(SCROLL_POSITION_INV);
         }
         if(isInvalid(InvalidationType.SIZE,SCROLL_POSITION_INV))
         {
            this.drawScrollBar();
            this.drawMask();
            this.drawBackground();
            invalidate(SCROLL_UPDATE_INV);
         }
         if(isInvalid(SCROLL_UPDATE_INV))
         {
            this.applyScrollBarUpdating();
         }
         if(this.scrollBar && isInvalid(THUMB_INV))
         {
            if(!this._isScrollBarHaveToBeShown)
            {
               this.scrollBar.visible = this._showThumb;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.destroyScrollBar();
         this.thumbOffset = null;
         this._scrollBarValue = null;
         this.maskObject = null;
         if(this.background)
         {
            this.background.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onTargetMouseWheelHandler);
            this.background = null;
         }
         this.removeSource();
         if(this._target is IDisposable)
         {
            IDisposable(this._target).dispose();
         }
         this._target = null;
         super.onDispose();
      }
      
      public function doMouseWheel(param1:int) : void
      {
         if(!App.contextMenuMgr.isShown() && enabled)
         {
            this.scrollPosition -= param1 > 0 ? 1 : -1;
         }
      }
      
      public function getContentHeight() : Number
      {
         var _loc1_:IContentSize = null;
         if(this._target)
         {
            _loc1_ = this._target as IContentSize;
            if(_loc1_)
            {
               return _loc1_.contentHeight;
            }
            return this._target.height;
         }
         return 0;
      }
      
      protected function createScrollBar() : void
      {
         var _loc1_:IScrollBar = null;
         var _loc2_:Class = null;
         var _loc3_:Object = null;
         this.destroyScrollBar();
         if(!this._scrollBarValue)
         {
            return;
         }
         this._autoScrollBar = false;
         if(this._scrollBarValue is String)
         {
            if(parent != null)
            {
               _loc1_ = parent.getChildByName(this._scrollBarValue.toString()) as IScrollBar;
            }
            if(_loc1_ == null)
            {
               _loc2_ = App.utils.classFactory.getClass(this._scrollBarValue.toString());
               if(_loc2_)
               {
                  _loc1_ = IScrollBar(App.utils.classFactory.getComponent(this._scrollBarValue.toString(),IScrollBar));
               }
               if(_loc1_)
               {
                  this._autoScrollBar = true;
                  _loc3_ = _loc1_ as Object;
                  if(_loc3_ && this.thumbOffset)
                  {
                     _loc3_.offsetTop = this.thumbOffset.top;
                     _loc3_.offsetBottom = this.thumbOffset.bottom;
                  }
                  this.addChild(DisplayObject(_loc1_));
               }
            }
         }
         else if(this._scrollBarValue is Class)
         {
            _loc1_ = IScrollBar(new (this._scrollBarValue as Class)());
            if(_loc1_ != null)
            {
               this._autoScrollBar = true;
               Object(_loc1_).offsetTop = this.thumbOffset.top;
               Object(_loc1_).offsetBottom = this.thumbOffset.bottom;
               this.addChild(DisplayObject(_loc1_));
            }
         }
         else
         {
            _loc1_ = this._scrollBarValue as IScrollBar;
         }
         this._scrollBar = _loc1_;
         invalidateSize();
         if(_loc1_ != null)
         {
            _loc1_.addEventListener(Event.SCROLL,this.onScrollBarChangeHandler,false,0,true);
            _loc1_.addEventListener(Event.CHANGE,this.onScrollBarChangeHandler,false,0,true);
            _loc1_.focusTarget = this;
            _loc1_.tabEnabled = false;
            _loc1_.isSmooth = this._isSmoothScroll;
            _loc1_.enabled = enabled;
         }
      }
      
      protected function applyTargetChanges() : void
      {
         this.removeSource();
         if(this._target)
         {
            addChild(this._target);
            this._target.addEventListener(MouseEvent.MOUSE_WHEEL,this.onTargetMouseWheelHandler,false,0,true);
         }
      }
      
      protected function drawBackground() : void
      {
         var _loc1_:Graphics = this.background.graphics;
         _loc1_.clear();
         _loc1_.beginFill(0,0);
         _loc1_.drawRect(!!this._isTargetHorizontalCentered ? Number(-_width >> 1) : Number(0),0,_width + this._scrollBarShiftHorizontal,this.availableHeight);
         _loc1_.endFill();
      }
      
      protected function drawMask() : void
      {
         var _loc1_:Graphics = this.maskObject.graphics;
         _loc1_.clear();
         _loc1_.beginFill(16777215,1);
         _loc1_.drawRect(!!this._isTargetHorizontalCentered ? Number(-_width >> 1) : Number(0),0,_width + this._scrollBarShiftHorizontal,this.availableHeight);
         _loc1_.endFill();
      }
      
      protected function applyScrollBarUpdating() : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc1_:Number = this.scrollPageSize;
         var _loc2_:int = 0;
         var _loc3_:Number = this.maxScroll;
         this.scrollBar.setScrollProperties(_loc1_,_loc2_,_loc3_);
         var _loc4_:Number = (this.scrollBar.position - _loc2_) / (_loc3_ - _loc2_);
         this._showThumb = !(isNaN(_loc4_) || isNaN(_loc1_) || _loc3_ <= 0 || _loc3_ == Infinity);
         if(!this._showThumb)
         {
            this._scrollPosition = 0;
            dispatchEvent(new ScrollPaneEvent(ScrollPaneEvent.POSITION_CHANGED));
         }
         if(this._target && enabled)
         {
            _loc5_ = Math.max(this.getContentHeight() - _height,0);
            _loc6_ = this._scrollStepFactor * this._scrollPosition;
            _loc7_ = _loc5_ >= _loc6_ ? Number(_loc6_) : Number(_loc5_);
            if(!this._isSmoothScroll)
            {
               _loc7_ = Math.round(_loc7_);
            }
            this._target.y = -_loc7_;
         }
         invalidate(THUMB_INV);
         this.scrollBar.position = this._scrollPosition;
         this.scrollBar.trackScrollPageSize = _loc1_;
      }
      
      protected function drawScrollBar() : void
      {
         if(!this._autoScrollBar)
         {
            return;
         }
         this._scrollBar.x = _width - this._scrollBar.width - this.scrollBarMargin + this._scrollBarShiftHorizontal;
         this._scrollBar.y = this.scrollBarMargin + this._scrollBarShiftVertical;
         this._scrollBar.height = this.availableHeight - (this.scrollBarMargin << 1);
         this._scrollBar.validateNow();
      }
      
      private function destroyScrollBar() : void
      {
         var _loc1_:DisplayObject = null;
         if(this._scrollBar)
         {
            this._scrollBar.removeEventListener(Event.SCROLL,this.onScrollBarChangeHandler,false);
            this._scrollBar.removeEventListener(Event.CHANGE,this.onScrollBarChangeHandler,false);
            this._scrollBar.focusTarget = null;
            _loc1_ = DisplayObject(this._scrollBar);
            if(this.contains(_loc1_))
            {
               this._scrollBar.dispose();
               this.removeChild(_loc1_);
            }
            this._scrollBar = null;
         }
      }
      
      private function removeSource() : DisplayObject
      {
         var _loc1_:DisplayObjectContainer = null;
         if(this._target)
         {
            _loc1_ = this._target.parent;
            if(_loc1_)
            {
               _loc1_.removeChild(this._target);
            }
            this._target.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onTargetMouseWheelHandler);
         }
         return this._target;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         if(this.scrollBar)
         {
            this.scrollBar.enabled = param1;
         }
      }
      
      public function get isScrollBarHaveToBeShown() : Boolean
      {
         return this._isScrollBarHaveToBeShown;
      }
      
      public function set isScrollBarHaveToBeShown(param1:Boolean) : void
      {
         this._isScrollBarHaveToBeShown = param1;
         invalidate(THUMB_INV);
      }
      
      public function get scrollBarMargin() : Number
      {
         return this._scrollBarMargin;
      }
      
      [Inspectable(defaultValue="0",name="scrollBarMargin",type="Number",verbose="1")]
      public function set scrollBarMargin(param1:Number) : void
      {
         this._scrollBarMargin = param1;
      }
      
      public function get availableHeight() : Number
      {
         return Math.round(_height);
      }
      
      public function get target() : DisplayObject
      {
         return this._target;
      }
      
      public function set target(param1:DisplayObject) : void
      {
         this._target = param1;
         if(_invalidHash)
         {
            invalidate(TARGET_INVALID_INV);
         }
      }
      
      public function get scrollPageSize() : Number
      {
         return Math.round(_height / this._scrollStepFactor);
      }
      
      [Inspectable(type="String")]
      public function get scrollBar() : Object
      {
         return this._scrollBar;
      }
      
      public function set scrollBar(param1:Object) : void
      {
         this._scrollBarValue = param1;
         invalidate(InvalidationType.SCROLL_BAR);
      }
      
      [Inspectable(defaultValue="1.0",name="scrollStepFactor",type="Number",verbose="1")]
      public function get scrollStepFactor() : Number
      {
         return this._scrollStepFactor;
      }
      
      public function set scrollStepFactor(param1:Number) : void
      {
         this._scrollStepFactor = param1;
         invalidate(SCROLL_UPDATE_INV);
      }
      
      public function get scrollPosition() : Number
      {
         return this._scrollPosition;
      }
      
      public function set scrollPosition(param1:Number) : void
      {
         if(this._isSmoothScroll)
         {
            param1 = Math.max(0,Math.min(this.maxScroll,param1));
         }
         else
         {
            param1 = Math.max(0,Math.min(this.maxScroll,Math.round(param1)));
         }
         if(this._scrollPosition == param1)
         {
            return;
         }
         this._scrollPosition = param1;
         dispatchEvent(new ScrollPaneEvent(ScrollPaneEvent.POSITION_CHANGED));
         invalidate(SCROLL_UPDATE_INV);
      }
      
      public function get maxScroll() : Number
      {
         var _loc1_:Number = (this.getContentHeight() - _height) / this._scrollStepFactor;
         return !!this._isSmoothScroll ? Number(_loc1_) : Number(Math.ceil(_loc1_));
      }
      
      public function get scrollBarShiftHorizontal() : Number
      {
         return this._scrollBarShiftHorizontal;
      }
      
      public function set scrollBarShiftHorizontal(param1:Number) : void
      {
         this._scrollBarShiftHorizontal = param1;
      }
      
      public function get scrollBarShiftVertical() : Number
      {
         return this._scrollBarShiftVertical;
      }
      
      public function set scrollBarShiftVertical(param1:Number) : void
      {
         this._scrollBarShiftVertical = param1;
      }
      
      public function get isSmoothScroll() : Boolean
      {
         return this._isSmoothScroll;
      }
      
      public function set isSmoothScroll(param1:Boolean) : void
      {
         if(this._isSmoothScroll == param1)
         {
            return;
         }
         this._isSmoothScroll = param1;
         if(this._scrollBar)
         {
            this._scrollBar.isSmooth = this._isSmoothScroll;
         }
      }
      
      public function get isTargetHorizontalCentered() : Boolean
      {
         return this._isTargetHorizontalCentered;
      }
      
      public function set isTargetHorizontalCentered(param1:Boolean) : void
      {
         if(this._isTargetHorizontalCentered == param1)
         {
            return;
         }
         this._isTargetHorizontalCentered = param1;
      }
      
      private function onScrollBarChangeHandler(param1:Event) : void
      {
         this.scrollPosition = this._scrollBar.position;
      }
      
      private function onTargetMouseWheelHandler(param1:MouseEvent) : void
      {
         this.doMouseWheel(param1.delta);
      }
   }
}
