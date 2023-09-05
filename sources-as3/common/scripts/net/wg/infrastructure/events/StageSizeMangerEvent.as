package net.wg.infrastructure.events
{
   import flash.events.Event;
   
   public class StageSizeMangerEvent extends Event
   {
      
      public static const BREAK_POINT_CHANGED:String = "StageSizeEvent.breakPointChanged";
       
      
      public function StageSizeMangerEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new StageSizeMangerEvent(type,bubbles,cancelable);
      }
   }
}
