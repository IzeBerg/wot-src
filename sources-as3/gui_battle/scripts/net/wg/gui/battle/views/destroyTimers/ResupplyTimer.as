package net.wg.gui.battle.views.destroyTimers
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.EPIC_CONSTS;
   import net.wg.gui.battle.components.FrameAnimationTimer;
   import net.wg.gui.battle.components.interfaces.IStatusNotification;
   import net.wg.gui.battle.components.interfaces.IStatusNotificationCallback;
   import net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx.ISecondaryTimerFX;
   import net.wg.gui.battle.views.destroyTimers.data.NotificationTimerSettingVO;
   import net.wg.gui.battle.views.destroyTimers.data.StatusNotificationVO;
   import scaleform.clik.motion.Tween;
   import scaleform.gfx.TextFieldEx;
   
   public class ResupplyTimer extends FrameAnimationTimer implements IStatusNotification
   {
      
      private static const PERCENT_TEXT:String = " %";
      
      private static const SHOW_FRAME_LABEL:String = "show";
      
      private static const SHOW_FRAME_LABEL_SMALL:String = "showSmall";
      
      private static const HIDE_FRAME_LABEL:String = "hide";
      
      private static const HIDE_FRAME_LABEL_SMALL:String = "hideSmall";
      
      private static const SHOW_FRAME_LABEL_END:String = "showEndFrame";
      
      private static const SHOW_FRAME_LABEL_END_SMALL:String = "showEndFrameSmall";
      
      private static const ICON_ACTIVE_FRAME_LABEL:String = "active";
      
      private static const ICON_UNAVAILABLE_FRAME_LABEL:String = "unavailable";
      
      private static const FULL_SIZE_WIDTH:uint = 125;
      
      private static const TWEEN_X_DURATION:uint = 100;
      
      private static const START_FRAME:int = 0;
      
      private static const END_FRAME:int = 100;
       
      
      public var cooldownTime:MovieClip = null;
      
      public var progressAnimation:MovieClip = null;
      
      public var description:MovieClip = null;
      
      public var icon:MovieClip = null;
      
      private var _isActive:Boolean = false;
      
      private var _isCropSize:Boolean = false;
      
      private var _isSmallSize:Boolean = false;
      
      private var _typeId:String = null;
      
      private var _tweenX:Tween = null;
      
      private var _isShowing:Boolean = false;
      
      private var _actualState:int = -1;
      
      public function ResupplyTimer()
      {
         super();
         init(false,true);
         TextFieldEx.setNoTranslate(this.cooldownTime.cooldownTF,true);
         this.description.titleTF.autoSize = TextFieldAutoSize.LEFT;
         this.description.descriptionTF.autoSize = TextFieldAutoSize.LEFT;
         this.description.titleTF.text = EPIC_BATTLE.PROGRESS_TIMERS_RESUPPLY;
      }
      
      override protected function onDispose() : void
      {
         stop();
         this.cooldownTime = null;
         this.progressAnimation.stop();
         this.progressAnimation = null;
         this.description = null;
         this.icon = null;
         if(this._tweenX != null)
         {
            this._tweenX.dispose();
            this._tweenX = null;
         }
         super.onDispose();
      }
      
      public function cropSize() : Boolean
      {
         this.description.visible = false;
         this._isCropSize = true;
         gotoAndStop(SHOW_FRAME_LABEL_END_SMALL);
         this.setState(this._actualState);
         return true;
      }
      
      public function fullSize() : Boolean
      {
         this.description.visible = true;
         this._isCropSize = false;
         gotoAndStop(SHOW_FRAME_LABEL_END);
         this.setState(this._actualState);
         return true;
      }
      
      public function hideTimer() : void
      {
         if(this._isCropSize)
         {
            gotoAndPlay(HIDE_FRAME_LABEL_SMALL);
         }
         else
         {
            gotoAndPlay(HIDE_FRAME_LABEL);
         }
         this._isShowing = false;
      }
      
      public function resetTimer() : void
      {
         this.hideTimer();
      }
      
      public function setCooldownTime(param1:String) : void
      {
         this.cooldownTime.cooldownTF.text = param1;
      }
      
      public function setProgressValue(param1:int) : void
      {
         this.description.descriptionTF.text = param1.toString() + PERCENT_TEXT;
      }
      
      public function setState(param1:int) : void
      {
         switch(param1)
         {
            case EPIC_CONSTS.RESUPPLY_READY:
               this.description.descriptionTF.text = EPIC_BATTLE.PROGRESS_TIMERS_ACTIVE;
               this.icon.gotoAndStop(ICON_ACTIVE_FRAME_LABEL);
               this.cooldownTime.visible = false;
               this.progressAnimation.play();
               this.progressAnimation.visible = true;
               this._actualState = param1;
               break;
            case EPIC_CONSTS.RESUPPLY_BLOCKED:
               this.description.descriptionTF.text = EPIC_BATTLE.PROGRESS_TIMERS_UNAVAILABLE;
               this.icon.gotoAndStop(ICON_UNAVAILABLE_FRAME_LABEL);
               this.cooldownTime.visible = true;
               this.progressAnimation.visible = false;
               this._actualState = param1;
               break;
            case EPIC_CONSTS.RESUPPLY_FULL:
               this.description.descriptionTF.text = EPIC_BATTLE.PROGRESS_TIMERS_FULLY_EQUIPPED;
               this.icon.gotoAndStop(ICON_ACTIVE_FRAME_LABEL);
               this.cooldownTime.visible = false;
               this.progressAnimation.visible = true;
               this.progressAnimation.gotoAndStop(1);
               this._actualState = param1;
         }
      }
      
      public function showTimer(param1:Boolean) : void
      {
         gotoAndPlay(SHOW_FRAME_LABEL);
         this._isShowing = true;
      }
      
      public function get isSmallSize() : Boolean
      {
         return this._isSmallSize;
      }
      
      public function set isSmallSize(param1:Boolean) : void
      {
         this._isSmallSize = param1;
      }
      
      public function setSettings(param1:NotificationTimerSettingVO) : void
      {
         this._typeId = param1.typeId;
      }
      
      public function get typeId() : String
      {
         return this._typeId;
      }
      
      public function setTimerFx(param1:ISecondaryTimerFX) : void
      {
      }
      
      override public function get isActive() : Boolean
      {
         return this._isActive;
      }
      
      override public function set isActive(param1:Boolean) : void
      {
         this._isActive = param1;
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
      
      public function setStaticText(param1:String, param2:String = "") : void
      {
      }
      
      public function get isShowing() : Boolean
      {
         return this._isShowing;
      }
      
      public function get actualWidth() : Number
      {
         return FULL_SIZE_WIDTH;
      }
      
      public function getStatusCallback() : IStatusNotificationCallback
      {
         return null;
      }
      
      override protected function getProgressBarMc() : MovieClip
      {
         return this.progressAnimation;
      }
      
      override protected function getTimerTF() : TextField
      {
         return this.cooldownTime.cooldownTF;
      }
      
      override protected function invokeAdditionalActionOnIntervalUpdate() : void
      {
         this.icon.gotoAndStop(ICON_UNAVAILABLE_FRAME_LABEL);
      }
      
      override protected function resetAnimState() : void
      {
      }
      
      override protected function onIntervalHideUpdateHandler() : void
      {
      }
      
      public function updateData(param1:StatusNotificationVO) : void
      {
         this.setProgressValue(param1.additionalInfo);
         updateRadialTimer(param1.totalTime,param1.currentTime);
         this.setState(param1.additionalState);
      }
      
      override protected function getStartFrame() : int
      {
         return START_FRAME;
      }
      
      override protected function getEndFrame() : int
      {
         return END_FRAME;
      }
   }
}
