package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _4a3b6cfdc23c354e87380a84cc9536423d92ae36426feac2f3e668b141600deb_flash_display_Sprite extends Sprite
   {
       
      
      public function _4a3b6cfdc23c354e87380a84cc9536423d92ae36426feac2f3e668b141600deb_flash_display_Sprite()
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
