package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _6d08a6ced645865f180de5d4db57cf6053cdf8b8d353bd76fc7bdd1d15cbacb3_flash_display_Sprite extends Sprite
   {
       
      
      public function _6d08a6ced645865f180de5d4db57cf6053cdf8b8d353bd76fc7bdd1d15cbacb3_flash_display_Sprite()
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
