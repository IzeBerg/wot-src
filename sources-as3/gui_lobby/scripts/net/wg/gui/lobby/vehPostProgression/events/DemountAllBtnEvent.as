package net.wg.gui.lobby.vehPostProgression.events
{
   import flash.events.Event;
   
   public class DemountAllBtnEvent extends Event
   {
      
      public static const DEMOUNT_ALL_CLICK:String = "demountAllClick";
       
      
      public function DemountAllBtnEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
