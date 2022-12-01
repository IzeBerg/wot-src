package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _c17e887d2b8913ee66ff069bad8c9de21b406cd6b37cea91f9188b2d124ba44b_flash_display_Sprite extends Sprite
   {
       
      
      public function _c17e887d2b8913ee66ff069bad8c9de21b406cd6b37cea91f9188b2d124ba44b_flash_display_Sprite()
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
