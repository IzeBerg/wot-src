package net.wg.gui.battle.epicBattle.battleloading.events
{
   import flash.events.Event;
   
   public class EpicBattleLoadingEvent extends Event
   {
      
      public static const VISIBILITY_CHANGED:String = "onVisibilityChanged";
       
      
      public function EpicBattleLoadingEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new EpicBattleLoadingEvent(type,bubbles,cancelable);
      }
   }
}
