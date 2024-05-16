package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _6e06365cc48807decd0cd2eeec01d042cdb699c5bdd6e15a2d7f0e5cb35ea780_flash_display_Sprite extends Sprite
   {
       
      
      public function _6e06365cc48807decd0cd2eeec01d042cdb699c5bdd6e15a2d7f0e5cb35ea780_flash_display_Sprite()
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
