package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _2c0df7fdc557ed3ccfa7d2afd88734d0bece849d201d0ead8bacbb455f8c15e2_flash_display_Sprite extends Sprite
   {
       
      
      public function _2c0df7fdc557ed3ccfa7d2afd88734d0bece849d201d0ead8bacbb455f8c15e2_flash_display_Sprite()
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
