package net.wg.gui.components.controls.events
{
   import flash.events.Event;
   
   public class ScrollEvent extends Event
   {
      
      public static const SCROLL_START:String = "scrollStart";
      
      public static const SCROLL_COMPLETE:String = "scrollComplete";
      
      public static const UPDATE_SIZE:String = "updateSize";
       
      
      public function ScrollEvent(param1:String, param2:Boolean = true, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
