package net.wg.white_tiger.gui.battle.views.wtBattleTimer
{
   import flash.events.Event;
   
   public class BattleTimerEvent extends Event
   {
      
      public static const SHOW_GLITCH_ANIMATION:String = "showGlitchAnimation";
       
      
      public function BattleTimerEvent(param1:String, param2:Boolean = false, param3:Boolean = true)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new BattleTimerEvent(type,bubbles,cancelable);
      }
   }
}
