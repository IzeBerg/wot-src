package net.wg.gui.lobby.missions.event
{
   import flash.events.Event;
   
   public class MissionDetailsTopPanelEvent extends Event
   {
      
      public static const CLOSE_CLICK:String = "closeClick";
       
      
      public function MissionDetailsTopPanelEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
