package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _53025810ec25ab3f471cb059f33bff97bdcc159631d70908c0e3402e196cd6af_flash_display_Sprite extends Sprite
   {
       
      
      public function _53025810ec25ab3f471cb059f33bff97bdcc159631d70908c0e3402e196cd6af_flash_display_Sprite()
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
