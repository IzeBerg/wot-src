package net.wg.gui.lobby.personalMissions.events
{
   import flash.events.Event;
   
   public class StatusFooterEvent extends Event
   {
      
      public static const SKIP_TASK:String = "skip_task";
       
      
      public function StatusFooterEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
