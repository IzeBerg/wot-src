package net.wg.gui.battle.views.destroyTimers
{
   import net.wg.data.constants.generated.BATTLE_NOTIFICATIONS_TIMER_LINKAGES;
   
   public class PoiTimer extends StatusNotificationTimer
   {
      
      private static const HIDE_TIMER_INTERVAL:int = 75;
       
      
      public function PoiTimer()
      {
         super();
      }
      
      override protected function initTimers(param1:String = "destroyTimerUI", param2:String = "secondaryTimerUI") : void
      {
         super.initTimers(BATTLE_NOTIFICATIONS_TIMER_LINKAGES.POI_MAIN_TIMER_UI,BATTLE_NOTIFICATIONS_TIMER_LINKAGES.POI_SECONDARY_TIMER_UI);
         if(destroyTimer)
         {
            destroyTimer.hideTimerInterval = HIDE_TIMER_INTERVAL;
         }
      }
   }
}
