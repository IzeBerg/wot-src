package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _24112b9d35d8d602cf03f7123d27cb7a57ba69b4a631b76ed3f2c16369ff49c1_flash_display_Sprite extends Sprite
   {
       
      
      public function _24112b9d35d8d602cf03f7123d27cb7a57ba69b4a631b76ed3f2c16369ff49c1_flash_display_Sprite()
      {
         super();
      }
      
      public function allowDomainInRSL(... rest) : void
      {
         Security.allowDomain.apply(null,rest);
      }
      
      public function allowInsecureDomainInRSL(... rest) : void
      {
         Security.allowInsecureDomain.apply(null,rest);
      }
   }
}
