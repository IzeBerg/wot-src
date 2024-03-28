package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a83da3d4c13f0e4def2e0dfafe55d9b2c0b936966b3b24c9a28b47e1f11659dc_flash_display_Sprite extends Sprite
   {
       
      
      public function _a83da3d4c13f0e4def2e0dfafe55d9b2c0b936966b3b24c9a28b47e1f11659dc_flash_display_Sprite()
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
