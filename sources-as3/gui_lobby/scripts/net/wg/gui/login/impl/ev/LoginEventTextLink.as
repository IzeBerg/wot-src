package net.wg.gui.login.impl.ev
{
   import flash.events.Event;
   
   public final class LoginEventTextLink extends Event
   {
      
      public static const ON_TEXT_LINK_CLICK:String = "onTextLinkClick";
       
      
      public var linkId:String = null;
      
      public function LoginEventTextLink(param1:String, param2:Boolean = false, param3:Boolean = false, param4:String = null)
      {
         super(param1,param2,param3);
         this.linkId = param4;
      }
      
      override public function clone() : Event
      {
         return new LoginEventTextLink(type,bubbles,cancelable,this.linkId);
      }
      
      override public function toString() : String
      {
         return formatToString("LoginEventTextLink","type","bubbles","cancelable","linkId");
      }
   }
}
