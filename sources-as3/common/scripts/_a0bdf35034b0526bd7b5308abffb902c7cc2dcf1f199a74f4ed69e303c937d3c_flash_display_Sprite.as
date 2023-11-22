package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a0bdf35034b0526bd7b5308abffb902c7cc2dcf1f199a74f4ed69e303c937d3c_flash_display_Sprite extends Sprite
   {
       
      
      public function _a0bdf35034b0526bd7b5308abffb902c7cc2dcf1f199a74f4ed69e303c937d3c_flash_display_Sprite()
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
