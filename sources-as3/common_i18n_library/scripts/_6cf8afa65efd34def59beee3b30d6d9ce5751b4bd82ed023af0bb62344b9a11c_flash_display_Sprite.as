package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _6cf8afa65efd34def59beee3b30d6d9ce5751b4bd82ed023af0bb62344b9a11c_flash_display_Sprite extends Sprite
   {
       
      
      public function _6cf8afa65efd34def59beee3b30d6d9ce5751b4bd82ed023af0bb62344b9a11c_flash_display_Sprite()
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
