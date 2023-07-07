package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _573410ffe1aaeacb944b2d2c0bd85345f593355ca85006e05ea38ba752ce69c5_flash_display_Sprite extends Sprite
   {
       
      
      public function _573410ffe1aaeacb944b2d2c0bd85345f593355ca85006e05ea38ba752ce69c5_flash_display_Sprite()
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
