package net.wg.gui.login.impl.ev
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   
   public final class LoginEvent extends Event
   {
      
      public static const TOKEN_RESET:String = "eventResetToken";
      
      public static const LOGIN_BY_SOCIAL:String = "loginBySocial";
      
      public static const FOCUS_INIT:String = "focusInit";
      
      public static const SUBMIT:String = "submit";
      
      public static const ON_REGISTER_LINK_CLICK:String = "onRegisterClick";
      
      public static const ON_RECOVERY_LINK_CLICK:String = "onRecoveryClick";
      
      public static const ON_INPUT_CHANGE:String = "onInputChange";
      
      public static const ON_REMEMBER_CHANGE:String = "onRememberChange";
      
      public static const ON_CHANGE_ACCOUNT_CLICK:String = "onChangeAccountClick";
      
      public static const ON_SUBMIT_WITHOUT_TOKEN:String = "onSubmitWithoutToken";
       
      
      public var focusTarget:InteractiveObject = null;
      
      public var isRemember:Boolean = false;
      
      public var socialId:String = null;
      
      public function LoginEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:InteractiveObject = null, param5:Boolean = false, param6:String = null)
      {
         super(param1,param2,param3);
         this.focusTarget = param4;
         this.isRemember = param5;
         this.socialId = param6;
      }
      
      override public function clone() : Event
      {
         return new LoginEvent(type,bubbles,cancelable,this.focusTarget,this.isRemember,this.socialId);
      }
      
      override public function toString() : String
      {
         return formatToString("LoginEvent","type","bubbles","cancelable","focusTarget","isRemember","socialId");
      }
   }
}
