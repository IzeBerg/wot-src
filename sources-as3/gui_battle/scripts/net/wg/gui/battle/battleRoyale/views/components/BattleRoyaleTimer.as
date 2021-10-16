package net.wg.gui.battle.battleRoyale.views.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.generated.BATTLE_NOTIFICATIONS_TIMER_COLORS;
   import net.wg.gui.battle.components.interfaces.IStatusNotification;
   import net.wg.gui.battle.components.interfaces.IStatusNotificationCallback;
   import net.wg.gui.battle.views.destroyTimers.SecondaryTimerBase;
   import net.wg.gui.battle.views.destroyTimers.data.NotificationTimerSettingVO;
   import net.wg.gui.battle.views.destroyTimers.data.StatusNotificationVO;
   import net.wg.gui.components.controls.TextFieldContainer;
   import net.wg.utils.IClassFactory;
   
   public class BattleRoyaleTimer extends SecondaryTimerBase implements IStatusNotification
   {
      
      public static const FULL_SIZE_FRAME_LABEL:String = "fullSize";
      
      public static const SMALL_SIZE_FRAME_LABEL:String = "smallSize";
      
      private static const SHOW_FRAME_LABEL:String = "show";
      
      private static const HIDE_FRAME_LABEL:String = "hide";
      
      private static const DESC_TEXT_COLOR:Object = {};
      
      private static const START_FRAME:int = 0;
      
      private static const END_FRAME:int = 100;
      
      private static const CROPPED_SIZE_WIDTH:uint = 100;
      
      private static const CROPPED_SIZE_PADDING:uint = 15;
      
      private static const FULL_SIZE_PADDING:uint = 70;
      
      private static const TIMER_CONTAINER_X:uint = 20;
      
      {
         DESC_TEXT_COLOR[BATTLE_NOTIFICATIONS_TIMER_COLORS.ORANGE] = 16757350;
         DESC_TEXT_COLOR[BATTLE_NOTIFICATIONS_TIMER_COLORS.GREEN] = 15137433;
         DESC_TEXT_COLOR[BATTLE_NOTIFICATIONS_TIMER_COLORS.RED] = 15626240;
      }
      
      public var bg:MovieClip = null;
      
      public var icon:MovieClip = null;
      
      public var timerContainer:BattleRoyaleTimerContainer = null;
      
      public var desc:TextFieldContainer = null;
      
      private var _iconContent:MovieClip = null;
      
      private var _secString:String = "";
      
      private var _isFullSize:Boolean = true;
      
      private var _isShowing:Boolean = false;
      
      private var _statusCallback:IStatusNotificationCallback;
      
      public function BattleRoyaleTimer()
      {
         super();
         this._secString = App.utils.locale.makeString(INGAME_GUI.STUN_SECONDS);
         init(true,true);
      }
      
      override public function cropSize() : Boolean
      {
         this.bg.visible = false;
         this.desc.visible = false;
         this.timerContainer.cropSize();
         if(this._iconContent)
         {
            this._iconContent.gotoAndStop(SMALL_SIZE_FRAME_LABEL);
         }
         this._isFullSize = false;
         recalculateTimeRelatedValues();
         return true;
      }
      
      override public function fullSize() : Boolean
      {
         this.desc.visible = true;
         this.bg.visible = true;
         this.timerContainer.fullSize();
         if(this._iconContent)
         {
            this._iconContent.gotoAndStop(FULL_SIZE_FRAME_LABEL);
         }
         this._isFullSize = true;
         recalculateTimeRelatedValues();
         return true;
      }
      
      override public function hideTimer() : void
      {
         gotoAndPlay(HIDE_FRAME_LABEL);
         this._isShowing = false;
      }
      
      override public function setSettings(param1:NotificationTimerSettingVO) : void
      {
         this.setIcon(param1.iconName);
         if(DESC_TEXT_COLOR[param1.color])
         {
            this.desc.textColor = DESC_TEXT_COLOR[param1.color];
         }
         this.bg.gotoAndStop(param1.color);
         this.timerContainer.countdownVisible = param1.countdownVisible;
         super.setSettings(param1);
      }
      
      override public function setSpeed(param1:Number) : void
      {
         super.setSpeed(param1);
         var _loc2_:BattleRoyaleIconContent = this._iconContent as BattleRoyaleIconContent;
         if(_loc2_)
         {
            if(param1 == 0)
            {
               _loc2_.animation.stop();
            }
            else
            {
               _loc2_.animation.play();
            }
         }
      }
      
      override public function setStaticText(param1:String, param2:String = "") : void
      {
         this.timerContainer.setTitle(param1);
         this.desc.label = param2;
      }
      
      override public function showTimer(param1:Boolean) : void
      {
         gotoAndPlay(SHOW_FRAME_LABEL);
         this._isShowing = true;
      }
      
      override protected function getTimeFormatted(param1:int) : String
      {
         if(this._isFullSize)
         {
            return super.getTimeFormatted(param1);
         }
         return param1.toString();
      }
      
      override protected function setTimerTimeString() : void
      {
         if(this._isFullSize)
         {
            super.setTimerTimeString();
         }
         else
         {
            this.timerContainer.setTime(lastStrTime + this._secString);
         }
      }
      
      override protected function onDispose() : void
      {
         stop();
         this.bg = null;
         if(this._iconContent && this.icon.contains(this._iconContent))
         {
            this.icon.removeChild(this._iconContent);
         }
         this.icon = null;
         this.timerContainer.dispose();
         this.timerContainer = null;
         this.desc.dispose();
         this.desc = null;
         this._iconContent = null;
         if(this._statusCallback)
         {
            this._statusCallback.dispose();
            this._statusCallback = null;
         }
         super.onDispose();
      }
      
      override protected function getProgressBarMc() : MovieClip
      {
         return this.icon;
      }
      
      override protected function getStartFrame() : int
      {
         return START_FRAME;
      }
      
      override protected function getEndFrame() : int
      {
         return END_FRAME;
      }
      
      override protected function getTimerTF() : TextField
      {
         return this.timerContainer.timeTF;
      }
      
      override protected function invokeAdditionalActionOnIntervalUpdate() : void
      {
      }
      
      override protected function resetAnimState() : void
      {
      }
      
      public function getStatusCallback() : IStatusNotificationCallback
      {
         return this._statusCallback;
      }
      
      public function updateViewID(param1:String, param2:Boolean, param3:int = -1) : void
      {
      }
      
      private function setIcon(param1:String) : void
      {
         var _loc2_:IClassFactory = null;
         var _loc3_:Class = null;
         if(this._iconContent == null)
         {
            _loc2_ = App.utils.classFactory;
            _loc3_ = _loc2_.getClass(param1);
            this._iconContent = new _loc3_();
            this._iconContent.gotoAndStop(!!this._isFullSize ? FULL_SIZE_FRAME_LABEL : SMALL_SIZE_FRAME_LABEL);
            this._iconContent.x = -this._iconContent.width >> 1;
            this._iconContent.y = -this._iconContent.height >> 1;
            this.icon.addChild(this._iconContent);
            if(this._iconContent is IStatusNotificationCallback)
            {
               this._statusCallback = this._iconContent as IStatusNotificationCallback;
            }
         }
      }
      
      public function get actualWidth() : Number
      {
         if(this._isFullSize)
         {
            return TIMER_CONTAINER_X + this.timerContainer.actualWidth + FULL_SIZE_PADDING;
         }
         return CROPPED_SIZE_WIDTH + CROPPED_SIZE_PADDING;
      }
      
      public function get isShowing() : Boolean
      {
         return this._isShowing;
      }
      
      public function updateData(param1:StatusNotificationVO) : void
      {
         this.setStaticText(param1.title,param1.description);
         this.updateViewID(param1.viewSubType,false);
         updateRadialTimer(param1.totalTime,param1.currentTime);
      }
   }
}
