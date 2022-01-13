package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _58c6396ebe408edcf9a2e5e35572e288b40ccdcbe29009c91e3ac145dd1814dd_flash_display_Sprite extends Sprite
   {
       
      
      public function _58c6396ebe408edcf9a2e5e35572e288b40ccdcbe29009c91e3ac145dd1814dd_flash_display_Sprite()
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
