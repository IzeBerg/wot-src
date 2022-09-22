package net.wg.gui.components.advanced.events
{
   import flash.events.Event;
   
   public class ViewHeaderEvent extends Event
   {
      
      public static const BACK_BTN_CLICK:String = "backBtnClick";
       
      
      public function ViewHeaderEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new ViewHeaderEvent(type,bubbles,cancelable);
      }
   }
}
