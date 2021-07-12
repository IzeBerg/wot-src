package net.wg.gui.events
{
   import flash.events.Event;
   
   public class ViewStackContentEvent extends Event
   {
      
      public static const VIEW_HIDE:String = "viewHide";
       
      
      public function ViewStackContentEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
