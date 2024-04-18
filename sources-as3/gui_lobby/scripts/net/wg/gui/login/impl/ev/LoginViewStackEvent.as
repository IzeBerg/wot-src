package net.wg.gui.login.impl.ev
{
   import flash.events.Event;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public class LoginViewStackEvent extends Event
   {
      
      public static var NEED_UPDATE:String = "need_update";
      
      public static var VIEW_CHANGED:String = "view_changed";
       
      
      public var view:IUIComponentEx;
      
      public var linkage:String;
      
      public function LoginViewStackEvent(param1:String, param2:IUIComponentEx, param3:String, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.view = param2;
         this.linkage = param3;
      }
      
      override public function clone() : Event
      {
         return new LoginViewStackEvent(type,this.view,this.linkage,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("ViewStackEvent","view","linkage","type","bubbles","cancelable","eventPhase");
      }
   }
}
