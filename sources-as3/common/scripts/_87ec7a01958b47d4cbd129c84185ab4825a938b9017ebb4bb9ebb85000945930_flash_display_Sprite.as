package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _87ec7a01958b47d4cbd129c84185ab4825a938b9017ebb4bb9ebb85000945930_flash_display_Sprite extends Sprite
   {
       
      
      public function _87ec7a01958b47d4cbd129c84185ab4825a938b9017ebb4bb9ebb85000945930_flash_display_Sprite()
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
