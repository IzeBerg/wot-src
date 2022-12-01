package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _c6fd92f54a901bd888818deaaaa67e010c7efe47efa5d658d6e2353b5764466d_flash_display_Sprite extends Sprite
   {
       
      
      public function _c6fd92f54a901bd888818deaaaa67e010c7efe47efa5d658d6e2353b5764466d_flash_display_Sprite()
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
