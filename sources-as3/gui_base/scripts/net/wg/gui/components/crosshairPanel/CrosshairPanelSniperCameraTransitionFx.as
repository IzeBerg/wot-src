package net.wg.gui.components.crosshairPanel
{
   import fl.motion.easing.Linear;
   import fl.motion.easing.Quartic;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.geom.ColorTransform;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CrosshairPanelSniperCameraTransitionFx implements IDisposable
   {
      
      private static const SNIPER_VIEW_ID:int = 2;
      
      private static const ACTIVE_GUN_ID_RIGHT:int = 1;
      
      private static const DIRECTION_LEFT:int = -1;
      
      private static const DIRECTION_RIGHT:int = 1;
      
      private static const RED_COLOR_OFFSET_MULTIPLIER:int = 60;
      
      private static const GREEN_COLOR_OFFSET_MULTIPLIER:int = 48;
      
      private static const BLUE_COLOR_OFFSET_MULTIPLIER:int = 48;
      
      private static const CROSSHAIR_X_OFFSET:int = 80;
      
      private static const FADE_IN_START:Number = 0;
      
      private static const FADE_IN_END:Number = 0.5;
      
      private static const FADE_OUT_START:Number = 0.5;
      
      private static const FADE_OUT_END:Number = 1;
      
      private static const COLOR_TRANSFORM_START:Number = 0.5;
      
      private static const COLOR_TRANSFORM_MIDDLE:Number = 0.6;
      
      private static const COLOR_TRANSFORM_END:Number = 2;
      
      private static const ANIMATION_COMPLETE_TIME_RATIO:Number = COLOR_TRANSFORM_END;
      
      private static const UPDATE_INTERVAL:Number = 1000 / 60;
       
      
      private var _crosshair:DisplayObject;
      
      private var _direction:int;
      
      private var _startTime:Number;
      
      private var _duration:Number;
      
      private var _startPositionX:Number;
      
      private var _timer:Timer;
      
      private var _disposed:Boolean = false;
      
      public function CrosshairPanelSniperCameraTransitionFx()
      {
         super();
         this._timer = new Timer(UPDATE_INTERVAL);
         this._timer.addEventListener(TimerEvent.TIMER,this.update);
      }
      
      private static function calcStepProgress(param1:Number, param2:Number, param3:Number, param4:Function) : Number
      {
         var _loc5_:Number = NaN;
         _loc5_ = Math.max(param2,Math.min(param1,param3));
         var _loc6_:Number = (_loc5_ - param2) / (param3 - param2);
         return param4(_loc6_,0,1,1);
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this._timer.removeEventListener(TimerEvent.TIMER,this.update);
         this._timer = null;
         this._crosshair = null;
      }
      
      public function setActiveGunId(param1:int) : void
      {
         this._direction = param1 == ACTIVE_GUN_ID_RIGHT ? int(DIRECTION_LEFT) : int(DIRECTION_RIGHT);
      }
      
      public function setCameraTransitionDuration(param1:Number) : void
      {
         this._duration = param1;
      }
      
      public function setView(param1:int, param2:ICrosshair) : void
      {
         if(param1 != SNIPER_VIEW_ID)
         {
            this.resetAnimation();
            return;
         }
         this._crosshair = param2 as DisplayObject;
      }
      
      public function start() : void
      {
         if(this._timer.running)
         {
            this.resetAnimation();
         }
         this._startTime = getTimer();
         this._startPositionX = this._crosshair.x;
         this._timer.start();
      }
      
      private function resetAnimation() : void
      {
         if(this._crosshair)
         {
            this._crosshair.x = this._startPositionX;
            this._crosshair.transform.colorTransform = new ColorTransform();
         }
         this._timer.reset();
      }
      
      private function updatePosition(param1:Number) : void
      {
         var _loc2_:Number = calcStepProgress(param1,FADE_IN_START,FADE_IN_END,Quartic.easeIn);
         var _loc3_:Number = calcStepProgress(param1,FADE_OUT_START,FADE_OUT_END,Quartic.easeOut);
         var _loc4_:Number = CROSSHAIR_X_OFFSET * (_loc2_ + _loc3_);
         if(_loc3_ > 0)
         {
            _loc4_ -= 2 * CROSSHAIR_X_OFFSET;
         }
         this._crosshair.x = this._startPositionX + this._direction * _loc4_;
      }
      
      private function updateColorTransform(param1:Number) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:Number = calcStepProgress(param1,FADE_IN_START,FADE_IN_END,Quartic.easeIn);
         var _loc3_:Number = calcStepProgress(param1,FADE_OUT_START,FADE_OUT_END,Quartic.easeOut);
         _loc4_ = calcStepProgress(param1,COLOR_TRANSFORM_START,COLOR_TRANSFORM_MIDDLE,Linear.easeNone);
         _loc5_ = calcStepProgress(param1,COLOR_TRANSFORM_MIDDLE,COLOR_TRANSFORM_END,Quartic.easeOut);
         var _loc6_:Number = _loc4_ - _loc5_;
         var _loc7_:ColorTransform = new ColorTransform();
         _loc7_.alphaMultiplier = 1 - _loc2_ + _loc3_;
         _loc7_.redOffset = _loc6_ * RED_COLOR_OFFSET_MULTIPLIER;
         _loc7_.greenOffset = _loc6_ * GREEN_COLOR_OFFSET_MULTIPLIER;
         _loc7_.blueOffset = _loc6_ * BLUE_COLOR_OFFSET_MULTIPLIER;
         this._crosshair.transform.colorTransform = _loc7_;
      }
      
      private function update(param1:TimerEvent) : void
      {
         var _loc2_:Number = (getTimer() - this._startTime) / this._duration;
         this.updatePosition(_loc2_);
         this.updateColorTransform(_loc2_);
         if(_loc2_ >= ANIMATION_COMPLETE_TIME_RATIO)
         {
            this.resetAnimation();
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
