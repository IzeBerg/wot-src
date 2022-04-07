package net.wg.gui.login.impl.ev
{
   import flash.events.Event;
   import net.wg.gui.components.common.serverStats.ServerVO;
   
   public final class LoginServerDDEvent extends Event
   {
      
      public static const ON_CHANGE_LISTEN_CSIS:String = "onChangeListenCSIS";
      
      public static const ON_SERVER_CHANGE:String = "onServerChange";
       
      
      public var serverVO:ServerVO = null;
      
      public var isListenCSIS:Boolean = false;
      
      public var selectedIndex:Number = 0;
      
      public function LoginServerDDEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:ServerVO = null, param5:Boolean = false, param6:Number = 0)
      {
         super(param1,param2,param3);
         this.serverVO = param4;
         this.isListenCSIS = param5;
         this.selectedIndex = param6;
      }
      
      override public function clone() : Event
      {
         return new LoginServerDDEvent(type,bubbles,cancelable,this.serverVO,this.isListenCSIS,this.selectedIndex);
      }
      
      override public function toString() : String
      {
         return formatToString("LoginServerDDEvent","type","bubbles","cancelable","serverVO","isListenCSIS","selectedIndex");
      }
   }
}
