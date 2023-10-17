package net.wg.gui.events
{
   import flash.events.Event;
   
   public class TechniqueListComponentEvent extends Event
   {
      
      public static const SELECTED_COLUMN_CHANGE:String = "selectedColumnChange";
       
      
      public var selectedColumn:int = -1;
      
      public var selectedColumnSorting:String = null;
      
      public function TechniqueListComponentEvent(param1:String, param2:int, param3:String)
      {
         super(param1,bubbles,cancelable);
         this.selectedColumn = param2;
         this.selectedColumnSorting = param3;
      }
      
      override public function clone() : Event
      {
         return new TechniqueListComponentEvent(type,this.selectedColumn,this.selectedColumnSorting);
      }
   }
}
