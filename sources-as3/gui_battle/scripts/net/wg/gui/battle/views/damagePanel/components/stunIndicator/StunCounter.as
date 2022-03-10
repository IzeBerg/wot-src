package net.wg.gui.battle.views.damagePanel.components.stunIndicator
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IScheduler;
   import scaleform.gfx.TextFieldEx;
   
   public class StunCounter extends MovieClip implements IDisposable
   {
      
      public static const STATE_SHOW:String = "show";
      
      public static const STATE_BASE:String = "base";
      
      public static const STATE_HIDE:String = "hide";
      
      public static const STATE_HIDDEN:String = "hidden";
      
      private static const REPEAT_INTERVAL:uint = 100;
      
      private static const MS_IN_SEC:uint = 1000;
       
      
      public var bgMc:MovieClip = null;
      
      public var timerMc:MovieClip = null;
      
      public var noiseMc:MovieClip = null;
      
      private var _stunTime:Number;
      
      private var _repeatCount:int = -1;
      
      private var _currentRepeatCount:int = -1;
      
      private var _secString:String = "";
      
      private var _noTranslateEnabled:Boolean = false;
      
      private var _scheduler:IScheduler;
      
      private var _disposed:Boolean = false;
      
      public function StunCounter()
      {
         this._scheduler = App.utils.scheduler;
         super();
         mouseChildren = false;
         mouseEnabled = false;
         this._secString = App.utils.locale.makeString(INGAME_GUI.STUN_SECONDS);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.clearTimeout();
         this._scheduler = null;
         this.bgMc = null;
         this.timerMc = null;
         this.noiseMc = null;
      }
      
      public function hideStun(param1:Boolean = false) : void
      {
         stop();
         this.clearTimeout();
         if(this.timerMc)
         {
            this.timerMc.labelTf.text = Values.EMPTY_STR;
         }
         if(param1)
         {
            gotoAndPlay(STATE_HIDE);
         }
         else
         {
            gotoAndStop(STATE_HIDDEN);
         }
      }
      
      public function showStun(param1:Number, param2:Boolean = true) : void
      {
         this.clearTimeout();
         this._stunTime = param1 * MS_IN_SEC;
         this._repeatCount = this._stunTime / REPEAT_INTERVAL;
         if(this._repeatCount <= 0)
         {
            gotoAndStop(STATE_HIDDEN);
         }
         else
         {
            this._currentRepeatCount = 0;
            if(param2)
            {
               gotoAndPlay(STATE_SHOW);
            }
            else
            {
               gotoAndStop(STATE_BASE);
            }
            this.runInterval();
         }
      }
      
      public function updateStun(param1:int) : void
      {
         gotoAndStop(STATE_BASE);
         this.setStunText(param1);
      }
      
      private function runInterval() : void
      {
         this._scheduler.scheduleRepeatableTask(this.onIntervalUpdateHandler,REPEAT_INTERVAL,this._repeatCount);
      }
      
      private function onIntervalUpdateHandler() : void
      {
         var _loc1_:int = 0;
         ++this._currentRepeatCount;
         if(this._currentRepeatCount > this._repeatCount)
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
         else
         {
            _loc1_ = Math.ceil((this._stunTime - this._currentRepeatCount * REPEAT_INTERVAL) / MS_IN_SEC);
            this.setStunText(_loc1_);
         }
      }
      
      private function clearTimeout() : void
      {
         this._scheduler.cancelTask(this.onIntervalUpdateHandler);
      }
      
      private function setStunText(param1:Number) : void
      {
         if(!this._noTranslateEnabled)
         {
            this._noTranslateEnabled = true;
            TextFieldEx.setNoTranslate(TextField(this.timerMc.labelTf),true);
         }
         this.timerMc.labelTf.text = param1 + this._secString;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
