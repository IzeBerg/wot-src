package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _75363275fcac2b675067da2ff82e4d9d2bb58bc40260ed5f22aa5f435e29c593_flash_display_Sprite extends Sprite
   {
       
      
      public function _75363275fcac2b675067da2ff82e4d9d2bb58bc40260ed5f22aa5f435e29c593_flash_display_Sprite()
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
