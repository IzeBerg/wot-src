package net.wg.gui.battle.views.minimap.components.entries.personal
{
   import fl.transitions.easing.Strong;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.views.minimap.events.MinimapEvent;
   import net.wg.gui.utils.GraphicsUtilities;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class DistanceDrawer extends Sprite implements IDisposable
   {
      
      private static const VALID_DISTANCE_DIFF:int = 5;
      
      private static const ANIM_MAX_PX_STEP:int = 2;
      
      private static const ANIM_DURATION:int = 500;
      
      private static const MIN_ANIM_DELAY:int = 25;
      
      public static const MAX_STEPS_COUNT:int = ANIM_DURATION / MIN_ANIM_DELAY;
      
      private static const DISTANCE_SCALE_KOEF:Number = 0.36;
      
      private static const DISTANCE_SCALE_KOEF_STEP:Number = 0.03;
      
      private static const LINE_STYLE_THICKNESS:Number = 1;
      
      private static const LINE_STYLE_COLOR:int = 12490551;
      
      private static const LINE_DASH_LENGTH:Number = 10;
      
      private static const LINE_HYPHEN_LENGTH:Number = 2;
      
      private static const SECTOR_RADIUS:Number = 50;
      
      private static const SECTOR_LENGTH:Number = 14;
      
      private static const DIRECTION_LINE_ALPHA:Number = 0.5;
      
      private static const DIRECTION_LINE_LENGTH:int = 400;
      
      private static const DEFAULT_MAP_SIZE:int = 620;
       
      
      private var _disposed:Boolean = false;
      
      private var _direction:Sprite = null;
      
      private var _distanceNormal:Sprite = null;
      
      private var _animLineTimer:Timer = null;
      
      private var _startTime:int = 0;
      
      private var _startPosition:int = 0;
      
      private var _currentPosition:int = 0;
      
      private var _endPosition:int = 0;
      
      private var _distanceScaleKoef:Number = 0;
      
      private var _mapSizeKoef:Number = 1;
      
      public function DistanceDrawer()
      {
         super();
         this.init();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this._direction = null;
         this._distanceNormal = null;
         if(this._animLineTimer)
         {
            this._animLineTimer.stop();
            this._animLineTimer.removeEventListener(TimerEvent.TIMER,this.onTimerStep);
         }
         this._animLineTimer = null;
         App.stage.removeEventListener(MinimapEvent.SIZE_CHANGED,this.onMinimapSizeChanged);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function updateDistance(param1:Number) : void
      {
         if(Math.abs(param1 - this._endPosition) < VALID_DISTANCE_DIFF)
         {
            return;
         }
         this._startPosition = this._currentPosition;
         this._startTime = getTimer();
         this._endPosition = Math.round(param1);
         var _loc2_:int = Math.abs(this._endPosition - this._startPosition) / ANIM_MAX_PX_STEP;
         this.updateAnimLineDistance();
         this._animLineTimer.reset();
         if(_loc2_ > 1)
         {
            _loc2_ = Math.min(_loc2_,MAX_STEPS_COUNT) - 1;
            this._animLineTimer.repeatCount = _loc2_;
            this._animLineTimer.delay = Math.max(MIN_ANIM_DELAY,ANIM_DURATION / _loc2_);
            this._animLineTimer.start();
         }
      }
      
      public function updateEntryScaleFactor(param1:int, param2:int = -1) : void
      {
         this._distanceScaleKoef = DISTANCE_SCALE_KOEF + DISTANCE_SCALE_KOEF_STEP * param1;
         if(param2 != Values.DEFAULT_INT)
         {
            this._mapSizeKoef = DEFAULT_MAP_SIZE / param2;
         }
         this.updateAnimLineDistance();
      }
      
      private function init() : void
      {
         this._direction = new Sprite();
         this._direction.alpha = DIRECTION_LINE_ALPHA;
         addChild(this._direction);
         this._distanceNormal = new Sprite();
         addChild(this._distanceNormal);
         var _loc1_:Graphics = this._distanceNormal.graphics;
         _loc1_.lineStyle(LINE_STYLE_THICKNESS,LINE_STYLE_COLOR);
         var _loc2_:Number = SECTOR_LENGTH / SECTOR_RADIUS;
         GraphicsUtilities.drawArc(_loc1_,0,SECTOR_RADIUS,Math.PI / 2 - _loc2_ / 2,_loc2_,SECTOR_RADIUS);
         this.drawStraightDashedLine(this._direction.graphics,0,DIRECTION_LINE_LENGTH);
         this._animLineTimer = new Timer(MIN_ANIM_DELAY);
         this._animLineTimer.addEventListener(TimerEvent.TIMER,this.onTimerStep);
         App.stage.addEventListener(MinimapEvent.SIZE_CHANGED,this.onMinimapSizeChanged);
      }
      
      private function updateAnimLineDistance() : void
      {
         var _loc1_:Number = Math.min((getTimer() - this._startTime) / ANIM_DURATION,1);
         this._currentPosition = this._startPosition + (this._endPosition - this._startPosition) * Strong.easeOut(_loc1_,0,1,1);
         var _loc2_:Number = this._currentPosition * this._distanceScaleKoef * this._mapSizeKoef;
         this.drawStraightDashedLine(graphics,0,_loc2_);
         this._distanceNormal.y = -_loc2_;
      }
      
      private function drawStraightDashedLine(param1:Graphics, param2:int, param3:int) : void
      {
         param1.clear();
         param1.lineStyle(LINE_STYLE_THICKNESS,LINE_STYLE_COLOR);
         param1.moveTo(0,param2);
         var _loc4_:Number = param3 / (LINE_DASH_LENGTH + LINE_HYPHEN_LENGTH);
         var _loc5_:Number = 0;
         while(_loc4_ > 0)
         {
            if(_loc4_ > 1)
            {
               _loc5_ -= LINE_DASH_LENGTH;
            }
            else
            {
               _loc5_ = -param3;
            }
            param1.lineTo(0,_loc5_);
            _loc5_ -= LINE_HYPHEN_LENGTH;
            param1.moveTo(x,_loc5_);
            _loc4_--;
         }
      }
      
      private function onTimerStep(param1:TimerEvent) : void
      {
         this.updateAnimLineDistance();
      }
      
      private function onMinimapSizeChanged(param1:MinimapEvent) : void
      {
         this.updateEntryScaleFactor(param1.sizeIndex);
      }
   }
}
