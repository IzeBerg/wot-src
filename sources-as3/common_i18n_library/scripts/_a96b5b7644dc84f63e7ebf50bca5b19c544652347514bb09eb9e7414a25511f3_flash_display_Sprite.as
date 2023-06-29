package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a96b5b7644dc84f63e7ebf50bca5b19c544652347514bb09eb9e7414a25511f3_flash_display_Sprite extends Sprite
   {
       
      
      public function _a96b5b7644dc84f63e7ebf50bca5b19c544652347514bb09eb9e7414a25511f3_flash_display_Sprite()
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
