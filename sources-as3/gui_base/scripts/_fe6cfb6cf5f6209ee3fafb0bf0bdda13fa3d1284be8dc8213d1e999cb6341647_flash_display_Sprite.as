package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _fe6cfb6cf5f6209ee3fafb0bf0bdda13fa3d1284be8dc8213d1e999cb6341647_flash_display_Sprite extends Sprite
   {
       
      
      public function _fe6cfb6cf5f6209ee3fafb0bf0bdda13fa3d1284be8dc8213d1e999cb6341647_flash_display_Sprite()
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
