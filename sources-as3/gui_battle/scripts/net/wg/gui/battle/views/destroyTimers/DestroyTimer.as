package net.wg.gui.battle.views.destroyTimers
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_NOTIFICATIONS_TIMER_TYPES;
   import net.wg.gui.battle.components.FrameAnimationTimer;
   import net.wg.gui.battle.components.interfaces.IStatusNotification;
   import net.wg.gui.battle.components.interfaces.IStatusNotificationCallback;
   import net.wg.gui.battle.views.destroyTimers.components.TimerContainer;
   import net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx.ISecondaryTimerFX;
   import net.wg.gui.battle.views.destroyTimers.data.NotificationTimerSettingVO;
   import net.wg.gui.battle.views.destroyTimers.data.StatusNotificationVO;
   import net.wg.gui.battle.views.destroyTimers.events.DestroyTimerEvent;
   import net.wg.gui.components.controls.TextFieldContainer;
   import net.wg.utils.IScheduler;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.motion.Tween;
   
   public class DestroyTimer extends FrameAnimationTimer implements IStatusNotification
   {
      
      private static const TWEEN_X_DURATION:uint = 100;
      
      private static const FULL_SIZE_WIDTH:uint = 125;
      
      private static const START_FRAME:int = 13;
      
      private static const END_FRAME:int = 157;
      
      private static const ICON_WARNING_Y_POS:int = 0;
      
      private static const ICON_CRITICAL_Y_POS:int = -12;
      
      private static const HIDE_SCALE_STEP_VALUE:Number = 0.005;
      
      private static const HIDE_ALPHA_STEP_VALUE:Number = 0.1;
      
      private static const MOVE_ICON_SPEED:int = 34;
      
      private static const MOVE_ICON_STEPS:int = 12;
      
      private static const POSITIVE_DIRECTION:int = 1;
      
      private static const NEGATIVE_DIRECTION:int = -1;
      
      private static const ICON_SPR_POSITION_VALIDATE:int = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const ACTIVE_FRAME_LABEL:String = "active";
      
      private static const SHOW_FRAME_LABEL:String = "show";
      
      private static const SHOW_BUBBLE_FRAME_LABEL:String = "showBubble";
      
      private static const HIDDEN_FRAME_LABEL:String = "hidden";
      
      private static const HIDE_FRAME_LABEL:String = "hide";
      
      private static const BEAT_LAST_FRAME:String = "repeat";
      
      private static const DESC_TEXT_COLORS:Object = {
         "orange":16689972,
         "green":8041216
      };
       
      
      public var graphicsSpr:TimerContainer = null;
      
      public var desc:TextFieldContainer = null;
      
      private var _timerViewTypeID:String = "";
      
      private var _scheduler:IScheduler = null;
      
      private var _moveIconYStep:int = -1;
      
      private var _xScale:Number = 1.0;
      
      private var _yScale:Number = 1.0;
      
      private var _alpha:Number = 1.0;
      
      private var _iconSpriteY:Number = 0;
      
      private var _tweenX:Tween = null;
      
      private var _isShowing:Boolean = false;
      
      private var _typeId:String = null;
      
      private var _currentColor:String = "orange";
      
      public function DestroyTimer()
      {
         super();
         stop();
         init(true,true);
         this._scheduler = App.utils.scheduler;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         iconSpr = this.graphicsSpr.iconSpr;
      }
      
      override protected function invokeAdditionalActionOnIntervalUpdate() : void
      {
         gotoAndPlay(BEAT_LAST_FRAME);
      }
      
      override protected function getProgressBarMc() : MovieClip
      {
         return this.graphicsSpr.progressBar;
      }
      
      override protected function getTimerTF() : TextField
      {
         return this.graphicsSpr.textField;
      }
      
      override protected function onDispose() : void
      {
         this.clearTweenX();
         this.resetTimerStates();
         this._scheduler = null;
         this.getProgressBarMc().stop();
         stop();
         this.graphicsSpr.dispose();
         this.graphicsSpr = null;
         this.desc.dispose();
         this.desc = null;
         if(iconBitmap && iconSpr.contains(iconBitmap))
         {
            iconSpr.removeChild(iconBitmap);
         }
         iconSpr = null;
         if(iconBitmap && iconBitmap.bitmapData)
         {
            iconBitmap.bitmapData.dispose();
            iconBitmap.bitmapData = null;
         }
         iconBitmap = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            scaleX = this._xScale;
            scaleY = this._yScale;
            alpha = this._alpha;
         }
         if(iconBitmap && isInvalid(ICON_BTM_POSITION_VALIDATE))
         {
            iconBitmap.x = iconBitmapX;
            iconBitmap.y = iconBitmapY;
         }
         if(isInvalid(ICON_SPR_POSITION_VALIDATE))
         {
            iconSpr.y = this._iconSpriteY;
         }
      }
      
      override protected function getStartFrame() : int
      {
         return START_FRAME;
      }
      
      override protected function getEndFrame() : int
      {
         return END_FRAME;
      }
      
      override protected function resetAnimState() : void
      {
         if(alpha != 1)
         {
            this._xScale = 1;
            this._yScale = 1;
            this._alpha = 1;
            invalidate(InvalidationType.SIZE);
         }
      }
      
      override protected function onHide() : void
      {
         super.onHide();
         if(this._timerViewTypeID == BATTLE_NOTIFICATIONS_TIMER_TYPES.CRITICAL_VIEW)
         {
            this.updateViewID(BATTLE_NOTIFICATIONS_TIMER_TYPES.WARNING_VIEW,false);
         }
      }
      
      override protected function onIntervalHideUpdateHandler() : void
      {
         if(alpha <= 0)
         {
            this.graphicsSpr.isCritical = false;
            pauseHideTimer();
            this.pauseRadialTimer();
            stop();
            dispatchEvent(new DestroyTimerEvent(DestroyTimerEvent.TIMER_HIDDEN_EVENT,this));
         }
         else
         {
            this._xScale -= HIDE_SCALE_STEP_VALUE;
            this._yScale -= HIDE_SCALE_STEP_VALUE;
            this._alpha -= HIDE_ALPHA_STEP_VALUE;
            invalidate(InvalidationType.SIZE);
         }
      }
      
      override protected function pauseRadialTimer() : void
      {
         super.pauseRadialTimer();
      }
      
      public function cropSize() : Boolean
      {
         return false;
      }
      
      public function fullSize() : Boolean
      {
         return true;
      }
      
      public function getStatusCallback() : IStatusNotificationCallback
      {
         return null;
      }
      
      public function hideTimer() : void
      {
         this._isShowing = false;
      }
      
      public function resetTimer() : void
      {
         updateRadialTimer(Values.DEFAULT_INT,Values.ZERO);
         this.resetTimerStates();
      }
      
      public function setSettings(param1:NotificationTimerSettingVO) : void
      {
         this._typeId = param1.typeId;
         currentIconName = param1.iconName;
         currentIconOffsetY = param1.iconOffsetY;
         var _loc2_:String = param1.color;
         if(StringUtils.isNotEmpty(_loc2_))
         {
            this._currentColor = _loc2_;
            this.updateColor();
         }
         isReversedTimerDirection = param1.isReversedTimerDirection;
         updateIcon();
      }
      
      public function setStaticText(param1:String, param2:String = "") : void
      {
         this.desc.label = param2;
      }
      
      public function setTimerFx(param1:ISecondaryTimerFX) : void
      {
      }
      
      public function showTimer(param1:Boolean) : void
      {
         this._isShowing = true;
      }
      
      public function tweenToX(param1:int) : void
      {
         if(x != param1)
         {
            this.clearTweenX();
            this._tweenX = new Tween(TWEEN_X_DURATION,this,{"x":param1});
         }
      }
      
      public function updateData(param1:StatusNotificationVO) : void
      {
         var _loc2_:String = param1.color;
         if(StringUtils.isNotEmpty(_loc2_) && this._currentColor != _loc2_)
         {
            this._currentColor = _loc2_;
            this.updateColor();
         }
         if(StringUtils.isNotEmpty(param1.iconName) && currentIconName != param1.iconName)
         {
            currentIconName = param1.iconName;
            updateIcon();
         }
         this.setStaticText(param1.title,param1.description);
         this.updateViewID(param1.viewSubType,false);
         updateRadialTimer(param1.totalTime,param1.currentTime);
      }
      
      public function updateViewID(param1:String, param2:Boolean, param3:int = -1) : void
      {
         var _loc4_:Boolean = param1 == BATTLE_NOTIFICATIONS_TIMER_TYPES.WARNING_VIEW && this._timerViewTypeID == BATTLE_NOTIFICATIONS_TIMER_TYPES.CRITICAL_VIEW;
         this.cancelSchedulerTasks();
         this.resetAnimState();
         if(this._timerViewTypeID != param1)
         {
            this._timerViewTypeID = param1;
            if(param1 == BATTLE_NOTIFICATIONS_TIMER_TYPES.CRITICAL_VIEW)
            {
               if(iconSpr.y != this.iconCriticalYPos)
               {
                  this._iconSpriteY = ICON_WARNING_Y_POS;
                  invalidate(ICON_SPR_POSITION_VALIDATE);
                  this._moveIconYStep = NEGATIVE_DIRECTION;
                  this.startMoveIconTimer();
               }
            }
            else
            {
               if(iconSpr.y != ICON_WARNING_Y_POS)
               {
                  this._iconSpriteY = this.iconCriticalYPos;
                  invalidate(ICON_SPR_POSITION_VALIDATE);
                  this._moveIconYStep = POSITIVE_DIRECTION;
                  this.startMoveIconTimer();
               }
               setTTFText(Values.EMPTY_STR);
               this.getProgressBarMc().gotoAndStop(SHOW_FRAME_LABEL);
               this._scheduler.scheduleTask(this.startWarningBlinkAnimation,Time.MILLISECOND_IN_SECOND);
               updateRadialTimer(Values.DEFAULT_INT,Values.ZERO);
               if(!_loc4_)
               {
                  if(param2)
                  {
                     gotoAndPlay(SHOW_BUBBLE_FRAME_LABEL);
                  }
                  else
                  {
                     gotoAndPlay(SHOW_FRAME_LABEL);
                  }
               }
               else
               {
                  gotoAndStop(ACTIVE_FRAME_LABEL);
               }
            }
         }
         else
         {
            if(this._timerViewTypeID == BATTLE_NOTIFICATIONS_TIMER_TYPES.CRITICAL_VIEW)
            {
               if(iconSpr.y != this.iconCriticalYPos)
               {
                  this._iconSpriteY = ICON_WARNING_Y_POS;
                  invalidate(ICON_SPR_POSITION_VALIDATE);
                  this._moveIconYStep = NEGATIVE_DIRECTION;
                  this.startMoveIconTimer();
               }
            }
            if(this._timerViewTypeID == BATTLE_NOTIFICATIONS_TIMER_TYPES.WARNING_VIEW && iconSpr.y != ICON_WARNING_Y_POS)
            {
               this._iconSpriteY = ICON_WARNING_Y_POS;
               invalidate(ICON_SPR_POSITION_VALIDATE);
            }
         }
         this.graphicsSpr.isCritical = this._timerViewTypeID == BATTLE_NOTIFICATIONS_TIMER_TYPES.CRITICAL_VIEW;
      }
      
      private function updateColor() : void
      {
         this.graphicsSpr.setColor(this._currentColor);
         this.desc.textColor = DESC_TEXT_COLORS[this._currentColor];
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
      
      private function resetTimerStates() : void
      {
         this.cancelSchedulerTasks();
         if(this._timerViewTypeID == BATTLE_NOTIFICATIONS_TIMER_TYPES.CRITICAL_VIEW)
         {
            gotoAndStop(HIDDEN_FRAME_LABEL);
         }
         else
         {
            gotoAndPlay(HIDE_FRAME_LABEL);
         }
         this._timerViewTypeID = Values.EMPTY_STR;
      }
      
      private function cancelSchedulerTasks() : void
      {
         pauseHideTimer();
         this.pauseRadialTimer();
         this._scheduler.cancelTask(this.onMoveIconHandler);
         this._scheduler.cancelTask(this.startWarningBlinkAnimation);
         this._scheduler.cancelTask(this.playWarningBlinkAnimation);
      }
      
      private function startMoveIconTimer() : void
      {
         this._scheduler.cancelTask(this.onMoveIconHandler);
         this._scheduler.scheduleRepeatableTask(this.onMoveIconHandler,MOVE_ICON_SPEED,this.moveIconSteps);
      }
      
      private function startWarningBlinkAnimation() : void
      {
         this.playWarningBlinkAnimation();
      }
      
      private function playWarningBlinkAnimation() : void
      {
         this._scheduler.scheduleTask(this.playWarningBlinkAnimation,Time.MILLISECOND_IN_SECOND);
         this.invokeAdditionalActionOnIntervalUpdate();
      }
      
      private function onMoveIconHandler() : void
      {
         this._iconSpriteY += this._moveIconYStep;
         invalidate(ICON_SPR_POSITION_VALIDATE);
      }
      
      public function get typeId() : String
      {
         return this._typeId;
      }
      
      public function get isShowing() : Boolean
      {
         return this._isShowing;
      }
      
      public function get actualWidth() : Number
      {
         return FULL_SIZE_WIDTH;
      }
      
      protected function get iconCriticalYPos() : int
      {
         return ICON_CRITICAL_Y_POS;
      }
      
      protected function get moveIconSteps() : int
      {
         return MOVE_ICON_STEPS;
      }
   }
}
