package net.wg.infrastructure.events
{
   import flash.events.Event;
   
   public class DAAPISortingEvent extends Event
   {
      
      public static const ON_DAAPI_SORTING_COMPLETE:String = "onDAAPISortingComplete";
       
      
      public var newSelectedIndex:int = -1;
      
      public function DAAPISortingEvent(param1:String, param2:int)
      {
         super(param1);
         this.newSelectedIndex = param2;
      }
      
      override public function clone() : Event
      {
         return new DAAPISortingEvent(type,this.newSelectedIndex);
      }
   }
}
