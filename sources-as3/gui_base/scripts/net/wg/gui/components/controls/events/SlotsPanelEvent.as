package net.wg.gui.components.controls.events
{
   import flash.events.Event;
   
   public class SlotsPanelEvent extends Event
   {
      
      public static const NEED_REPOSITION:String = "needReposition";
      
      public static const ON_DATA_SET:String = "onDataSet";
       
      
      public function SlotsPanelEvent(param1:String)
      {
         super(param1,true,true);
      }
   }
}
