package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _e8fc7620270263a467013ce1854677c7ab886608b45f5530a0bdf8850c7aca83_flash_display_Sprite extends Sprite
   {
       
      
      public function _e8fc7620270263a467013ce1854677c7ab886608b45f5530a0bdf8850c7aca83_flash_display_Sprite()
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
