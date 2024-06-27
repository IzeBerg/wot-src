package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _759ae4c031ed3f6be220ddf4e27c4ed13b6aab2fdf30ea87fa68e18e7adb99de_flash_display_Sprite extends Sprite
   {
       
      
      public function _759ae4c031ed3f6be220ddf4e27c4ed13b6aab2fdf30ea87fa68e18e7adb99de_flash_display_Sprite()
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
