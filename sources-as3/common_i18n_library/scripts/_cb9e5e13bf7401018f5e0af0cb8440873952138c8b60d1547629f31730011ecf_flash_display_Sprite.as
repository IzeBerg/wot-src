package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _cb9e5e13bf7401018f5e0af0cb8440873952138c8b60d1547629f31730011ecf_flash_display_Sprite extends Sprite
   {
       
      
      public function _cb9e5e13bf7401018f5e0af0cb8440873952138c8b60d1547629f31730011ecf_flash_display_Sprite()
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
