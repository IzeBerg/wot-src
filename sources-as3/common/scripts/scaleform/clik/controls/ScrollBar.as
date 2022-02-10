package scaleform.clik.controls
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.ScrollBarTrackMode;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.utils.Constraints;
   
   public class ScrollBar extends ScrollIndicator
   {
       
      
      public var trackScrollPageSize:Number = 1;
      
      protected var _dragOffset:Point;
      
      protected var _trackMode:String = "scrollPage";
      
      protected var _trackScrollPosition:Number = -1;
      
      protected var _trackDragMouseIndex:Number = -1;
      
      public var upArrow:Button;
      
      public var downArrow:Button;
      
      public function ScrollBar()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:Number = rotation;
         rotation = 0;
         if(this.downArrow)
         {
            constraints.addElement("downArrow",this.downArrow,Constraints.BOTTOM);
         }
         constraints.addElement("track",track,Constraints.TOP | Constraints.BOTTOM);
         rotation = _loc1_;
      }
      
      override protected function preInitialize() : void
      {
         constraints = new Constraints(this,ConstrainMode.REFLOW);
      }
      
      [Inspectable(defaultValue="true")]
      override public function get enabled() : Boolean
      {
         return super.enabled;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(this.enabled == param1)
         {
            return;
         }
         super.enabled = param1;
         gotoAndPlay(!!this.enabled ? "default" : "disabled");
         invalidate(InvalidationType.STATE);
      }
      
      override public function get position() : Number
      {
         return _position;
      }
      
      override public function set position(param1:Number) : void
      {
         if(!isSmooth)
         {
            param1 = Math.round(param1);
         }
         if(param1 == this.position)
         {
            return;
         }
         super.position = param1;
         this.updateScrollTarget();
      }
      
      [Inspectable(defaultValue="scrollPage",type="String",enumeration="scrollPage,scrollToCursor")]
      public function get trackMode() : String
      {
         return this._trackMode;
      }
      
      public function set trackMode(param1:String) : void
      {
         if(param1 == this._trackMode)
         {
            return;
         }
         this._trackMode = param1;
         if(initialized)
         {
            track.autoRepeat = this.trackMode == ScrollBarTrackMode.SCROLL_PAGE;
         }
      }
      
      override public function get availableHeight() : Number
      {
         return track.height - thumb.height + offsetBottom + offsetTop;
      }
      
      override public function toString() : String
      {
         return "[CLIK ScrollBar " + name + "]";
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = mouseChildren = this.enabled;
         tabEnabled = tabChildren = _focusable;
         addEventListener(MouseEvent.MOUSE_WHEEL,this.handleMouseWheel,false,0,true);
         addEventListener(InputEvent.INPUT,handleInput,false,0,true);
         if(this.upArrow)
         {
            this.upArrow.addEventListener(ButtonEvent.CLICK,this.handleUpArrowClick,false,0,true);
            this.upArrow.addEventListener(ButtonEvent.PRESS,this.handleUpArrowPress,false,0,true);
            this.upArrow.focusTarget = this;
            this.upArrow.autoRepeat = true;
         }
         if(this.downArrow)
         {
            this.downArrow.addEventListener(ButtonEvent.CLICK,this.handleDownArrowClick,false,0,true);
            this.downArrow.addEventListener(ButtonEvent.PRESS,this.handleDownArrowPress,false,0,true);
            this.downArrow.focusTarget = this;
            this.downArrow.autoRepeat = true;
         }
         thumb.addEventListener(MouseEvent.MOUSE_DOWN,this.handleThumbPress,false,0,true);
         thumb.focusTarget = this;
         thumb.lockDragStateChange = true;
         track.addEventListener(MouseEvent.MOUSE_DOWN,this.handleTrackPress,false,0,true);
         track.addEventListener(ButtonEvent.CLICK,this.handleTrackClick,false,0,true);
         if(track is UIComponent)
         {
            (track as UIComponent).focusTarget = this;
         }
         track.autoRepeat = this.trackMode == ScrollBarTrackMode.SCROLL_PAGE;
      }
      
      protected function scrollUp() : void
      {
         this.position -= _pageScrollSize;
      }
      
      protected function scrollDown() : void
      {
         this.position += _pageScrollSize;
      }
      
      override protected function drawLayout() : void
      {
         var _loc1_:Number = NaN;
         thumb.y = track.y - offsetTop;
         if(isHorizontal)
         {
            constraints.update(_height,_width);
         }
         else
         {
            constraints.update(_width,_height);
         }
         if(isHorizontal && actualWidth != width)
         {
            _loc1_ = width / actualWidth;
            scaleY = _loc1_;
         }
      }
      
      override protected function updateThumb() : void
      {
         var _loc1_:Number = Math.max(1,_maxPosition - _minPosition + _pageSize);
         var _loc2_:Number = track.height + offsetTop + offsetBottom;
         thumb.height = Math.max(_minThumbSize,Math.min(_loc2_,_pageSize / _loc1_ * _loc2_)) ^ 0;
         if(thumb is UIComponent)
         {
            (thumb as UIComponent).validateNow();
         }
         this.updateThumbPosition();
      }
      
      override protected function updateThumbPosition() : void
      {
         var _loc1_:Number = (_position - _minPosition) / (_maxPosition - _minPosition);
         var _loc2_:Number = track.y - offsetTop;
         var _loc3_:Number = _loc1_ * this.availableHeight + _loc2_;
         if(!isSmooth)
         {
            _loc3_ = Math.round(_loc3_);
         }
         thumb.y = Math.max(_loc2_,Math.min(Math.round(track.y + track.height - thumb.height + offsetBottom),_loc3_));
         thumb.visible = !(isNaN(_loc1_) || isNaN(_pageSize) || _maxPosition <= 0 || _maxPosition == Infinity);
         var _loc4_:Boolean = thumb.visible && this.enabled;
         if(this.upArrow)
         {
            this.upArrow.enabled = _loc4_ && _position > _minPosition;
            this.upArrow.validateNow();
         }
         if(this.downArrow)
         {
            this.downArrow.enabled = _loc4_ && _position < _maxPosition;
            this.downArrow.validateNow();
         }
         track.enabled = track.mouseEnabled = _loc4_;
      }
      
      protected function handleUpArrowClick(param1:ButtonEvent) : void
      {
         if(param1.isRepeat)
         {
            this.scrollUp();
         }
      }
      
      protected function handleUpArrowPress(param1:ButtonEvent) : void
      {
         this.scrollUp();
      }
      
      protected function handleDownArrowClick(param1:ButtonEvent) : void
      {
         if(param1.isRepeat)
         {
            this.scrollDown();
         }
      }
      
      protected function handleDownArrowPress(param1:ButtonEvent) : void
      {
         this.scrollDown();
      }
      
      protected function handleThumbPress(param1:Event) : void
      {
         if(_isDragging)
         {
            return;
         }
         _isDragging = true;
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.doDrag,false,0,true);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.endDrag,false,0,true);
         this._dragOffset = new Point(0,mouseY - thumb.y);
      }
      
      protected function doDrag(param1:MouseEvent) : void
      {
         var _loc2_:Number = (mouseY - this._dragOffset.y - track.y) / this.availableHeight;
         this.position = _minPosition + _loc2_ * (_maxPosition - _minPosition);
      }
      
      protected function endDrag(param1:MouseEvent) : void
      {
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.doDrag);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.endDrag);
         _isDragging = false;
      }
      
      protected function handleTrackPress(param1:MouseEvent) : void
      {
         var _loc2_:Number = NaN;
         if(param1.shiftKey || this.trackMode == ScrollBarTrackMode.SCROLL_TO_CURSOR)
         {
            _loc2_ = (mouseY - thumb.height / 2 - track.y) / this.availableHeight;
            this.position = Math.round(_loc2_ * (_maxPosition - _minPosition) + _minPosition);
            thumb.dispatchEventAndSound(new MouseEvent(MouseEvent.MOUSE_OVER));
            thumb.dispatchEventAndSound(new MouseEvent(MouseEvent.MOUSE_DOWN));
            this.handleThumbPress(param1);
            this._dragOffset = new Point(0,thumb.height / 2);
         }
         if(_isDragging || this.position == this._trackScrollPosition)
         {
            return;
         }
         if(mouseY > thumb.y && mouseY < thumb.y + thumb.height)
         {
            return;
         }
         this.position += thumb.y < mouseY ? this.trackScrollPageSize : -this.trackScrollPageSize;
      }
      
      protected function handleTrackClick(param1:ButtonEvent) : void
      {
         if(param1.isRepeat)
         {
            if(_isDragging || this.position == this._trackScrollPosition)
            {
               return;
            }
            if(mouseY > thumb.y && mouseY < thumb.y + thumb.height)
            {
               return;
            }
            this.position += thumb.y < mouseY ? this.trackScrollPageSize : -this.trackScrollPageSize;
         }
      }
      
      protected function updateScrollTarget() : void
      {
         if(_scrollTarget == null || !this.enabled)
         {
            return;
         }
         var _loc1_:TextField = _scrollTarget as TextField;
         if(_loc1_ != null)
         {
            _scrollTarget.scrollV = Math.round(_position);
         }
      }
      
      protected function handleMouseWheel(param1:MouseEvent) : void
      {
         this.position -= (param1.delta > 0 ? 1 : -1) * _pageScrollSize;
      }
      
      override protected function changeFocus() : void
      {
         thumb.displayFocus = _focused || _displayFocus;
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_WHEEL,this.handleMouseWheel,false);
         removeEventListener(InputEvent.INPUT,handleInput,false);
         if(this.upArrow)
         {
            this.upArrow.removeEventListener(ButtonEvent.CLICK,this.handleUpArrowClick,false);
            this.upArrow.removeEventListener(ButtonEvent.PRESS,this.handleUpArrowPress,false);
            this.upArrow.focusTarget = null;
            this.upArrow.dispose();
         }
         this.upArrow = null;
         if(this.downArrow)
         {
            this.downArrow.removeEventListener(ButtonEvent.CLICK,this.handleDownArrowClick,false);
            this.downArrow.removeEventListener(ButtonEvent.PRESS,this.handleDownArrowPress,false);
            this.downArrow.focusTarget = null;
            this.downArrow.dispose();
         }
         this.downArrow = null;
         if(thumb)
         {
            thumb.removeEventListener(MouseEvent.MOUSE_DOWN,this.handleThumbPress,false);
            if(thumb is UIComponent)
            {
               UIComponent(thumb).focusTarget = null;
               UIComponent(thumb).dispose();
            }
         }
         thumb = null;
         if(track)
         {
            track.removeEventListener(MouseEvent.MOUSE_DOWN,this.handleTrackPress,false);
            track.removeEventListener(ButtonEvent.CLICK,this.handleTrackClick,false);
            if(track is UIComponent)
            {
               (track as UIComponent).focusTarget = null;
               (track as UIComponent).dispose();
            }
         }
         track = null;
         this._dragOffset = null;
         super.onDispose();
      }
   }
}
