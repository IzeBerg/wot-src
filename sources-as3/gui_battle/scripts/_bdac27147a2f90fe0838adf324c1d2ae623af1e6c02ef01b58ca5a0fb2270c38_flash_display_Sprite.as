package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _bdac27147a2f90fe0838adf324c1d2ae623af1e6c02ef01b58ca5a0fb2270c38_flash_display_Sprite extends Sprite
   {
       
      
      public function _bdac27147a2f90fe0838adf324c1d2ae623af1e6c02ef01b58ca5a0fb2270c38_flash_display_Sprite()
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
