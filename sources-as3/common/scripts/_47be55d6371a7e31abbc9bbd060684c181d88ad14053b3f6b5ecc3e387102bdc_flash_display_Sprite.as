package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _47be55d6371a7e31abbc9bbd060684c181d88ad14053b3f6b5ecc3e387102bdc_flash_display_Sprite extends Sprite
   {
       
      
      public function _47be55d6371a7e31abbc9bbd060684c181d88ad14053b3f6b5ecc3e387102bdc_flash_display_Sprite()
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
