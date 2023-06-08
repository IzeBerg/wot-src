package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _480a528b7659ad2fa874945e3640d35ebcfaa242324d292e73a04fea566bdf10_flash_display_Sprite extends Sprite
   {
       
      
      public function _480a528b7659ad2fa874945e3640d35ebcfaa242324d292e73a04fea566bdf10_flash_display_Sprite()
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
