package net.wg.gui.battle.components
{
   import fl.motion.easing.Cubic;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_NOTIFICATIONS_TIMER_TYPES;
   import net.wg.gui.battle.components.interfaces.IStatusNotification;
   import net.wg.gui.battle.views.destroyTimers.DestroyTimer;
   import net.wg.gui.battle.views.destroyTimers.SecondaryTimerBase;
   import net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx.StunTimerFX;
   import net.wg.gui.battle.views.destroyTimers.data.NotificationTimerSettingVO;
   import net.wg.gui.battle.views.destroyTimers.data.TimersPanelInitVO;
   import net.wg.gui.battle.views.destroyTimers.events.DestroyTimerEvent;
   import net.wg.infrastructure.base.meta.ITimersPanelMeta;
   import net.wg.infrastructure.base.meta.impl.TimersPanelMeta;
   import net.wg.utils.IScheduler;
   import scaleform.clik.motion.Tween;
   
   public class TimersPanel extends TimersPanelMeta implements ITimersPanelMeta
   {
      
      protected static const INVALID_STATE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      protected static const SECONDARY_TIMER_OFFSET_X:int = 110;
      
      private static const SECONDARY_TIMER_SHIFT:int = 110;
      
      private static const TOP_OFFSET_Y:int = 114;
      
      private static const TIMER_OFFSET_X:int = 180;
      
      private static const INVALIDATE_DELAY_TIME:int = 700;
      
      private static const X_SHIFT:int = 8;
      
      private static const X_ADDITIONAL_SHIFT:int = TIMER_OFFSET_X - X_SHIFT;
      
      private static const SECONDARY_CONTAINER_TWEEN_DURATION:int = 400;
      
      private static const MAX_DISPLAYED_SECONDARY_TIMERS:int = 2;
       
      
      public var statusContainer:MovieClip = null;
      
      public var secondaryContainer:MovieClip = null;
      
      protected var stageWidth:int = 0;
      
      protected var stageHeight:int = 0;
      
      protected var activeSecondaryTimers:Vector.<String> = null;
      
      protected var secondaryTimers:Object;
      
      private var _additionalTopOffset:int = 0;
      
      private var _timers:Object;
      
      private var _stackView:Boolean = true;
      
      private var _scheduler:IScheduler;
      
      private var _secondaryContainerTween:Tween = null;
      
      public function TimersPanel()
      {
         this.secondaryTimers = {};
         this._timers = {};
         this._scheduler = App.utils.scheduler;
         super();
      }
      
      override protected function setInitData(param1:TimersPanelInitVO) : void
      {
         var _loc4_:NotificationTimerSettingVO = null;
         var _loc2_:Vector.<NotificationTimerSettingVO> = param1.mainTimers;
         var _loc3_:IStatusNotification = null;
         for each(_loc4_ in _loc2_)
         {
            _loc3_ = App.utils.classFactory.getComponent(_loc4_.linkage,IStatusNotification);
            _loc3_.setSettings(_loc4_);
            _loc3_.visible = false;
            this.statusContainer.addChild(DisplayObject(_loc3_));
            this._timers[_loc4_.typeId] = _loc3_;
         }
         _loc2_ = param1.secondaryTimers;
         for each(_loc4_ in _loc2_)
         {
            _loc3_ = App.utils.classFactory.getComponent(_loc4_.linkage,IStatusNotification);
            _loc3_.setSettings(_loc4_);
            _loc3_.visible = false;
            this.secondaryContainer.addChild(DisplayObject(_loc3_));
            this.secondaryTimers[_loc4_.typeId] = _loc3_;
            if(_loc4_.typeId == BATTLE_NOTIFICATIONS_TIMER_TYPES.STUN)
            {
               _loc3_.setTimerFx(new StunTimerFX());
            }
         }
         invalidateState();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = false;
         mouseEnabled = false;
         this.activeSecondaryTimers = new Vector.<String>(0);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DestroyTimer = null;
         super.draw();
         if(isInvalid(INVALID_STATE))
         {
            if(this._stackView)
            {
               x = this.stageWidth >> 1;
               y = (this.stageHeight >> 1) + TOP_OFFSET_Y;
               this.evaluateState();
            }
            else
            {
               _loc1_ = 0;
               for each(_loc2_ in this._timers)
               {
                  if(_loc2_.isActive)
                  {
                     _loc1_ += TIMER_OFFSET_X;
                     _loc2_.x = _loc1_;
                  }
               }
               _loc1_ += X_ADDITIONAL_SHIFT;
               x = this.stageWidth - _loc1_ >> 1;
               y = (this.stageHeight >> 1) + TOP_OFFSET_Y;
            }
            y += this._additionalTopOffset;
            invalidateSize();
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:DestroyTimer = null;
         var _loc2_:SecondaryTimerBase = null;
         this.clearSecondaryContainerTween();
         this._scheduler.cancelTask(this.onTimerCompleteTask);
         this._scheduler = null;
         stop();
         for each(_loc1_ in this._timers)
         {
            _loc1_.stop();
            _loc1_.removeEventListener(DestroyTimerEvent.TIMER_HIDDEN_EVENT,this.onCurrentTimerTimerHiddenEventHandler);
            _loc1_.dispose();
            _loc1_ = null;
         }
         this._timers = null;
         for each(_loc2_ in this.secondaryTimers)
         {
            _loc2_.stop();
            this.secondaryContainer.removeChild(_loc2_);
            _loc2_.dispose();
            _loc2_ = null;
         }
         this.secondaryTimers = null;
         this.statusContainer = null;
         this.secondaryContainer = null;
         this.activeSecondaryTimers.splice(0,this.activeSecondaryTimers.length);
         this.activeSecondaryTimers = null;
         super.onDispose();
      }
      
      public function as_hide(param1:String) : void
      {
         this.hideTimer(this._timers[param1]);
      }
      
      public function as_hideSecondaryTimer(param1:String) : void
      {
         this.hideSecondaryTimer(param1);
      }
      
      public function as_setSecondaryTimeSnapshot(param1:String, param2:int, param3:Number) : void
      {
         var _loc4_:SecondaryTimerBase = this.getSecondaryTimer(param1);
         if(!_loc4_)
         {
            return;
         }
         _loc4_.updateRadialTimer(param2,param3);
      }
      
      public function as_setSecondaryTimerText(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:SecondaryTimerBase = this.getSecondaryTimer(param1);
         if(!_loc4_)
         {
            return;
         }
         _loc4_.setStaticText(param2,param3);
      }
      
      public function as_setSpeed(param1:Number) : void
      {
         var _loc2_:DestroyTimer = null;
         var _loc3_:SecondaryTimerBase = null;
         for each(_loc2_ in this._timers)
         {
            _loc2_.setSpeed(param1);
         }
         for each(_loc3_ in this.secondaryTimers)
         {
            _loc3_.setSpeed(param1);
         }
      }
      
      public function as_setTimeInSeconds(param1:String, param2:int, param3:Number) : void
      {
         param3 = Math.round(param3);
         this._timers[param1].updateRadialTimer(param2,param3);
      }
      
      public function as_setTimeSnapshot(param1:String, param2:int, param3:int) : void
      {
         this._timers[param1].updateRadialTimer(param2,param3);
      }
      
      public function as_setTimerText(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:DestroyTimer = this._timers[param1];
         if(_loc4_)
         {
            _loc4_.setStaticText(param2,param3);
         }
      }
      
      public function as_setVerticalOffset(param1:int) : void
      {
         if(this._additionalTopOffset != param1)
         {
            this._additionalTopOffset = param1;
            invalidate(INVALID_STATE);
         }
      }
      
      public function as_show(param1:String, param2:String, param3:Boolean) : void
      {
         this.showTimer(param1,param2,param3);
      }
      
      public function as_showSecondaryTimer(param1:String, param2:int, param3:Number, param4:Boolean) : void
      {
         this.showSecondaryTimer(param1,param2,param3,param4);
      }
      
      public function as_turnOnStackView(param1:Boolean) : void
      {
         this._stackView = param1;
         invalidate(INVALID_STATE);
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         this.stageWidth = param1;
         this.stageHeight = param2;
         invalidate(INVALID_STATE);
      }
      
      protected function isAnySecondaryTimerActive() : Boolean
      {
         return this.activeSecondaryTimers.length > 0;
      }
      
      protected function isAnyTimerActive() : Boolean
      {
         var _loc1_:DestroyTimer = null;
         for each(_loc1_ in this._timers)
         {
            if(_loc1_.isActive)
            {
               return true;
            }
         }
         return false;
      }
      
      protected function isAnyTimerInCenter() : Boolean
      {
         return this.isAnyTimerActive();
      }
      
      protected function hideTimer(param1:DestroyTimer) : void
      {
         param1.resetTimer();
         param1.removeEventListener(DestroyTimerEvent.TIMER_HIDDEN_EVENT,this.onCurrentTimerTimerHiddenEventHandler);
         param1.isActive = false;
         invalidate(INVALID_STATE);
      }
      
      protected function hideSecondaryTimer(param1:String) : void
      {
         var _loc2_:SecondaryTimerBase = this.getSecondaryTimer(param1);
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:int = this.activeSecondaryTimers.length;
         if(this.activeSecondaryTimers.indexOf(param1) != -1)
         {
            this.activeSecondaryTimers.splice(this.activeSecondaryTimers.indexOf(param1),1);
         }
         _loc2_.resetTimer();
         _loc2_.isActive = false;
         _loc2_.hideTimer();
         if(_loc3_ > 1)
         {
            this._scheduler.scheduleTask(this.onTimerCompleteTask,INVALIDATE_DELAY_TIME);
         }
         else
         {
            invalidate(INVALID_STATE);
         }
      }
      
      protected function showTimer(param1:String, param2:String, param3:Boolean) : void
      {
         var _loc4_:DestroyTimer = this._timers[param1];
         _loc4_.addEventListener(DestroyTimerEvent.TIMER_HIDDEN_EVENT,this.onCurrentTimerTimerHiddenEventHandler);
         _loc4_.isActive = true;
         _loc4_.updateViewID(param2,param3);
         _loc4_.visible = true;
         invalidate(INVALID_STATE);
      }
      
      protected function showSecondaryTimer(param1:String, param2:int, param3:Number, param4:Boolean = false) : void
      {
         var _loc5_:SecondaryTimerBase = null;
         _loc5_ = this.getSecondaryTimer(param1);
         if(!_loc5_)
         {
            return;
         }
         if(this.activeSecondaryTimers.indexOf(param1) == -1)
         {
            this.activeSecondaryTimers.push(param1);
         }
         _loc5_.updateRadialTimer(param2,param3);
         _loc5_.visible = true;
         _loc5_.isActive = true;
         _loc5_.showTimer(param4);
         invalidate(INVALID_STATE);
      }
      
      protected function evaluateState() : void
      {
         this.clearSecondaryContainerTween();
         var _loc1_:int = this.calculateSecondaryContainerShift();
         var _loc2_:int = _loc1_;
         if(_loc1_ == Values.ZERO && this.activeSecondaryTimers.length > 1)
         {
            _loc2_ = -((this.activeSecondaryTimers.length - 1) * SECONDARY_TIMER_OFFSET_X >> 1);
         }
         this._secondaryContainerTween = new Tween(SECONDARY_CONTAINER_TWEEN_DURATION,this.secondaryContainer,{"x":_loc2_},{
            "paused":false,
            "ease":Cubic.easeOut
         });
         this.updateSecondaryTimersPositions();
      }
      
      protected function updateSecondaryTimersPositions() : void
      {
         var _loc1_:SecondaryTimerBase = null;
         var _loc2_:int = 0;
         for each(_loc1_ in this.secondaryTimers)
         {
            if(_loc1_.isActive)
            {
               if(this.isAnyTimerInCenter() || this.activeSecondaryTimers.length > 1)
               {
                  _loc1_.cropSize();
                  _loc1_.x = _loc2_;
                  _loc2_ += SECONDARY_TIMER_OFFSET_X;
               }
               else if(!this.isAnyTimerInCenter() || this.activeSecondaryTimers.length < MAX_DISPLAYED_SECONDARY_TIMERS)
               {
                  _loc1_.x = 0;
                  _loc1_.fullSize();
               }
            }
         }
      }
      
      protected function getSecondaryTimer(param1:String) : SecondaryTimerBase
      {
         return this.secondaryTimers[param1];
      }
      
      protected function calculateSecondaryContainerShift() : int
      {
         var _loc1_:int = Values.ZERO;
         if(this.isAnyTimerActive() && this.isAnySecondaryTimerActive())
         {
            _loc1_ = SECONDARY_TIMER_SHIFT;
         }
         return _loc1_;
      }
      
      private function clearSecondaryContainerTween() : void
      {
         if(this._secondaryContainerTween)
         {
            this._secondaryContainerTween.paused = true;
            this._secondaryContainerTween.dispose();
            this._secondaryContainerTween = null;
         }
      }
      
      private function onTimerCompleteTask() : void
      {
         invalidate(INVALID_STATE);
      }
      
      private function onCurrentTimerTimerHiddenEventHandler(param1:DestroyTimerEvent) : void
      {
         this.hideTimer(param1.destroyTimer);
      }
   }
}
