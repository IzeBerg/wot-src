package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _0a601e84753d7afabf1bc9b593f22ef28412046b999961bafd123f32b3ecc233_flash_display_Sprite extends Sprite
   {
       
      
      public function _0a601e84753d7afabf1bc9b593f22ef28412046b999961bafd123f32b3ecc233_flash_display_Sprite()
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
