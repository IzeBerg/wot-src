package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _3f302c7768aedc3c7707c561a6c4cc5e7e48817294c4250b0f55a1da7fee6146_flash_display_Sprite extends Sprite
   {
       
      
      public function _3f302c7768aedc3c7707c561a6c4cc5e7e48817294c4250b0f55a1da7fee6146_flash_display_Sprite()
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
