package net.wg.infrastructure.events
{
   import flash.events.Event;
   
   public class UniversalBtnEvent extends Event
   {
      
      public static const CLEAR_STYLE:String = "onClearStyle";
       
      
      public function UniversalBtnEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new UniversalBtnEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("UniversalBtnEvent","bubbles","cancelable","eventPhase");
      }
   }
}
