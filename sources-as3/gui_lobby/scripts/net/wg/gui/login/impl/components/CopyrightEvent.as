package net.wg.gui.login.impl.components
{
   import flash.events.Event;
   
   public class CopyrightEvent extends Event
   {
      
      public static const TO_LEGAL:String = "toLegal";
       
      
      public function CopyrightEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new CopyrightEvent(type,bubbles,cancelable);
      }
   }
}
