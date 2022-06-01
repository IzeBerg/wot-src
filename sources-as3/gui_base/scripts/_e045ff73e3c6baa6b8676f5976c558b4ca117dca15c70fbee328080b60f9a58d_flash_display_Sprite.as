package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _e045ff73e3c6baa6b8676f5976c558b4ca117dca15c70fbee328080b60f9a58d_flash_display_Sprite extends Sprite
   {
       
      
      public function _e045ff73e3c6baa6b8676f5976c558b4ca117dca15c70fbee328080b60f9a58d_flash_display_Sprite()
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
