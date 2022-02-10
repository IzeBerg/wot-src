package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _6e335f8db80078d1cf49e033cb870ee41ec97697dc4d38638319a0383c73d251_flash_display_Sprite extends Sprite
   {
       
      
      public function _6e335f8db80078d1cf49e033cb870ee41ec97697dc4d38638319a0383c73d251_flash_display_Sprite()
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
