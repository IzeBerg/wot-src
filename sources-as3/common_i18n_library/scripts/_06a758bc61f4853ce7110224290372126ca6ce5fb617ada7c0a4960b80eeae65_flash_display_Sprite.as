package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _06a758bc61f4853ce7110224290372126ca6ce5fb617ada7c0a4960b80eeae65_flash_display_Sprite extends Sprite
   {
       
      
      public function _06a758bc61f4853ce7110224290372126ca6ce5fb617ada7c0a4960b80eeae65_flash_display_Sprite()
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
