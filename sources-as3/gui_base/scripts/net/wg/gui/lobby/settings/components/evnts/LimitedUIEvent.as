package net.wg.gui.lobby.settings.components.evnts
{
   import flash.events.Event;
   
   public class LimitedUIEvent extends Event
   {
      
      public static const TURN_OFF:String = "turnOff";
       
      
      public function LimitedUIEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new LimitedUIEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("LimitedUIEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
