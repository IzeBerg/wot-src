package net.wg.gui.battle.events
{
   import flash.events.Event;
   
   public class RepairAnimEvent extends Event
   {
      
      public static const ANIM_COMPLETE:String = "RepairAnimEvent_ANIM_COMPLETE";
      
      public static const ANIM_HIDE:String = "RepairAnimEvent_ANIM_HIDE";
       
      
      public function RepairAnimEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new RepairAnimEvent(type,bubbles,cancelable);
      }
   }
}
