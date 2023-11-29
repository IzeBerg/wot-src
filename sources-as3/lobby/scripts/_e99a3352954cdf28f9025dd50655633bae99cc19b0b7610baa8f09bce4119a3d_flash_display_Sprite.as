package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _e99a3352954cdf28f9025dd50655633bae99cc19b0b7610baa8f09bce4119a3d_flash_display_Sprite extends Sprite
   {
       
      
      public function _e99a3352954cdf28f9025dd50655633bae99cc19b0b7610baa8f09bce4119a3d_flash_display_Sprite()
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
