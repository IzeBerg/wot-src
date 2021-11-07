package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _99394b82277282d9c639439a093577f89e0eb452cbf568455b0110e5b7ee0b6f_flash_display_Sprite extends Sprite
   {
       
      
      public function _99394b82277282d9c639439a093577f89e0eb452cbf568455b0110e5b7ee0b6f_flash_display_Sprite()
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
