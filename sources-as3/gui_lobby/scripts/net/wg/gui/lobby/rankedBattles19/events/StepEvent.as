package net.wg.gui.lobby.rankedBattles19.events
{
   import flash.events.Event;
   
   public class StepEvent extends Event
   {
      
      public static const STEP_READY:String = "step_ready";
      
      public static const STEP_ANIM_IN_PROGRESS:String = "step_anim_in_progress";
      
      public static const ALL_STEPS_READY:String = "all_steps_ready";
       
      
      public var state:String = "";
      
      public function StepEvent(param1:String, param2:String = "", param3:Boolean = true, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.state = param2;
      }
      
      override public function clone() : Event
      {
         return new StepEvent(type,this.state,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("StepEvent","type","state","bubbles","cancelable");
      }
   }
}
