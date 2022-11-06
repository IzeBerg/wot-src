package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Slider;
   import scaleform.clik.events.SliderEvent;
   import scaleform.clik.utils.Padding;
   
   [InspectableList("enableInitCallback")]
   public class Slider extends scaleform.clik.controls.Slider
   {
       
      
      private var progress_mask:MovieClip;
      
      protected var _undefined:Boolean = false;
      
      public var hitMc:MovieClip = null;
      
      public var patternMc:BitmapFill = null;
      
      public var disablePatternMc:BitmapFill = null;
      
      private var _fillPadding:Padding;
      
      private var _maxAvailableValue:Number = NaN;
      
      public function Slider()
      {
         this._fillPadding = new Padding(3,6,3,2);
         super();
         offsetLeft = 3;
         offsetRight = 4;
         if(track && track["bg"] && track["bg"]["patternMc"])
         {
            this.patternMc = track["bg"]["patternMc"];
         }
         if(track && track["bg"] && track["bg"]["disablePatternMc"])
         {
            this.disablePatternMc = track["bg"]["disablePatternMc"];
         }
         if(track && track["hitMc"])
         {
            this.hitMc = track["hitMc"];
         }
         buttonMode = true;
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_WHEEL,this.onScrollWheel,false);
         this.progress_mask = null;
         if(this.patternMc)
         {
            this.patternMc.dispose();
            this.patternMc = null;
         }
         if(this.disablePatternMc)
         {
            this.disablePatternMc.dispose();
            this.disablePatternMc = null;
         }
         super.onDispose();
      }
      
      override protected function scrollWheel(param1:Number) : void
      {
         if(!this.enabled)
         {
            return;
         }
         this.value = value + _snapInterval * (param1 > 0 ? 1 : -1);
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         track["progress_mask"].gotoAndStop(0);
         addEventListener(MouseEvent.MOUSE_WHEEL,this.onScrollWheel,false,0,true);
      }
      
      override protected function beginDrag(param1:MouseEvent) : void
      {
         if(App.utils.commons.isLeftButton(param1))
         {
            super.beginDrag(param1);
         }
      }
      
      override protected function trackPress(param1:MouseEvent) : void
      {
         if(App.utils.commons.isLeftButton(param1))
         {
            super.trackPress(param1);
         }
      }
      
      protected function onScrollWheel(param1:MouseEvent) : void
      {
         this.scrollWheel(param1.delta);
         param1.stopPropagation();
      }
      
      override protected function draw() : void
      {
         super.draw();
         this.updatePatterns();
      }
      
      [Inspectable(defaultValue="false",type="Boolean")]
      public function get undefinedDisabled() : Boolean
      {
         return this._undefined;
      }
      
      public function set undefinedDisabled(param1:Boolean) : void
      {
         if(this._undefined == param1)
         {
            return;
         }
         this._undefined = param1;
         super.enabled = !param1;
         thumb.enabled = track.enabled = !param1;
         thumb.visible = !this._undefined;
         track["progress_mask"].gotoAndStop(0);
         invalidate(InvalidationType.STATE);
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
         thumb.visible = param1;
         if(!initialized)
         {
            return;
         }
         invalidate(InvalidationType.STATE);
      }
      
      override public function set value(param1:Number) : void
      {
         _value = this.lockValue(param1);
         dispatchEvent(new SliderEvent(SliderEvent.VALUE_CHANGE,false,true,_value));
         this.updateThumb();
      }
      
      public function get maxAvailableValue() : Number
      {
         return this._maxAvailableValue;
      }
      
      public function set maxAvailableValue(param1:Number) : void
      {
         if(isNaN(this._maxAvailableValue) && isNaN(param1) || param1 == this._maxAvailableValue)
         {
            return;
         }
         this._maxAvailableValue = param1;
         if(!isNaN(this._maxAvailableValue) && value > this._maxAvailableValue)
         {
            this.value = this._maxAvailableValue;
         }
         invalidate();
      }
      
      override protected function doDrag(param1:MouseEvent) : void
      {
         var _loc2_:Point = globalToLocal(new Point(param1.stageX,param1.stageY));
         var _loc3_:Number = _loc2_.x - _dragOffset.x;
         var _loc4_:Number = track.width - offsetLeft - offsetRight;
         var _loc5_:Number = this.lockValue((_loc3_ - offsetLeft) / _loc4_ * (_maximum - _minimum) + _minimum);
         if(value == _loc5_)
         {
            return;
         }
         _value = _loc5_;
         this.updateThumb();
         if(liveDragging)
         {
            dispatchEvent(new SliderEvent(SliderEvent.VALUE_CHANGE,false,true,_value));
         }
      }
      
      override protected function updateThumb() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = track.width - offsetLeft - offsetRight;
         thumb.x = (_value - _minimum) / (_maximum - _minimum) * _loc1_ - thumb.width / 2 + offsetLeft ^ 0;
         if(!this.enabled)
         {
            track["progress_mask"].gotoAndStop(0);
            return;
         }
         if(!this._undefined)
         {
            _loc2_ = (position - _minimum) / (_maximum - _minimum);
            track["progress_mask"].gotoAndStop(Math.round(_loc2_ * track["progress_mask"].totalFrames));
         }
         else
         {
            track["progress_mask"].gotoAndStop(0);
         }
      }
      
      override protected function lockValue(param1:Number) : Number
      {
         var _loc2_:Number = NaN;
         if(!isNaN(this._maxAvailableValue))
         {
            _loc2_ = super.lockValue(Math.min(param1,this._maxAvailableValue));
         }
         else
         {
            _loc2_ = super.lockValue(param1);
         }
         return _loc2_;
      }
      
      protected function updatePatterns() : void
      {
         if(!this.patternMc && !this.disablePatternMc)
         {
            return;
         }
         var _loc1_:Number = this.hitMc.width;
         var _loc2_:Number = Math.abs(_maximum - _minimum);
         var _loc3_:Number = _loc1_;
         if(!isNaN(this._maxAvailableValue))
         {
            _loc3_ = _loc1_ * Math.abs(this._maxAvailableValue - _minimum) / _loc2_;
         }
         if(this.patternMc)
         {
            this.patternMc.x = this._fillPadding.left;
            this.patternMc.y = this._fillPadding.top;
            this.patternMc.setActualScale(1 / this.track.actualScaleX,1 / this.track.actualScaleY);
            this.patternMc.widthFill = Math.round(_loc3_ * this.track.actualScaleX);
            this.patternMc.heightFill = Math.round(this.hitMc.height * this.track.actualScaleY);
         }
         if(this.disablePatternMc)
         {
            if(isNaN(this._maxAvailableValue))
            {
               this.disablePatternMc.visible = false;
            }
            else
            {
               this.disablePatternMc.x = this._fillPadding.left + _loc3_;
               this.disablePatternMc.y = this._fillPadding.top;
               this.disablePatternMc.setActualScale(1 / this.track.actualScaleX,1 / this.track.actualScaleY);
               this.disablePatternMc.widthFill = Math.round((_loc1_ - _loc3_) * this.track.actualScaleX);
               this.disablePatternMc.heightFill = Math.round(this.hitMc.height * this.track.actualScaleY);
               this.disablePatternMc.visible = true;
            }
         }
      }
   }
}
