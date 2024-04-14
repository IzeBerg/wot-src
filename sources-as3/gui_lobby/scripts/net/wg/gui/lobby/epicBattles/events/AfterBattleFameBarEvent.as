package net.wg.gui.lobby.epicBattles.events
{
   import flash.events.Event;
   
   public class AfterBattleFameBarEvent extends Event
   {
      
      public static const LEVEL_UP:String = "levelUp";
      
      public static const BAR_FILLED:String = "barFilled";
      
      public static const START_ANIM:String = "startAnim";
       
      
      public function AfterBattleFameBarEvent(param1:String, param2:Boolean = true, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new AfterBattleFameBarEvent(type,bubbles,cancelable);
      }
   }
}
