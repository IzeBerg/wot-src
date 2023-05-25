package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _8b3461b4e4f988c0100fe2d1cd835113356c2b003b833070f1dff201bf0a773c_flash_display_Sprite extends Sprite
   {
       
      
      public function _8b3461b4e4f988c0100fe2d1cd835113356c2b003b833070f1dff201bf0a773c_flash_display_Sprite()
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
