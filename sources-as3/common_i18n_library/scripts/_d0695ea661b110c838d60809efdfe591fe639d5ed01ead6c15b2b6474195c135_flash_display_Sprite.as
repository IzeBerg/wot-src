package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _d0695ea661b110c838d60809efdfe591fe639d5ed01ead6c15b2b6474195c135_flash_display_Sprite extends Sprite
   {
       
      
      public function _d0695ea661b110c838d60809efdfe591fe639d5ed01ead6c15b2b6474195c135_flash_display_Sprite()
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
