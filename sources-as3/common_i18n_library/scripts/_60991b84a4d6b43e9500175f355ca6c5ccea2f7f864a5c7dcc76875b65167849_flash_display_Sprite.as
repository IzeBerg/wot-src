package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _60991b84a4d6b43e9500175f355ca6c5ccea2f7f864a5c7dcc76875b65167849_flash_display_Sprite extends Sprite
   {
       
      
      public function _60991b84a4d6b43e9500175f355ca6c5ccea2f7f864a5c7dcc76875b65167849_flash_display_Sprite()
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
