package net.wg.gui.battle.views.dualGunPanel
{
   import fl.motion.easing.Quartic;
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.motion.Tween;
   
   public class DualGunChangingProgressIndicator extends MovieClip implements IDisposable
   {
      
      private static const GUN_CHANGING_IDLE_LABEL:String = "idle";
      
      private static const GUN_CHANGING_PROCESS_LABEL:String = "reloading";
      
      private static const GUN_CHANGING_READY_LABEL:String = "onReady";
      
      private static const TRIGGER_VALUE_DECREASE:int = 0;
      
      private static const TRIGGER_VALUE_INCREASE:int = 1;
      
      private static const START_ANGLE:int = -45;
      
      private static const END_ANGLE:int = 0;
      
      private static const START_ANIMATION_DURATION:int = 160;
      
      private static const END_ANIMATION_DURATION:int = 60;
      
      private static const COLLAPSE_TWEEN_DURATION:uint = 400;
       
      
      public var content:MovieClip;
      
      public var oppositeGunPositionX:int;
      
      private var _previousValue:Number = 1.7976931348623157E308;
      
      private var _isActive:Boolean;
      
      private var _tween:Tween;
      
      private var _changeGunTweenDuration:uint = 0;
      
      private var _changeGunTweenDelay:uint = 0;
      
      private var _disposed:Boolean = false;
      
      public function DualGunChangingProgressIndicator()
      {
         super();
      }
      
      private static function clamp(param1:Number, param2:Number, param3:Number) : Number
      {
         return param1 < param2 ? Number(param2) : (param1 > param3 ? Number(param3) : Number(param1));
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.content = null;
         this.cleanTween();
      }
      
      public function playChangeActiveGunAnim() : void
      {
         if(this._changeGunTweenDuration == 0 && this._changeGunTweenDelay == 0)
         {
            return;
         }
         this.content.x = this.oppositeGunPositionX;
         this.cleanTween();
         this._tween = new Tween(this._changeGunTweenDuration,this.content,{"x":0},{
            "paused":false,
            "ease":Quartic.easeOut,
            "delay":this._changeGunTweenDelay
         });
      }
      
      public function playCollapseAnim() : void
      {
         if(this.content.x != 0)
         {
            this.cleanTween();
            this._tween = new Tween(COLLAPSE_TWEEN_DURATION,this.content,{"x":0},{
               "paused":false,
               "ease":Quartic.easeOut
            });
         }
      }
      
      public function setActive(param1:Boolean) : void
      {
         this._isActive = param1;
         this.visible = param1;
         if(!param1)
         {
            this.content.gotoAndStop(GUN_CHANGING_IDLE_LABEL);
         }
      }
      
      public function setChangeGunTweenProps(param1:int, param2:int) : void
      {
         this._changeGunTweenDuration = param1;
         this._changeGunTweenDelay = param2;
      }
      
      public function updateProgress(param1:Number, param2:Number) : void
      {
         if(!this._isActive)
         {
            return;
         }
         if(this.checkStateChanged(param1,param2,TRIGGER_VALUE_INCREASE))
         {
            this.content.gotoAndPlay(GUN_CHANGING_IDLE_LABEL);
            this.content.rotation = START_ANGLE;
         }
         else
         {
            if(this.checkStateChanged(param1,END_ANIMATION_DURATION,TRIGGER_VALUE_DECREASE))
            {
               this.content.gotoAndPlay(GUN_CHANGING_READY_LABEL);
            }
            else if(this.checkStateChanged(param1,param2,TRIGGER_VALUE_DECREASE))
            {
               this.content.gotoAndPlay(GUN_CHANGING_PROCESS_LABEL);
            }
            this.updateRotation(param1,param2);
         }
         this._previousValue = param1;
      }
      
      private function updateRotation(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         _loc3_ = param2 - START_ANIMATION_DURATION - END_ANIMATION_DURATION;
         _loc4_ = param2 - param1 - START_ANIMATION_DURATION;
         var _loc5_:Number = clamp(_loc4_ / _loc3_,0,1);
         this.content.rotation = START_ANGLE + _loc5_ * (END_ANGLE - START_ANGLE);
      }
      
      private function checkStateChanged(param1:Number, param2:Number, param3:int) : Boolean
      {
         if(param3 == TRIGGER_VALUE_INCREASE)
         {
            return this._previousValue < param2 && param1 >= param2;
         }
         return this._previousValue > param2 && param1 <= param2;
      }
      
      private function cleanTween() : void
      {
         if(this._tween)
         {
            this._tween.paused = true;
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
