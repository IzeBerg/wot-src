package net.wg.gui.components.controls.events
{
   import flash.events.Event;
   
   public class SortableScrollingListEvent extends Event
   {
      
      public static const SORT_APPLIED:String = "sort_applied";
       
      
      public function SortableScrollingListEvent(param1:String, param2:Boolean = false, param3:Boolean = true)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new SortableScrollingListEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("SortableScrollingListEvent","type","bubbles","cancelable");
      }
   }
}
