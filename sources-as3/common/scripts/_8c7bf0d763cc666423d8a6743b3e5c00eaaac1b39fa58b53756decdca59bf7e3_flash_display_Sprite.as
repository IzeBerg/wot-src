package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _8c7bf0d763cc666423d8a6743b3e5c00eaaac1b39fa58b53756decdca59bf7e3_flash_display_Sprite extends Sprite
   {
       
      
      public function _8c7bf0d763cc666423d8a6743b3e5c00eaaac1b39fa58b53756decdca59bf7e3_flash_display_Sprite()
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
