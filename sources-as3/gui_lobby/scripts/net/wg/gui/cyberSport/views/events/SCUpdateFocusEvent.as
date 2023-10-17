package net.wg.gui.cyberSport.views.events
{
   import flash.events.Event;
   
   public class SCUpdateFocusEvent extends Event
   {
      
      public static const UPDATE_FOCUS:String = "SCUpdateFocus";
      
      public static const CLEAR_FOCUS:String = "SCClearFocus";
       
      
      public function SCUpdateFocusEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
