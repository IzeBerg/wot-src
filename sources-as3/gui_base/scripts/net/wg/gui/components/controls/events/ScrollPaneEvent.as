package net.wg.gui.components.controls.events
{
   import flash.events.Event;
   
   public class ScrollPaneEvent extends Event
   {
      
      public static const POSITION_CHANGED:String = "positionChanged";
       
      
      public function ScrollPaneEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new ScrollPaneEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("ScrollPaneEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
