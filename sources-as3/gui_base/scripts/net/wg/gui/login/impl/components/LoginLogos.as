package net.wg.gui.login.impl.components
{
   import flash.display.Sprite;
   import net.wg.gui.components.common.BaseLogoView;
   import net.wg.gui.login.impl.ev.LoginLogosEvent;
   
   public class LoginLogos extends BaseLogoView
   {
       
      
      public var bounds:Sprite = null;
      
      public function LoginLogos()
      {
         super();
      }
      
      override public function setLocale(param1:String) : void
      {
         if(hasOverride(param1))
         {
            gotoAndStop(param1);
            this.logoChange();
         }
         else
         {
            this.defLogo();
         }
      }
      
      public function defLogo() : void
      {
         this.logoChange();
      }
      
      private function logoChange() : void
      {
         dispatchEvent(new LoginLogosEvent(LoginLogosEvent.CHANGE,false,false,this.bounds.width));
      }
   }
}
