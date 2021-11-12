package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _6f8335a330b5e6b3d7afe323fbf84e647ffe199adb232709b8b762e3f3b64ad5_flash_display_Sprite extends Sprite
   {
       
      
      public function _6f8335a330b5e6b3d7afe323fbf84e647ffe199adb232709b8b762e3f3b64ad5_flash_display_Sprite()
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
