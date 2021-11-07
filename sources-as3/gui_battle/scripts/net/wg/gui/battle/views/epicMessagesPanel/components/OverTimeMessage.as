package net.wg.gui.battle.views.epicMessagesPanel.components
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.views.epicMessagesPanel.data.OverTimeMessageVO;
   import net.wg.gui.battle.views.gameMessagesPanel.components.MessageContainerBase;
   import net.wg.gui.battle.views.gameMessagesPanel.data.GameMessageVO;
   import net.wg.utils.IScheduler;
   
   public class OverTimeMessage extends MessageContainerBase
   {
      
      private static const STARTING_TIME:int = 90;
      
      private static const TIMER_FRAMES:int = 94;
      
      private static const ERROR_CONVERTING_VO:String = "[OverTimeMessage] setData object was not in correct structure, could not convert to proper VO";
      
      private static const ZERO_STRING:String = "0";
      
      private static const SEMICOLON_STRING:String = ":";
      
      private static const TIMER_REPEAT_COUNT:int = 5;
      
      private static const MILISECONDS:int = 1000;
      
      private static const ONE_MINUTE_IN_SECONDS:int = 60;
      
      private static const ZERO_PREFIX_THRESHOLD:int = 10;
       
      
      public var mainTextMc:MovieClip = null;
      
      public var timerIcon:MovieClip = null;
      
      private var _msgDataVO:OverTimeMessageVO = null;
      
      private var _repetitions:int = 0;
      
      private var _overTimeOffset:int = 0;
      
      private var _scheduler:IScheduler = null;
      
      public function OverTimeMessage()
      {
         super();
         this._scheduler = App.utils.scheduler;
      }
      
      private static function getTimeString(param1:int) : String
      {
         var _loc2_:Number = param1 % ONE_MINUTE_IN_SECONDS;
         var _loc3_:Number = Math.floor(param1 / ONE_MINUTE_IN_SECONDS);
         return (_loc3_ >= ZERO_PREFIX_THRESHOLD ? Values.EMPTY_STR : ZERO_STRING) + _loc3_.toString() + SEMICOLON_STRING + (_loc2_ >= ZERO_PREFIX_THRESHOLD ? Values.EMPTY_STR : ZERO_STRING) + Math.floor(_loc2_).toString();
      }
      
      override public function setData(param1:GameMessageVO) : void
      {
         messageData = param1;
         var _loc2_:OverTimeMessageVO = param1.msgData as OverTimeMessageVO;
         App.utils.asserter.assertNotNull(_loc2_,ERROR_CONVERTING_VO);
         this._msgDataVO = _loc2_;
         this.mainTextMc.titleTF.text = _loc2_.title;
         this.mainTextMc.subtitleTF.text = getTimeString(_loc2_.timestamp);
         this._overTimeOffset = _loc2_.timestamp;
         this._repetitions = -1;
         this._scheduler.scheduleRepeatableTask(this.updateTimer,MILISECONDS,TIMER_REPEAT_COUNT);
      }
      
      override protected function onDispose() : void
      {
         this._scheduler.cancelTask(this.updateTimer);
         this._scheduler = null;
         this.mainTextMc = null;
         this.timerIcon = null;
         this._msgDataVO = null;
         super.onDispose();
      }
      
      private function updateTimer() : void
      {
         ++this._repetitions;
         var _loc1_:int = this._overTimeOffset - this._repetitions;
         this.mainTextMc.subtitleTF.text = getTimeString(_loc1_);
         var _loc2_:int = TIMER_FRAMES - Math.floor(TIMER_FRAMES * (_loc1_ / STARTING_TIME));
         this.timerIcon.gotoAndStop(_loc2_);
      }
   }
}
