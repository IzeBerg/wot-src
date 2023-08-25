package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1846a5397d45c97da34b81b59199442c6454bf081321d4319268b88fba41578c_flash_display_Sprite extends Sprite
   {
       
      
      public function _1846a5397d45c97da34b81b59199442c6454bf081321d4319268b88fba41578c_flash_display_Sprite()
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
