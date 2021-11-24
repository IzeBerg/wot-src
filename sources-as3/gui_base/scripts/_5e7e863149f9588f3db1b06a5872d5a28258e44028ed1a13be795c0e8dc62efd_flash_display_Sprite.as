package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _5e7e863149f9588f3db1b06a5872d5a28258e44028ed1a13be795c0e8dc62efd_flash_display_Sprite extends Sprite
   {
       
      
      public function _5e7e863149f9588f3db1b06a5872d5a28258e44028ed1a13be795c0e8dc62efd_flash_display_Sprite()
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
