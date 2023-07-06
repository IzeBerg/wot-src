package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _df916a7918aae63fa35fb71989822fb7e626b85ffba6732274b055f041c3a2f5_flash_display_Sprite extends Sprite
   {
       
      
      public function _df916a7918aae63fa35fb71989822fb7e626b85ffba6732274b055f041c3a2f5_flash_display_Sprite()
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
