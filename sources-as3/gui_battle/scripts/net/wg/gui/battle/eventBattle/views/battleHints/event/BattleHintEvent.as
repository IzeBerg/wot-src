package net.wg.gui.battle.eventBattle.views.battleHints.event
{
   import flash.events.Event;
   
   public class BattleHintEvent extends Event
   {
      
      public static const HINT_CHANGED:String = "hintChanged";
       
      
      public function BattleHintEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new BattleHintEvent(type);
      }
   }
}
