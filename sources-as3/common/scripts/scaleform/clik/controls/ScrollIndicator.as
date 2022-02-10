package scaleform.clik.controls
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.constants.ScrollBarDirection;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.interfaces.IScrollBar;
   import scaleform.clik.ui.InputDetails;
   
   [Event(name="scroll",type="flash.events.Event")]
   public class ScrollIndicator extends UIComponent implements IScrollBar
   {
       
      
      public var direction:String = "vertical";
      
      [Inspectable(defaultValue="0")]
      public var offsetTop:Number = 0;
      
      [Inspectable(defaultValue="0")]
      public var offsetBottom:Number = 0;
      
      protected var _isDragging:Boolean = false;
      
      protected var _maxPosition:Number = 10;
      
      protected var _minPosition:Number = 0;
      
      protected var _minThumbSize:Number = 10;
      
      protected var _pageScrollSize:Number = 1;
      
      protected var _pageSize:Number;
      
      protected var _position:Number = 5;
      
      protected var _scrollTarget:Object;
      
      private var _isSmooth:Boolean = false;
      
      public var thumb:MovieClip;
      
      public var track:MovieClip;
      
      public function ScrollIndicator()
      {
         super();
      }
      
      [Inspectable(defaultValue="true")]
      override public function get enabled() : Boolean
      {
         return super.enabled;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 == super.enabled)
         {
            return;
         }
         super.enabled = param1;
         gotoAndPlay(!!this.enabled ? "default" : "disabled");
      }
      
      public function get position() : Number
      {
         return this._position;
      }
      
      public function set position(param1:Number) : void
      {
         param1 = Math.max(this._minPosition,Math.min(this._maxPosition,param1));
         if(param1 == this._position)
         {
            return;
         }
         this._position = param1;
         dispatchEventAndSound(new Event(Event.SCROLL));
         invalidateData();
      }
      
      [Inspectable(defaultValue="10",type="Number")]
      public function get minThumbSize() : Number
      {
         return this._minThumbSize;
      }
      
      public function set minThumbSize(param1:Number) : void
      {
         param1 = Math.max(1,param1);
         this._minThumbSize = param1;
         invalidateSize();
      }
      
      public function get isHorizontal() : Boolean
      {
         return this.direction == ScrollBarDirection.HORIZONTAL;
      }
      
      [Inspectable(defaultValue="",type="String")]
      public function get scrollTarget() : Object
      {
         return this._scrollTarget;
      }
      
      public function set scrollTarget(param1:Object) : void
      {
         if(param1 is String)
         {
            if(!componentInspectorSetting || param1.toString() == "" || parent == null)
            {
               return;
            }
            param1 = parent.getChildByName(param1.toString());
            if(param1 == null)
            {
               return;
            }
         }
         var _loc2_:Object = this._scrollTarget;
         this._scrollTarget = param1;
         if(_loc2_ != null)
         {
            _loc2_.removeEventListener(Event.SCROLL,this.handleTargetScroll,false);
            if(_loc2_.scrollBar != null)
            {
               _loc2_.scrollBar = null;
            }
         }
         if(param1 is UIComponent && "scrollBar" in param1)
         {
            param1.scrollBar = this;
            return;
         }
         if(this._scrollTarget == null)
         {
            tabEnabled = true;
            return;
         }
         this._scrollTarget.addEventListener(Event.SCROLL,this.handleTargetScroll,false,0,true);
         if(this._scrollTarget is UIComponent)
         {
            focusTarget = this._scrollTarget as UIComponent;
         }
         tabEnabled = false;
         this.handleTargetScroll(null);
         invalidate();
      }
      
      public function get availableHeight() : Number
      {
         var _loc1_:Number = !!isNaN(this.thumb.height) ? Number(0) : Number(this.thumb.height);
         return (!!this.isHorizontal ? _width : _height) - _loc1_ + this.offsetBottom + this.offsetTop;
      }
      
      public function setScrollProperties(param1:Number, param2:Number, param3:Number, param4:Number = NaN) : void
      {
         this._pageSize = param1;
         if(!isNaN(param4))
         {
            this._pageScrollSize = param4;
         }
         this._minPosition = param2;
         this._maxPosition = param3;
         invalidateSize();
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.value == InputValue.KEY_UP)
         {
            return;
         }
         var _loc3_:Boolean = this.direction == ScrollBarDirection.HORIZONTAL;
         switch(_loc2_.navEquivalent)
         {
            case NavigationCode.UP:
               if(_loc3_)
               {
                  return;
               }
               this.position -= 1;
               break;
            case NavigationCode.DOWN:
               if(_loc3_)
               {
                  return;
               }
               this.position += 1;
               break;
            case NavigationCode.LEFT:
               if(!_loc3_)
               {
                  return;
               }
               this.position -= 1;
               break;
            case NavigationCode.RIGHT:
               if(!_loc3_)
               {
                  return;
               }
               this.position += 1;
               break;
            case NavigationCode.HOME:
               this.position = 0;
               break;
            case NavigationCode.END:
               this.position = this._maxPosition;
               break;
            default:
               return;
         }
         param1.handled = true;
      }
      
      override public function toString() : String
      {
         return "[CLIK ScrollIndicator " + name + "]";
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         focusable = false;
         mouseChildren = mouseEnabled = false;
         if(this.track == null)
         {
            this.track = new MovieClip();
         }
         this.thumb.enabled = this.enabled;
         initSize();
         this.direction = rotation != 0 && rotation != 180 ? ScrollBarDirection.HORIZONTAL : ScrollBarDirection.VERTICAL;
      }
      
      override protected function draw() : void
      {
         var _loc1_:TextField = null;
         if(isInvalid(InvalidationType.SIZE))
         {
            setActualSize(_width,_height);
            this.drawLayout();
            this.updateThumb();
         }
         else if(isInvalid(InvalidationType.DATA))
         {
            if(this._scrollTarget is TextField)
            {
               _loc1_ = this._scrollTarget as TextField;
               this.setScrollProperties(_loc1_.bottomScrollV - _loc1_.scrollV,1,_loc1_.maxScrollV);
            }
            this.updateThumbPosition();
         }
      }
      
      protected function drawLayout() : void
      {
         this.track.height = !!this.isHorizontal ? Number(_width) : Number(_height);
         if(this.track is UIComponent)
         {
            this.track.validateNow();
         }
      }
      
      protected function updateThumb() : void
      {
         var _loc1_:Number = Math.max(1,this._maxPosition - this._minPosition + this._pageSize);
         var _loc2_:Number = (!!this.isHorizontal ? _width : _height) + this.offsetTop + this.offsetBottom;
         this.thumb.height = Math.max(this._minThumbSize,Math.min(_height,this._pageSize / _loc1_ * _loc2_));
         if(this.thumb is UIComponent)
         {
            (this.thumb as UIComponent).validateNow();
         }
         this.updateThumbPosition();
      }
      
      protected function updateThumbPosition() : void
      {
         var _loc1_:Number = (this._position - this._minPosition) / (this._maxPosition - this._minPosition);
         if(isNaN(_loc1_))
         {
            _loc1_ = 0;
         }
         var _loc2_:Number = _loc1_ * this.availableHeight;
         this.thumb.y = Math.max(-this.offsetTop,Math.min(this.availableHeight - this.offsetTop,_loc2_));
         this.thumb.visible = !(this._maxPosition == this._minPosition || isNaN(this._pageSize) || this._maxPosition == 0);
      }
      
      protected function handleTargetScroll(param1:Event) : void
      {
         if(this._isDragging)
         {
            return;
         }
         var _loc2_:TextField = this._scrollTarget as TextField;
         if(_loc2_ != null)
         {
            this.setScrollProperties(_loc2_.bottomScrollV - _loc2_.scrollV,1,_loc2_.maxScrollV);
            this.position = _loc2_.scrollV;
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._scrollTarget)
         {
            this._scrollTarget.removeEventListener(Event.SCROLL,this.handleTargetScroll,false);
            this._scrollTarget = null;
         }
         if(this.thumb && this.thumb is IDisposable)
         {
            IDisposable(this.thumb).dispose();
         }
         this.thumb = null;
         if(this.track && this.track is IDisposable)
         {
            IDisposable(this.track).dispose();
         }
         this.track = null;
         super.onDispose();
      }
      
      public function get isSmooth() : Boolean
      {
         return this._isSmooth;
      }
      
      public function set isSmooth(param1:Boolean) : void
      {
         if(this._isSmooth == param1)
         {
            return;
         }
         this._isSmooth = param1;
      }
   }
}
