package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _e9ca412c635e33fc5584a085ca395c88c6e232f030ee2a15839f4bcb83281892_flash_display_Sprite extends Sprite
   {
       
      
      public function _e9ca412c635e33fc5584a085ca395c88c6e232f030ee2a15839f4bcb83281892_flash_display_Sprite()
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
