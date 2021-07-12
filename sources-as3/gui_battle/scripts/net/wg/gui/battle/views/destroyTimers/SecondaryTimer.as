package net.wg.gui.battle.views.destroyTimers
{
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.interfaces.IStatusNotification;
   import net.wg.gui.battle.components.interfaces.IStatusNotificationCallback;
   import net.wg.gui.battle.views.destroyTimers.components.SecondaryTimerContainer;
   import net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx.ISecondaryTimerFX;
   import net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx.SecondaryTimerFXContainer;
   import net.wg.gui.battle.views.destroyTimers.data.NotificationTimerSettingVO;
   import net.wg.utils.IClassFactory;
   
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
      
      private var _iconBitmap:Bitmap = null;
      
      private var _iconBitmapX:Number = 0;
      
      private var _iconBitmapY:Number = 0;
      
      private var _isShowing:Boolean = false;
      
      private var _timerFX:ISecondaryTimerFX;
      
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
         this.container.setTimerSettings(param1);
         this.setIcon(param1.iconName);
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
         this._iconBitmap = null;
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
         if(isInvalid(ICON_BTM_POSITION_VALIDATE))
         {
            this._iconBitmap.x = this._iconBitmapX;
            this._iconBitmap.y = this._iconBitmapY;
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
         if(lastStrTime)
         {
            this.container.textField.text = lastStrTime + this._secString;
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
      
      public function updateViewID(param1:String, param2:Boolean) : void
      {
      }
      
      private function setIcon(param1:String) : void
      {
         var _loc2_:IClassFactory = App.utils.classFactory;
         var _loc3_:Class = _loc2_.getClass(param1);
         this._iconBitmap = new Bitmap(new _loc3_());
         var _loc4_:Sprite = this.container.iconSpr;
         _loc4_.addChild(this._iconBitmap);
         this._iconBitmapX = -this._iconBitmap.width >> 1;
         this._iconBitmapY = -this._iconBitmap.height >> 1;
         invalidate(ICON_BTM_POSITION_VALIDATE);
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
      
      public function getStatusCallback() : IStatusNotificationCallback
      {
         return null;
      }
   }
}
