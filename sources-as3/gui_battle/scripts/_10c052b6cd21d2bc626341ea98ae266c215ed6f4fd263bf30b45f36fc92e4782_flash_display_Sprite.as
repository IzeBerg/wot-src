package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _10c052b6cd21d2bc626341ea98ae266c215ed6f4fd263bf30b45f36fc92e4782_flash_display_Sprite extends Sprite
   {
       
      
      public function _10c052b6cd21d2bc626341ea98ae266c215ed6f4fd263bf30b45f36fc92e4782_flash_display_Sprite()
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
