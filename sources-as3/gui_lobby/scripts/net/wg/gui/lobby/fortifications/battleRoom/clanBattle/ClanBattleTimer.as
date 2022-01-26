package net.wg.gui.lobby.fortifications.battleRoom.clanBattle
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleTimerVO;
   import net.wg.gui.lobby.fortifications.interfaces.IClanBattleTimer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class ClanBattleTimer extends MovieClip implements IClanBattleTimer, IDisposable
   {
      
      protected static const NORMAL_STATE:String = "normal";
      
      protected static const ALERT_STATE:String = "alert";
      
      private static const TIMER_SEPARATOR:String = ":";
      
      private static const TIMER_TICK_SEC:int = 1000;
      
      private static const STATE_FIRST_BATTLE:int = 0;
      
      private static const STATE_NEXT_BATTLE:int = 1;
      
      private static const GRATES_STRING:String = "###";
      
      private static const ZERO_STRING:String = "0";
       
      
      public var minutes:TextField = null;
      
      public var seconds:TextField = null;
      
      public var separator:TextField = null;
      
      public var leftTime:int = 0;
      
      protected var _model:ClanBattleTimerVO = null;
      
      private var _min:int = -1;
      
      private var _sec:int = -1;
      
      private var _date:Date = null;
      
      private var _uniqueIdentifier:Number = -1;
      
      private var _timerState:int = -1;
      
      private var _firstDeltaTime:Number = -1;
      
      public function ClanBattleTimer()
      {
         super();
         this.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      protected static function getGlowFilter(param1:Number) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Number = 1;
         var _loc4_:Number = 10;
         var _loc5_:Number = 10;
         var _loc6_:Number = 1.2;
         var _loc7_:Number = 3;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:GlowFilter = new GlowFilter(param1,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_);
         _loc2_.push(_loc10_);
         return _loc2_;
      }
      
      private static function formatTimeValue(param1:int) : String
      {
         return param1 < 10 ? ZERO_STRING + param1.toString() : param1.toString();
      }
      
      public function setData(param1:ClanBattleTimerVO) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._model = param1;
         this._timerState = this._model.state;
         if(this._model.useUniqueIdentifier)
         {
            if(this._uniqueIdentifier != this._model.uniqueIdentifier || this._firstDeltaTime != this._model.deltaTime)
            {
               this._uniqueIdentifier = this._model.uniqueIdentifier;
               this._firstDeltaTime = this._model.deltaTime;
               this.initTimer();
            }
         }
         else
         {
            this.initTimer();
         }
      }
      
      public function stopTimer() : void
      {
         App.utils.scheduler.cancelTask(this.timerHandler);
      }
      
      public function timerTick() : void
      {
         App.utils.scheduler.scheduleTask(this.timerHandler,TIMER_TICK_SEC);
      }
      
      public function formatDelta(param1:int) : void
      {
         this._date = new Date(null,null,null,null,null,param1);
      }
      
      public function dispose() : void
      {
         App.utils.scheduler.cancelTask(this.timerHandler);
         this.minutes = null;
         this.seconds = null;
         this.separator = null;
         this._model = null;
         this._date = null;
         this.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      protected function updateSeparator() : void
      {
         this.separator.htmlText = this.replaceFormatter(TIMER_SEPARATOR);
      }
      
      protected function getSeconds() : int
      {
         return this._date.getSeconds();
      }
      
      protected function getMinutes() : int
      {
         return this._date.getMinutes();
      }
      
      protected function updateText() : void
      {
         this.minutes.htmlText = this.replaceFormatter(formatTimeValue(this._min));
         this.seconds.htmlText = this.replaceFormatter(formatTimeValue(this._sec));
      }
      
      protected function replaceFormatter(param1:String) : String
      {
         return this._model.htmlFormatter.replace(GRATES_STRING,param1);
      }
      
      protected function updateFilters() : void
      {
         var _loc1_:Array = null;
         if(this._model && this._model.glowColor != Values.DEFAULT_INT)
         {
            _loc1_ = getGlowFilter(this._model.glowColor);
            this.minutes.filters = _loc1_;
            this.seconds.filters = _loc1_;
            this.separator.filters = _loc1_;
         }
      }
      
      private function initTimer() : void
      {
         this.updateFilters();
         this.updateSeparator();
         this.leftTime = this._model.deltaTime;
         this.timerHandler();
      }
      
      private function timerHandler() : void
      {
         if(this.leftTime <= 0)
         {
            this.updateDefaultText();
            this.stopTimer();
            return;
         }
         this.leftTime -= 1;
         this.updateLabels();
         this.timerTick();
      }
      
      private function updateDefaultText() : void
      {
         gotoAndStop(ALERT_STATE);
         this.minutes.htmlText = this.replaceFormatter(this._model.timerDefaultValue);
         this.seconds.htmlText = this.replaceFormatter(this._model.timerDefaultValue);
         this.updateFilters();
         this.updateSeparator();
         this.setVerticalAlign();
      }
      
      private function updateLabels() : void
      {
         this.formatDelta(this.leftTime);
         this._min = this.getMinutes();
         this._sec = this.getSeconds();
         this.updateText();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = Values.EMPTY_STR;
         switch(this._timerState)
         {
            case STATE_FIRST_BATTLE:
               _loc2_ = TOOLTIPS.STRONGHOLDS_TIMER_TIMETOBATTLE;
               break;
            case STATE_NEXT_BATTLE:
               _loc2_ = TOOLTIPS.STRONGHOLDS_TIMER_TIMETONEXTBATTLE;
         }
         this.showTooltip(_loc2_);
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function showTooltip(param1:String) : void
      {
         var _loc2_:String = App.toolTipMgr.getNewFormatter().addBody(param1,true).make();
         if(_loc2_.length > 0)
         {
            App.toolTipMgr.showComplex(_loc2_);
         }
      }
      
      protected function setVerticalAlign() : void
      {
         TextFieldEx.setVerticalAutoSize(this.minutes,TextFieldEx.VALIGN_CENTER);
         TextFieldEx.setVerticalAutoSize(this.seconds,TextFieldEx.VALIGN_CENTER);
         TextFieldEx.setVerticalAutoSize(this.separator,TextFieldEx.VALIGN_CENTER);
      }
   }
}
