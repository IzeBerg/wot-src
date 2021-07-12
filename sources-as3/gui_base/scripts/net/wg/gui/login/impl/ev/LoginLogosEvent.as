package net.wg.gui.login.impl.ev
{
   import flash.events.Event;
   
   public class LoginLogosEvent extends Event
   {
      
      public static const CHANGE:String = "logoChange";
       
      
      public var logosWidth:Number = 0;
      
      public function LoginLogosEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Number = 0)
      {
         super(param1,param2,param3);
         this.logosWidth = param4;
      }
      
      override public function clone() : Event
      {
         return new LoginLogosEvent(type,bubbles,cancelable,this.logosWidth);
      }
      
      override public function toString() : String
      {
         return formatToString("LoginLogosEv","type","bubbles","logosWidth");
      }
   }
}
