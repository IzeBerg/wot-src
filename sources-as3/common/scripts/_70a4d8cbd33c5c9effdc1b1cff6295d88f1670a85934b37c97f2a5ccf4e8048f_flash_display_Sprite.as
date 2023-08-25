package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _70a4d8cbd33c5c9effdc1b1cff6295d88f1670a85934b37c97f2a5ccf4e8048f_flash_display_Sprite extends Sprite
   {
       
      
      public function _70a4d8cbd33c5c9effdc1b1cff6295d88f1670a85934b37c97f2a5ccf4e8048f_flash_display_Sprite()
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
