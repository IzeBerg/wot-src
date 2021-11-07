package net.wg.gui.battle.eventBattle.views.bossIndicatorProgress
{
   import flash.events.Event;
   
   public class BossIndicatorEvent extends Event
   {
      
      public static const INDICATOR_ENABLED:String = "indicatorEnabled";
      
      public static const BOSS_INDICATOR_EVENT:String = "BossIndicatorEvent";
       
      
      public function BossIndicatorEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new BossIndicatorEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString(BOSS_INDICATOR_EVENT,"type","bubbles","cancelable");
      }
   }
}
