package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _00ea3c379e3c21ca91453c2c70ecc8141d325b5cf22e56edb0bbac909e8a8201_flash_display_Sprite extends Sprite
   {
       
      
      public function _00ea3c379e3c21ca91453c2c70ecc8141d325b5cf22e56edb0bbac909e8a8201_flash_display_Sprite()
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
