package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _87ebc5cac5e7f6d869c7b2734d84204412ed1c4db25a00684582aa7073a49743_flash_display_Sprite extends Sprite
   {
       
      
      public function _87ebc5cac5e7f6d869c7b2734d84204412ed1c4db25a00684582aa7073a49743_flash_display_Sprite()
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
