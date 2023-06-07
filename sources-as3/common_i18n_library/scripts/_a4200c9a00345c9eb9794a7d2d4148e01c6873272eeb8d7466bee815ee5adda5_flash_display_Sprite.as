package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a4200c9a00345c9eb9794a7d2d4148e01c6873272eeb8d7466bee815ee5adda5_flash_display_Sprite extends Sprite
   {
       
      
      public function _a4200c9a00345c9eb9794a7d2d4148e01c6873272eeb8d7466bee815ee5adda5_flash_display_Sprite()
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
