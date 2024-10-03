package net.wg.white_tiger.gui.battle.views.wtBattleHints
{
   import fl.transitions.easing.Strong;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import net.wg.gui.battle.components.preBattleTimer.TimerAnim;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.white_tiger.gui.battle.views.wtBattleHints.data.HintInfoVO;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.motion.Tween;
   
   public class InfoContainer extends MovieClip implements IDisposable
   {
      
      private static const TWEEN_TIME:uint = 500;
      
      private static const TIMER_Y_OFFSET:uint = 10;
      
      private static const OVERTIME_TIMER_SCALE:Number = 0.55;
      
      private static const OVERTIME_TIMER_OFFSET:Number = -90;
       
      
      public var txtMessage:TextContainer = null;
      
      public var icon:Image = null;
      
      public var bg:MovieClip = null;
      
      public var hintTimer:TimerContainer = null;
      
      public var overtimeTimer:TimerAnim = null;
      
      private var _overtimeTimeProvider:Timer = null;
      
      private var _disposed:Boolean = false;
      
      private var _alphaTween:Tween = null;
      
      private var _data:HintInfoVO = null;
      
      private var _initialBgY:int = 0;
      
      private var _initialMessageY:int = 0;
      
      public function InfoContainer()
      {
         super();
         this._initialBgY = this.bg.y;
         this._initialMessageY = this.txtMessage.y;
         this.overtimeTimer.visible = false;
         this.alpha = 0;
      }
      
      public function closeHint() : void
      {
         if(this._overtimeTimeProvider)
         {
            this._overtimeTimeProvider.stop();
            this._overtimeTimeProvider.reset();
         }
         this.hintTimer.stopTimer();
         this.clearTweens();
         this.alpha = 0;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.clearTweens();
         this.overtimeTimer.dispose();
         this.overtimeTimer = null;
         this._data = null;
         this.bg = null;
         this.hintTimer.dispose();
         this.hintTimer = null;
         this.txtMessage.dispose();
         this.txtMessage = null;
         this.icon.dispose();
         this.icon = null;
      }
      
      public function hideHint() : void
      {
         if(this._overtimeTimeProvider)
         {
            this._overtimeTimeProvider.stop();
            this._overtimeTimeProvider.reset();
            this.overtimeTimer.visible = false;
            this.overtimeTimer.ownerVisibleChange(false);
         }
         this.hintTimer.stopTimer();
         this.clearTweens();
         this.animateAlpha(1,0,TWEEN_TIME);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function showHint(param1:HintInfoVO) : void
      {
         this._data = param1;
         if(StringUtils.isNotEmpty(param1.iconSource))
         {
            this.icon.source = param1.iconSource;
         }
         if(StringUtils.isNotEmpty(param1.backgroundColor))
         {
            this.bg.gotoAndStop(param1.backgroundColor);
         }
         this.txtMessage.setText(param1.message);
         if(param1.useCountdownTimer)
         {
            this.hintTimer.visible = false;
            this.startOvertimeTimer(param1.timer);
         }
         else
         {
            this.overtimeTimer.visible = false;
            this.overtimeTimer.ownerVisibleChange(false);
            this.hintTimer.visible = true;
            this.hintTimer.startTimer(param1.timer);
         }
         this.updateLayout();
         this.animateAlpha(0,1,TWEEN_TIME);
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this.updateLayout();
         this.overtimeTimer.scaleX = this.overtimeTimer.scaleY = OVERTIME_TIMER_SCALE;
      }
      
      private function updateLayout() : void
      {
         this.bg.visible = this._data != null && StringUtils.isNotEmpty(this._data.backgroundColor);
         this.icon.visible = this._data != null && StringUtils.isNotEmpty(this._data.iconSource);
         this.bg.y = !!this.icon.visible ? Number(this._initialBgY) : Number(this._initialBgY - this._initialMessageY);
         this.txtMessage.y = !!this.icon.visible ? Number(this._initialMessageY) : Number(0);
         this.hintTimer.y = this.txtMessage.y + this.txtMessage.height + TIMER_Y_OFFSET | 0;
         this.overtimeTimer.x = width - width >> 1;
         this.overtimeTimer.y = OVERTIME_TIMER_OFFSET;
      }
      
      private function animateAlpha(param1:Number, param2:Number, param3:uint) : void
      {
         this.clearTweens();
         this.alpha = param1;
         this._alphaTween = new Tween(param3,this,{"alpha":param2},{
            "ease":Strong.easeInOut,
            "onComplete":this.onAlphaTweenComplete
         });
      }
      
      private function onAlphaTweenComplete(param1:Tween) : void
      {
         this.clearTweens();
      }
      
      private function clearTweens() : void
      {
         if(this._alphaTween)
         {
            this._alphaTween.dispose();
            this._alphaTween = null;
         }
      }
      
      private function startOvertimeTimer(param1:int) : void
      {
         this._overtimeTimeProvider = new Timer(1000,param1 / 1000);
         this._overtimeTimeProvider.addEventListener(TimerEvent.TIMER,this.onOvertimeTimerTick);
         this._overtimeTimeProvider.addEventListener(TimerEvent.TIMER_COMPLETE,this.onOvertimeTimerComplete);
         this._overtimeTimeProvider.start();
      }
      
      private function onOvertimeTimerTick(param1:TimerEvent) : void
      {
         var _loc2_:int = param1.target.repeatCount - param1.target.currentCount;
         this.overtimeTimer.setTime(_loc2_,false);
         if(!this.overtimeTimer.visible)
         {
            this.overtimeTimer.visible = true;
            this.overtimeTimer.ownerVisibleChange(true);
         }
      }
      
      private function onOvertimeTimerComplete(param1:TimerEvent) : void
      {
         this._overtimeTimeProvider.reset();
         this.overtimeTimer.visible = false;
         this.overtimeTimer.ownerVisibleChange(false);
      }
   }
}
