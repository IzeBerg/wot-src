package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _c6b9d1a1b0cacdf5ec57212165f9a36b8b87de51372c5149c68d3292a47a4d45_flash_display_Sprite extends Sprite
   {
       
      
      public function _c6b9d1a1b0cacdf5ec57212165f9a36b8b87de51372c5149c68d3292a47a4d45_flash_display_Sprite()
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
