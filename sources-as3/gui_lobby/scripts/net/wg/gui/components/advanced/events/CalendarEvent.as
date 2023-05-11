package net.wg.gui.components.advanced.events
{
   import flash.events.Event;
   
   public class CalendarEvent extends Event
   {
      
      public static const DAY_ROLL_OUT:String = "dayRollOver";
      
      public static const DAY_ROLL_OVER:String = "dayRollOut";
      
      public static const DAY_CLICK:String = "dayClick";
      
      public static const DAY_SELECTED:String = "dateSelected";
      
      public static const MONTH_CHANGED:String = "monthChanged";
      
      public static const LAYOUT_CHANGED:String = "layoutChanged";
       
      
      public var displayDate:Date = null;
      
      public var selectedDate:Date = null;
      
      public function CalendarEvent(param1:String, param2:Date, param3:Date, param4:Boolean = false, param5:Boolean = false)
      {
         this.displayDate = param2;
         this.selectedDate = param3;
         super(param1,param4,param5);
      }
      
      override public function clone() : Event
      {
         return new CalendarEvent(type,this.displayDate,this.selectedDate,bubbles,cancelable);
      }
   }
}
