package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _6eecb1d4042366533d161bd5a1ac41ca6977f0860e3bf8a1b9a93225c0461b06_flash_display_Sprite extends Sprite
   {
       
      
      public function _6eecb1d4042366533d161bd5a1ac41ca6977f0860e3bf8a1b9a93225c0461b06_flash_display_Sprite()
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
