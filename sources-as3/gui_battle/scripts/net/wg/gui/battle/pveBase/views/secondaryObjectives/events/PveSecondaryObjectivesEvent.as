package net.wg.gui.battle.pveBase.views.secondaryObjectives.events
{
   import flash.events.Event;
   
   public class PveSecondaryObjectivesEvent extends Event
   {
      
      public static const CHANGED:String = "PveSecondaryObjectivesEvent.CHANGED";
       
      
      public function PveSecondaryObjectivesEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new PveSecondaryObjectivesEvent(type,bubbles,cancelable);
      }
   }
}
