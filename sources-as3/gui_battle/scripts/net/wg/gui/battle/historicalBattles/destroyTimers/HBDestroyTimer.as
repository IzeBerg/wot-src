package net.wg.gui.battle.historicalBattles.destroyTimers
{
   import net.wg.data.constants.generated.BATTLE_NOTIFICATIONS_TIMER_LINKAGES;
   import net.wg.gui.battle.components.FrameAnimationTimer;
   import net.wg.gui.battle.components.interfaces.IStatusNotification;
   import net.wg.gui.battle.components.interfaces.IStatusNotificationCallback;
   import net.wg.gui.battle.views.destroyTimers.DestroyTimer;
   import net.wg.gui.battle.views.destroyTimers.SecondaryTimer;
   import net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx.ISecondaryTimerFX;
   import net.wg.gui.battle.views.destroyTimers.data.NotificationTimerSettingVO;
   import net.wg.gui.battle.views.destroyTimers.data.StatusNotificationVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.motion.Tween;
   
   public class HBDestroyTimer extends FrameAnimationTimer implements IDisposable, IStatusNotification
   {
      
      private static const FULL_SIZE_WIDTH:uint = 125;
      
      private static const CROP_SIZE_WIDTH:uint = 92;
      
      private static const TWEEN_X_DURATION:uint = 100;
      
      private static const SECONDARY_PREFIX:String = "secondary";
       
      
      private var _secondaryTimer:SecondaryTimer = null;
      
      private var _timer:DestroyTimer = null;
      
      private var _isSMall:Boolean = false;
      
      private var _tweenX:Tween = null;
      
      private var _classFactory:IClassFactory;
      
      public function HBDestroyTimer()
      {
         this._classFactory = App.utils.classFactory;
         super();
         this._secondaryTimer = this._classFactory.getComponent(BATTLE_NOTIFICATIONS_TIMER_LINKAGES.HB_SECONDARY_TIMER_UI,IStatusNotification);
         addChild(this._secondaryTimer);
         this._timer = this._classFactory.getComponent(BATTLE_NOTIFICATIONS_TIMER_LINKAGES.HB_DESTROY_TIMER_BIG_UI,IStatusNotification);
         addChild(this._timer);
      }
      
      override public function setSpeed(param1:Number) : void
      {
         this._secondaryTimer.setSpeed(param1);
         this._timer.setSpeed(param1);
      }
      
      override protected function setTimerTimeString() : void
      {
      }
      
      override protected function onDispose() : void
      {
         this._classFactory = null;
         this._secondaryTimer.dispose();
         this._secondaryTimer = null;
         this._timer.dispose();
         this._timer = null;
         super.onDispose();
      }
      
      public function cropSize() : Boolean
      {
         this._isSMall = true;
         this._secondaryTimer.visible = true;
         this._timer.visible = false;
         return true;
      }
      
      public function fullSize() : Boolean
      {
         this._isSMall = false;
         this._secondaryTimer.visible = false;
         this._timer.visible = true;
         return true;
      }
      
      public function getStatusCallback() : IStatusNotificationCallback
      {
         return null;
      }
      
      public function hideTimer() : void
      {
         this._secondaryTimer.hideTimer();
         this._timer.hideTimer();
      }
      
      public function resetTimer() : void
      {
         this._secondaryTimer.resetTimer();
         this._timer.resetTimer();
      }
      
      public function setSettings(param1:NotificationTimerSettingVO) : void
      {
         this._timer.setSettings(param1);
         param1.iconName = SECONDARY_PREFIX.concat(param1.iconName);
         this._secondaryTimer.setSettings(param1);
      }
      
      public function setTimerFx(param1:ISecondaryTimerFX) : void
      {
         this._secondaryTimer.setTimerFx(param1);
         this._timer.setTimerFx(param1);
      }
      
      public function showTimer(param1:Boolean) : void
      {
         this._secondaryTimer.showTimer(param1);
         this._timer.showTimer(param1);
      }
      
      public function tweenToX(param1:int) : void
      {
         this.clearTweenX();
         this._tweenX = new Tween(TWEEN_X_DURATION,this,{"x":param1});
      }
      
      public function updateData(param1:StatusNotificationVO) : void
      {
         this._secondaryTimer.updateData(param1);
         this._timer.updateData(param1);
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
      
      override public function get isActive() : Boolean
      {
         return this._timer.isActive;
      }
      
      override public function set isActive(param1:Boolean) : void
      {
         this._timer.isActive = param1;
         this._secondaryTimer.isActive = param1;
      }
      
      public function get typeId() : String
      {
         return this._timer.typeId;
      }
      
      public function get isShowing() : Boolean
      {
         return this._timer.isShowing;
      }
      
      public function get actualWidth() : Number
      {
         return !!this._isSMall ? Number(CROP_SIZE_WIDTH) : Number(FULL_SIZE_WIDTH);
      }
   }
}
