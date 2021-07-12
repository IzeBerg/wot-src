package net.wg.gui.events
{
   import flash.events.Event;
   
   public class SortingEvent extends Event
   {
      
      public static const SORT_DIRECTION_CHANGED:String = "sortDirectionChanged";
      
      public static const SELECTED_DATA_CHANGED:String = "selDataChanged";
       
      
      public function SortingEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
