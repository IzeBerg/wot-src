package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _95b5d746b0bcf6f61af7103f4bdcedf4c1d5c1016596de068b247dc04d2a4c6b_flash_display_Sprite extends Sprite
   {
       
      
      public function _95b5d746b0bcf6f61af7103f4bdcedf4c1d5c1016596de068b247dc04d2a4c6b_flash_display_Sprite()
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
