package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _2bab6f7f52e46597a1f83b90404afb72d7b028573e63e872c437d64f0a244690_flash_display_Sprite extends Sprite
   {
       
      
      public function _2bab6f7f52e46597a1f83b90404afb72d7b028573e63e872c437d64f0a244690_flash_display_Sprite()
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
