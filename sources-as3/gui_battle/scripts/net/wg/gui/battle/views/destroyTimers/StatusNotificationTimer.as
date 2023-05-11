package net.wg.gui.battle.views.destroyTimers
{
   import fl.motion.easing.Linear;
   import flash.display.Sprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.components.interfaces.IStatusNotification;
   import net.wg.gui.battle.components.interfaces.IStatusNotificationCallback;
   import net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx.ISecondaryTimerFX;
   import net.wg.gui.battle.views.destroyTimers.data.NotificationTimerSettingVO;
   import net.wg.gui.battle.views.destroyTimers.data.StatusNotificationVO;
   import scaleform.clik.motion.Tween;
   
   public class StatusNotificationTimer extends BattleUIComponent implements IStatusNotification
   {
      
      private static const TWEEN_X_DURATION:uint = 130;
      
      private static const FADE_IN_TWEEN_DURATION:uint = 260;
      
      private static const FADE_OUT_TWEEN_DURATION:uint = 260;
      
      private static const CROPPED_FADE_IN_DELAY:int = TWEEN_X_DURATION + FADE_OUT_TWEEN_DURATION;
      
      private static const FULL_SIZE_FADE_IN_DELAY:int = (TWEEN_X_DURATION >> 1) + FADE_OUT_TWEEN_DURATION;
      
      private static const SHOW_FRAME_LABEL:String = "show";
       
      
      protected var destroyTimer:DestroyTimer = null;
      
      protected var secondaryTimer:SecondaryTimer = null;
      
      private var _destroyTimerContainer:Sprite = null;
      
      private var _secondaryTimerContainer:Sprite = null;
      
      private var _isFullSize:Boolean = true;
      
      private var _isAppearing:Boolean = true;
      
      private var _tweenXDelay:int = 0;
      
      private var _tweenX:Tween = null;
      
      private var _fadeInTween:Tween = null;
      
      private var _fadeOutTweenX:Tween = null;
      
      public function StatusNotificationTimer()
      {
         super();
         this._destroyTimerContainer = new Sprite();
         addChild(this._destroyTimerContainer);
         this._secondaryTimerContainer = new Sprite();
         addChild(this._secondaryTimerContainer);
      }
      
      override protected function onDispose() : void
      {
         this.clearTweenX();
         this.clearFadeTweens();
         this._destroyTimerContainer = null;
         this._secondaryTimerContainer = null;
         this.destroyTimer.dispose();
         this.destroyTimer = null;
         this.secondaryTimer.dispose();
         this.secondaryTimer = null;
         super.onDispose();
      }
      
      public function cropSize() : Boolean
      {
         var _loc1_:Boolean = this._isFullSize;
         this._isFullSize = false;
         this._tweenXDelay = 0;
         if(_loc1_)
         {
            if(this._isAppearing)
            {
               this._destroyTimerContainer.visible = false;
               this._secondaryTimerContainer.visible = true;
            }
            else
            {
               this._destroyTimerContainer.visible = true;
               this._secondaryTimerContainer.visible = true;
               this.applyFadeTween(this._destroyTimerContainer,true,TWEEN_X_DURATION);
               this.applyFadeTween(this._secondaryTimerContainer,false,CROPPED_FADE_IN_DELAY);
            }
         }
         this._isAppearing = false;
         return true;
      }
      
      public function fullSize() : Boolean
      {
         var _loc1_:Boolean = this._isFullSize;
         this._isFullSize = true;
         this._tweenXDelay = 0;
         if(!_loc1_)
         {
            this._tweenXDelay = FADE_OUT_TWEEN_DURATION;
            if(this._isAppearing)
            {
               this._destroyTimerContainer.visible = true;
               this._secondaryTimerContainer.visible = false;
            }
            else
            {
               this._destroyTimerContainer.visible = true;
               this._secondaryTimerContainer.visible = true;
               this.applyFadeTween(this._destroyTimerContainer,false,FULL_SIZE_FADE_IN_DELAY);
               this.applyFadeTween(this._secondaryTimerContainer,true);
            }
         }
         this._isAppearing = false;
         return true;
      }
      
      public function getStatusCallback() : IStatusNotificationCallback
      {
         return null;
      }
      
      public function hideTimer() : void
      {
         this._isAppearing = true;
         this.destroyTimer.hideTimer();
         this.secondaryTimer.hideTimer();
      }
      
      public function resetTimer() : void
      {
         this.destroyTimer.resetTimer();
         this.secondaryTimer.resetTimer();
      }
      
      public function setSettings(param1:NotificationTimerSettingVO) : void
      {
         if(!this.destroyTimer)
         {
            this.initTimers();
         }
         this.destroyTimer.setSettings(param1);
         this.secondaryTimer.setSettings(param1);
         this._secondaryTimerContainer.visible = false;
         this.secondaryTimer.cropSize();
      }
      
      public function setSpeed(param1:Number) : void
      {
         this.destroyTimer.setSpeed(param1);
         this.secondaryTimer.setSpeed(param1);
      }
      
      public function setTimerFx(param1:ISecondaryTimerFX) : void
      {
         this.destroyTimer.setTimerFx(param1);
         this.secondaryTimer.setTimerFx(param1);
      }
      
      public function showTimer(param1:Boolean) : void
      {
         if(this.destroyTimer.visible)
         {
            this.destroyTimer.gotoAndPlay(SHOW_FRAME_LABEL);
         }
         this.destroyTimer.showTimer(param1);
         this.secondaryTimer.showTimer(param1);
      }
      
      public function tweenToX(param1:int) : void
      {
         if(x != param1)
         {
            this.clearTweenX();
            this._tweenX = new Tween(TWEEN_X_DURATION,this,{"x":param1},{"delay":this._tweenXDelay});
         }
      }
      
      public function updateData(param1:StatusNotificationVO) : void
      {
         this.destroyTimer.updateData(param1);
         this.secondaryTimer.updateData(param1);
      }
      
      protected function initTimers(param1:String = "destroyTimerUI", param2:String = "secondaryTimerUI") : void
      {
         this.destroyTimer = App.utils.classFactory.getComponent(param1,IStatusNotification);
         this._destroyTimerContainer.addChild(this.destroyTimer);
         this.secondaryTimer = App.utils.classFactory.getComponent(param2,IStatusNotification);
         this._secondaryTimerContainer.addChild(this.secondaryTimer);
      }
      
      private function applyFadeTween(param1:Object, param2:Boolean, param3:uint = 0) : void
      {
         if(param2)
         {
            if(this._fadeOutTweenX)
            {
               this._fadeOutTweenX.dispose();
            }
            param1.alpha = 1;
            this._fadeOutTweenX = new Tween(FADE_OUT_TWEEN_DURATION,param1,{"alpha":0},{
               "delay":param3,
               "ease":Linear.easeNone,
               "onComplete":this.onOutTweenComplete
            });
         }
         else
         {
            if(this._fadeInTween)
            {
               this._fadeInTween.dispose();
            }
            param1.alpha = 0;
            this._fadeInTween = new Tween(FADE_IN_TWEEN_DURATION,param1,{"alpha":1},{
               "delay":param3,
               "ease":Linear.easeNone
            });
         }
      }
      
      private function clearFadeTweens() : void
      {
         if(this._fadeOutTweenX)
         {
            this._fadeOutTweenX.dispose();
            this._fadeOutTweenX = null;
         }
         if(this._fadeInTween)
         {
            this._fadeInTween.dispose();
            this._fadeInTween = null;
         }
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
      
      private function onOutTweenComplete() : void
      {
         if(this._isFullSize)
         {
            this._secondaryTimerContainer.visible = false;
         }
         else
         {
            this._destroyTimerContainer.visible = false;
         }
      }
      
      public function get typeId() : String
      {
         return this.destroyTimer.typeId;
      }
      
      public function get isShowing() : Boolean
      {
         return this.destroyTimer.isShowing;
      }
      
      public function get actualWidth() : Number
      {
         return !!this._isFullSize ? Number(this.destroyTimer.actualWidth) : Number(this.secondaryTimer.actualWidth);
      }
      
      public function get isActive() : Boolean
      {
         return !!this._isFullSize ? Boolean(this.destroyTimer.isActive) : Boolean(this.secondaryTimer.isActive);
      }
      
      public function set isActive(param1:Boolean) : void
      {
         this.destroyTimer.isActive = param1;
         this.secondaryTimer.isActive = param1;
      }
   }
}
