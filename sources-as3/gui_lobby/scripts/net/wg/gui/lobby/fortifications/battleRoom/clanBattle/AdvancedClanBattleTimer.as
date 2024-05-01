package net.wg.gui.lobby.fortifications.battleRoom.clanBattle
{
   import net.wg.gui.lobby.fortifications.events.ClanBattleTimerEvent;
   
   public class AdvancedClanBattleTimer extends ClanBattleTimer
   {
      
      private static const ALERT_MIN_TIME:int = 0;
      
      private static const ALERT_SEC_TIME:int = 10;
       
      
      private var isInAlertState:Boolean = false;
      
      public function AdvancedClanBattleTimer()
      {
         super();
         setVerticalAlign();
      }
      
      override public function timerTick() : void
      {
         super.timerTick();
         if(this.isInAlertState)
         {
            dispatchEvent(new ClanBattleTimerEvent(ClanBattleTimerEvent.ALERT_TICK));
         }
      }
      
      override protected function updateFilters() : void
      {
         var _loc1_:Array = [];
         if(_model)
         {
            if(currentLabel == NORMAL_STATE)
            {
               _loc1_ = getGlowFilter(_model.glowColor);
            }
            else if(currentLabel == ALERT_STATE)
            {
               _loc1_ = getGlowFilter(_model.alertGlowColor);
            }
         }
         minutes.filters = _loc1_;
         seconds.filters = _loc1_;
         separator.filters = _loc1_;
      }
      
      override protected function updateText() : void
      {
         var _loc1_:int = getMinutes();
         var _loc2_:int = getSeconds();
         var _loc3_:Boolean = false;
         if(_loc1_ == ALERT_MIN_TIME && _loc2_ <= ALERT_SEC_TIME)
         {
            if(currentLabel != ALERT_STATE)
            {
               gotoAndStop(ALERT_STATE);
               _loc3_ = true;
               this.isInAlertState = true;
            }
         }
         else if(currentLabel != NORMAL_STATE)
         {
            gotoAndStop(NORMAL_STATE);
            _loc3_ = true;
            this.isInAlertState = false;
         }
         if(_loc3_)
         {
            this.updateFilters();
            updateSeparator();
            setVerticalAlign();
         }
         super.updateText();
      }
      
      override protected function replaceFormatter(param1:String) : String
      {
         if(currentLabel == NORMAL_STATE)
         {
            return super.replaceFormatter(param1);
         }
         if(currentLabel == ALERT_STATE)
         {
            return _model.alertHtmlFormatter.replace("###",param1);
         }
         return "error";
      }
   }
}
