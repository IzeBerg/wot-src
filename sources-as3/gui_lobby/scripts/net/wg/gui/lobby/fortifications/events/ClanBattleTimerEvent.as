package net.wg.gui.lobby.fortifications.events
{
   import flash.events.Event;
   
   public class ClanBattleTimerEvent extends Event
   {
      
      public static const ALERT_TICK:String = "alertTick";
       
      
      public function ClanBattleTimerEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
