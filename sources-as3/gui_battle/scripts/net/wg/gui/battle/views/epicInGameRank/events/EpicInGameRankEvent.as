package net.wg.gui.battle.views.epicInGameRank.events
{
   import flash.events.Event;
   
   public class EpicInGameRankEvent extends Event
   {
      
      public static const LEVEL_UP_ANIMATION_COMPLETE:String = "levelUpAnimationComplete";
       
      
      public function EpicInGameRankEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new EpicInGameRankEvent(type,bubbles,cancelable);
      }
   }
}
