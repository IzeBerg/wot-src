package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _292ddd8fbc70b1eba301a15e7135f0a9b305cd33daf50179ae3fcffecab3cba9_flash_display_Sprite extends Sprite
   {
       
      
      public function _292ddd8fbc70b1eba301a15e7135f0a9b305cd33daf50179ae3fcffecab3cba9_flash_display_Sprite()
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
