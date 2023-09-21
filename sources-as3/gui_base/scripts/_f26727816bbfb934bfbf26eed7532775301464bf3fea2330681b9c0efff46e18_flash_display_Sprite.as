package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _f26727816bbfb934bfbf26eed7532775301464bf3fea2330681b9c0efff46e18_flash_display_Sprite extends Sprite
   {
       
      
      public function _f26727816bbfb934bfbf26eed7532775301464bf3fea2330681b9c0efff46e18_flash_display_Sprite()
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
