package net.wg.gui.battle.views.destroyTimers
{
   import net.wg.gui.battle.components.FrameAnimationTimer;
   import net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx.ISecondaryTimerFX;
   import net.wg.gui.battle.views.destroyTimers.data.NotificationTimerSettingVO;
   import scaleform.clik.motion.Tween;
   
   public class SecondaryTimerBase extends FrameAnimationTimer
   {
      
      private static const TWEEN_X_DURATION:uint = 100;
       
      
      public var onIntervalHideComplete:Function = null;
      
      private var _priority:uint = 0;
      
      private var _countdownVisible:Boolean = true;
      
      private var _tweenX:Tween = null;
      
      private var _isCanBeMainType:Boolean = false;
      
      private var _typeId:String = null;
      
      public function SecondaryTimerBase()
      {
         super();
      }
      
      override protected function onIntervalHideUpdateHandler() : void
      {
      }
      
      override protected function onDispose() : void
      {
         this.clearTweenX();
         this.onIntervalHideComplete = null;
         super.onDispose();
      }
      
      public function cropSize() : Boolean
      {
         return true;
      }
      
      public function fullSize() : Boolean
      {
         return false;
      }
      
      public function hideTimer() : void
      {
      }
      
      public function resetTimer() : void
      {
         pauseHideTimer();
         pauseRadialTimer();
         this.hideTimer();
      }
      
      public function setSettings(param1:NotificationTimerSettingVO) : void
      {
         this._priority = param1.priority;
         this._isCanBeMainType = param1.isCanBeMainType;
         this._countdownVisible = param1.countdownVisible;
         this._typeId = param1.typeId;
         invalidateData();
      }
      
      public function setStaticText(param1:String, param2:String = "") : void
      {
      }
      
      public function setTimerFx(param1:ISecondaryTimerFX) : void
      {
      }
      
      public function showTimer(param1:Boolean) : void
      {
         resetAnimState();
      }
      
      public function tweenToX(param1:int) : void
      {
         this.clearTweenX();
         this._tweenX = new Tween(TWEEN_X_DURATION,this,{"x":param1});
      }
      
      private function clearTweenX() : void
      {
         if(this._tweenX)
         {
            this._tweenX.paused = true;
            this._tweenX.dispose();
            this._tweenX = null;
         }
      }
      
      override public function set x(param1:Number) : void
      {
         this.clearTweenX();
         super.x = param1;
      }
      
      public function get typeId() : String
      {
         return this._typeId;
      }
      
      public function get priority() : uint
      {
         return this._priority;
      }
      
      public function get countdownVisible() : Boolean
      {
         return this._countdownVisible;
      }
      
      public function get isCanBeMainType() : Boolean
      {
         return this._isCanBeMainType;
      }
   }
}
