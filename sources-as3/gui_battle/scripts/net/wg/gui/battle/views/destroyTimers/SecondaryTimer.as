package net.wg.gui.battle.views.destroyTimers
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_NOTIFICATIONS_TIMER_TYPES;
   import net.wg.gui.battle.components.interfaces.IStatusNotification;
   import net.wg.gui.battle.components.interfaces.IStatusNotificationCallback;
   import net.wg.gui.battle.views.destroyTimers.components.SecondaryTimerContainer;
   import net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx.ISecondaryTimerFX;
   import net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx.SecondaryTimerFXContainer;
   import net.wg.gui.battle.views.destroyTimers.data.NotificationTimerSettingVO;
   import net.wg.gui.battle.views.destroyTimers.data.StatusNotificationVO;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class SecondaryTimer extends SecondaryTimerBase implements IStatusNotification
   {
      
      private static const HIDE_SCALE_STEP_VALUE:Number = 0.005;
      
      private static const HIDE_ALPHA_STEP_VALUE:Number = 0.1;
      
      private static const SHOW_FRAME_LABEL:String = "show";
      
      private static const HIDE_FRAME_LABEL:String = "hide";
      
      private static const START_FRAME:int = 10;
      
      private static const TEXT_FIELD_CROP_Y:int = -10;
      
      private static const TEXT_FIELD_FULL_Y:int = -2;
      
      private static const END_FRAME:int = 190;
      
      private static const PADDING:uint = 20;
      
      private static const CROPPED_SIZE_PADDING:uint = 15;
      
      private static const CROPPED_SIZE_WIDTH:uint = 100;
      
      private static const ICON_BTM_POSITION_VALIDATE:int = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const SECONDARY_TIMER_NAME:String = "secondaryTimer";
       
      
      public var fxContainer:SecondaryTimerFXContainer = null;
      
      public var container:SecondaryTimerContainer = null;
      
      private var _xScale:Number = 1;
      
      private var _yScale:Number = 1;
      
      private var _alpha:Number = 1;
      
      private var _secString:String = "";
      
      private var _isShowing:Boolean = false;
      
      private var _timerFX:ISecondaryTimerFX;
      
      private var _currentColor:String = "orange";
      
      private var _canBlink:Boolean;
      
      public function SecondaryTimer()
      {
         super();
         stop();
         mouseEnabled = mouseChildren = false;
         name = SECONDARY_TIMER_NAME;
         this._secString = App.utils.locale.makeString(INGAME_GUI.STUN_SECONDS);
         init(true,true);
      }
      
      override public function cropSize() : Boolean
      {
         this.container.textFieldLabel.visible = false;
         this.container.textField.y = TEXT_FIELD_CROP_Y;
         return true;
      }
      
      override public function fullSize() : Boolean
      {
         if(StringUtils.isEmpty(this.container.textFieldLabel.text))
         {
            return this.cropSize();
         }
         this.container.textFieldLabel.visible = true;
         this.container.textField.y = TEXT_FIELD_FULL_Y;
         return true;
      }
      
      override public function hideTimer() : void
      {
         if(!this._isShowing)
         {
            return;
         }
         if(this._timerFX)
         {
            this._timerFX.hide();
         }
         gotoAndPlay(HIDE_FRAME_LABEL);
         this._isShowing = false;
      }
      
      override public function setSettings(param1:NotificationTimerSettingVO) : void
      {
         this._canBlink = param1.canBlink;
         this.container.setTimerSettings(param1);
         var _loc2_:String = param1.color;
         if(StringUtils.isNotEmpty(_loc2_))
         {
            this._currentColor = _loc2_;
            this.container.updateColor(this._currentColor);
         }
         isReversedTimerDirection = param1.isReversedTimerDirection;
         var _loc3_:String = this.getIconName(param1.iconName,param1.iconSmallName);
         currentIconName = _loc3_;
         updateIcon();
         super.setSettings(param1);
      }
      
      override public function setStaticText(param1:String, param2:String = "") : void
      {
         this.container.textFieldLabel.text = param1;
      }
      
      override public function setTimerFx(param1:ISecondaryTimerFX) : void
      {
         this._timerFX = param1;
         this._timerFX.setFxContainer(this.fxContainer);
      }
      
      override public function showTimer(param1:Boolean) : void
      {
         super.showTimer(param1);
         if(this._isShowing)
         {
            return;
         }
         if(this._timerFX)
         {
            this._timerFX.show(param1);
         }
         gotoAndPlay(SHOW_FRAME_LABEL);
         this._isShowing = true;
      }
      
      override protected function onDispose() : void
      {
         this.container.dispose();
         this.container = null;
         iconSpr = null;
         iconBitmap = null;
         if(this._timerFX)
         {
            this._timerFX.dispose();
            this._timerFX = null;
         }
         this.fxContainer.dispose();
         this.fxContainer = null;
         super.onDispose();
      }
      
      override protected function invokeAdditionalActionOnIntervalUpdate() : void
      {
      }
      
      override protected function getTimeFormatted(param1:int) : String
      {
         return param1.toString();
      }
      
      override protected function onIntervalHideUpdateHandler() : void
      {
         if(alpha <= 0)
         {
            pauseHideTimer();
            pauseRadialTimer();
            stop();
            isActive = false;
            this.container.isCritical = false;
            if(onIntervalHideComplete != null)
            {
               onIntervalHideComplete();
            }
         }
         else
         {
            this._xScale -= HIDE_SCALE_STEP_VALUE;
            this._yScale -= HIDE_SCALE_STEP_VALUE;
            this._alpha -= HIDE_ALPHA_STEP_VALUE;
            invalidate(InvalidationType.SIZE);
         }
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
      
      override protected function setTimerTimeString() : void
      {
         if(StringUtils.isNotEmpty(lastStrTime))
         {
            this.container.textField.text = lastStrTime + this._secString;
         }
         else
         {
            this.container.textField.text = Values.EMPTY_STR;
         }
      }
      
      override protected function getProgressBarMc() : MovieClip
      {
         return this.container.getProgressBar();
      }
      
      override protected function getTimerTF() : TextField
      {
         return this.container.textField;
      }
      
      override protected function getStartFrame() : int
      {
         return START_FRAME;
      }
      
      override protected function getEndFrame() : int
      {
         return END_FRAME;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         iconSpr = this.container.iconSpr;
      }
      
      override protected function invokeCurrentTimeEnlargeUpdate() : void
      {
         if(this._canBlink)
         {
            this.container.blink();
         }
      }
      
      public function getStatusCallback() : IStatusNotificationCallback
      {
         return null;
      }
      
      public function updateData(param1:StatusNotificationVO) : void
      {
         var _loc2_:String = param1.color;
         if(StringUtils.isNotEmpty(_loc2_) && this._currentColor != _loc2_)
         {
            this._currentColor = _loc2_;
            this.container.updateColor(this._currentColor);
         }
         var _loc3_:String = this.getIconName(param1.iconName,param1.iconSmallName);
         if(StringUtils.isNotEmpty(_loc3_) && currentIconName != _loc3_)
         {
            currentIconName = _loc3_;
            updateIcon();
         }
         this.container.setPulseVisible(param1.pulseVisible);
         this.setStaticText(param1.title,param1.description);
         this.updateViewID(param1.viewSubType,false);
         updateRadialTimer(param1.totalTime,param1.currentTime);
      }
      
      public function updateViewID(param1:String, param2:Boolean, param3:int = -1) : void
      {
         this.container.isCritical = param1 == BATTLE_NOTIFICATIONS_TIMER_TYPES.CRITICAL_VIEW;
      }
      
      private function getIconName(param1:String, param2:String) : String
      {
         return !!StringUtils.isNotEmpty(param2) ? param2 : param1;
      }
      
      public function get actualWidth() : Number
      {
         if(this.container.textFieldLabel.visible)
         {
            return super.width + PADDING;
         }
         return CROPPED_SIZE_WIDTH + CROPPED_SIZE_PADDING;
      }
      
      public function get isShowing() : Boolean
      {
         return this._isShowing;
      }
   }
}
