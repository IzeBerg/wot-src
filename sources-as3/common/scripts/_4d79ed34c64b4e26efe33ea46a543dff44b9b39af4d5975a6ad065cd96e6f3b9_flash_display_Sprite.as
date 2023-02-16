package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _4d79ed34c64b4e26efe33ea46a543dff44b9b39af4d5975a6ad065cd96e6f3b9_flash_display_Sprite extends Sprite
   {
       
      
      public function _4d79ed34c64b4e26efe33ea46a543dff44b9b39af4d5975a6ad065cd96e6f3b9_flash_display_Sprite()
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
