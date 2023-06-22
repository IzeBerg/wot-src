package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _dd391053a59c7fed3937c2398cc9cf499215c1839e2e115cbe01aa29fe012126_flash_display_Sprite extends Sprite
   {
       
      
      public function _dd391053a59c7fed3937c2398cc9cf499215c1839e2e115cbe01aa29fe012126_flash_display_Sprite()
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
