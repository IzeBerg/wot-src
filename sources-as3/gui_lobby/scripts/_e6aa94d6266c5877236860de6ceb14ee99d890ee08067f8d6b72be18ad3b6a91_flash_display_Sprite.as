package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _e6aa94d6266c5877236860de6ceb14ee99d890ee08067f8d6b72be18ad3b6a91_flash_display_Sprite extends Sprite
   {
       
      
      public function _e6aa94d6266c5877236860de6ceb14ee99d890ee08067f8d6b72be18ad3b6a91_flash_display_Sprite()
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
