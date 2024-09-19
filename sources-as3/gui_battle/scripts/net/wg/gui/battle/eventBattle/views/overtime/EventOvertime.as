package net.wg.gui.battle.eventBattle.views.overtime
{
   import fl.transitions.easing.Strong;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   import net.wg.gui.battle.components.preBattleTimer.TimerAnim;
   import net.wg.gui.battle.eventBattle.views.EventBattlePage;
   import net.wg.gui.battle.eventBattle.views.battleHints.EventBattleHint;
   import net.wg.gui.battle.eventBattle.views.helpers.IAnimateAlpha;
   import net.wg.gui.components.controls.TextFieldContainer;
   import net.wg.infrastructure.base.meta.IEventOvertimeMeta;
   import net.wg.infrastructure.base.meta.impl.EventOvertimeMeta;
   import scaleform.clik.motion.Tween;
   
   public class EventOvertime extends EventOvertimeMeta implements IEventOvertimeMeta, IAnimateAlpha
   {
      
      private static const ALPHA_TWEEN_TIME:uint = 1000;
       
      
      public var overtimeTextfieldHeader:TextFieldContainer = null;
      
      public var overtimeTextfieldSubheader:TextFieldContainer = null;
      
      public var overtimeBG:MovieClip = null;
      
      public var overtimeTimer:TimerAnim = null;
      
      private var _isOvertimeRunning:Boolean = false;
      
      private var _applyCountdownTimerImmediately:Boolean = false;
      
      private var _overtimeTimeProvider:Timer = null;
      
      private var _alphaTween:Tween = null;
      
      private var _eventBattleHintComponent:EventBattleHint = null;
      
      public function EventOvertime()
      {
         super();
         this._eventBattleHintComponent = this.getEventBattleHint();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.alpha = 0;
         this.overtimeTextfieldSubheader.autoSize = TextFieldAutoSize.CENTER;
         this.overtimeTextfieldSubheader.autoSize = TextFieldAutoSize.CENTER;
      }
      
      override protected function draw() : void
      {
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         this.overtimeTextfieldHeader.dispose();
         this.overtimeTextfieldHeader = null;
         this.overtimeTextfieldSubheader.dispose();
         this.overtimeTextfieldSubheader = null;
         this.overtimeBG = null;
         super.onDispose();
      }
      
      private function showOvertime(param1:int) : void
      {
         this._isOvertimeRunning = true;
         this.overtimeTimer.setTime(param1,true);
         this._overtimeTimeProvider = new Timer(1000,param1);
         this._overtimeTimeProvider.addEventListener(TimerEvent.TIMER,this.onOvertimeTimerTick);
         this._overtimeTimeProvider.addEventListener(TimerEvent.TIMER_COMPLETE,this.completeOvertime);
         this._overtimeTimeProvider.start();
         this.animateAlpha(0,1,ALPHA_TWEEN_TIME);
      }
      
      public function completeOvertime(param1:TimerEvent = null) : void
      {
         var event:TimerEvent = param1;
         if(this._overtimeTimeProvider)
         {
            this.resetOvertimeTimer();
         }
         this.clearTweens();
         this.animateAlpha(1,0,ALPHA_TWEEN_TIME);
         setTimeout(function():void
         {
            _isOvertimeRunning = false;
         },ALPHA_TWEEN_TIME);
      }
      
      private function resetOvertimeTimer() : void
      {
         this._overtimeTimeProvider.stop();
         this._overtimeTimeProvider.reset();
         this.overtimeTimer.stop();
      }
      
      private function onOvertimeTimerTick(param1:TimerEvent) : void
      {
         var _loc2_:int = param1.target.repeatCount - param1.target.currentCount;
         this.overtimeTimer.setTime(_loc2_,this._applyCountdownTimerImmediately);
         this.overtimeTimer.ownerVisibleChange(true);
      }
      
      public function animateAlpha(param1:Number, param2:Number, param3:uint) : void
      {
         this.clearTweens();
         this.alpha = param1;
         this._alphaTween = new Tween(param3,this,{"alpha":param2},{
            "ease":Strong.easeInOut,
            "onComplete":this.onAlphaTweenComplete
         });
      }
      
      public function onAlphaTweenComplete(param1:Tween) : void
      {
         this.clearTweens();
      }
      
      public function clearTweens() : void
      {
         if(this._alphaTween)
         {
            this._alphaTween.dispose();
            this._alphaTween = null;
         }
      }
      
      private function setOvertimeText(param1:Boolean) : void
      {
         if(param1)
         {
            this.overtimeTextfieldHeader.label = App.utils.locale.makeString(EVENT.BATTLEHINTS_WTOVERTIME_HEADER);
            this.overtimeTextfieldSubheader.label = App.utils.locale.makeString(EVENT.BATTLEHINTS_WTOVERTIME_BOSS);
         }
         else
         {
            this.overtimeTextfieldHeader.label = App.utils.locale.makeString(EVENT.BATTLEHINTS_WTOVERTIME_HEADER);
            this.overtimeTextfieldSubheader.label = App.utils.locale.makeString(EVENT.BATTLEHINTS_WTOVERTIME_HUNTERS);
         }
      }
      
      public function as_getOvertimeInfo(param1:Boolean, param2:Boolean) : void
      {
         this.setOvertimeText(param1);
         this._applyCountdownTimerImmediately = param2;
      }
      
      public function as_updateOvertimeTimer(param1:int) : void
      {
         if(param1 > 0)
         {
            if(this._eventBattleHintComponent && this._eventBattleHintComponent.hintContainer)
            {
               this._eventBattleHintComponent.hintContainer.hideHintImmediately();
            }
            this.showOvertime(param1);
         }
         else if(this._isOvertimeRunning)
         {
            this.completeOvertime(null);
         }
      }
      
      public function get isOvertimeRunning() : Boolean
      {
         return this._isOvertimeRunning;
      }
      
      public function getEventBattleHint() : EventBattleHint
      {
         if(this.parent is EventBattlePage && EventBattlePage(this.parent).eventMessage != null)
         {
            return EventBattlePage(this.parent).eventMessage;
         }
         return null;
      }
   }
}
