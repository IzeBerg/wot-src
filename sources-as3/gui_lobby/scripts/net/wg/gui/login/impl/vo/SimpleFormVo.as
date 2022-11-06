package net.wg.gui.login.impl.vo
{
   import scaleform.clik.data.DataProvider;
   
   public class SimpleFormVo extends FormBaseVo
   {
       
      
      public var memberMe:Boolean = false;
      
      public var memberMeVisible:Boolean = false;
      
      public var loginName:String = "";
      
      public var pwd:String = "";
      
      public var isIgrCredentialsReset:Boolean = false;
      
      public var showRecoveryLink:Boolean = false;
      
      public var autoLoginKey:String = "";
      
      public var capsLockState:Boolean = false;
      
      public var keyboardLang:String = "";
      
      public var isShowSocial:Boolean = false;
      
      public var socialList:DataProvider = null;
      
      public var showRegisterLink:Boolean = true;
      
      public function SimpleFormVo(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this.socialList = null;
         super.onDispose();
      }
   }
}
