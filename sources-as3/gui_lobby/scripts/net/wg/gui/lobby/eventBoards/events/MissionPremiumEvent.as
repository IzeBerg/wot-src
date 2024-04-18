package net.wg.gui.lobby.eventBoards.events
{
   import flash.events.Event;
   
   public class MissionPremiumEvent extends Event
   {
      
      public static const BUTTON_DETAILS_CLICK:String = "buttonDetailsClick";
       
      
      public function MissionPremiumEvent(param1:String, param2:Boolean = true, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new MissionPremiumEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("EventIDEvent","type","id","bubbles","cancelable");
      }
   }
}
