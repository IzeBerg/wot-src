package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _8cb177040227b111f94d9a352a6af0cff6cc329046ca61de7d2fc036d9cc0241_flash_display_Sprite extends Sprite
   {
       
      
      public function _8cb177040227b111f94d9a352a6af0cff6cc329046ca61de7d2fc036d9cc0241_flash_display_Sprite()
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
