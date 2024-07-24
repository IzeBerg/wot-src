package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _3090e15d69a2bf0752debc965bace9f890b1e2e2039b061c2d87660c33c420e7_flash_display_Sprite extends Sprite
   {
       
      
      public function _3090e15d69a2bf0752debc965bace9f890b1e2e2039b061c2d87660c33c420e7_flash_display_Sprite()
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
