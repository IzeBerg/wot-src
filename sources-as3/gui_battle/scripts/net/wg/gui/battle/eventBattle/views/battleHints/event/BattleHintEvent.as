package net.wg.gui.battle.eventBattle.views.battleHints.event
{
   import flash.events.Event;
   
   public class BattleHintEvent extends Event
   {
      
      public static const START_APPEAR:String = "onResetShowAnimQP";
      
      public static const HIDING_COMPLETE:String = "hidingComplete";
       
      
      public function BattleHintEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new BattleHintEvent(type,bubbles,cancelable);
      }
   }
}
