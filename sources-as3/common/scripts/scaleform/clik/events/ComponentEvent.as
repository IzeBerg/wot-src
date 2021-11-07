package scaleform.clik.events
{
   import flash.events.Event;
   
   public class ComponentEvent extends Event
   {
      
      public static const STATE_CHANGE:String = "stateChange";
      
      public static const SHOW:String = "show";
      
      public static const HIDE:String = "hide";
       
      
      public function ComponentEvent(param1:String, param2:Boolean = false, param3:Boolean = true)
      {
         super(param1,param2,param3);
      }
   }
}
