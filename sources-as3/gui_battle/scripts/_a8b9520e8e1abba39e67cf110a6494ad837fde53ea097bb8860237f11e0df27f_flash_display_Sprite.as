package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a8b9520e8e1abba39e67cf110a6494ad837fde53ea097bb8860237f11e0df27f_flash_display_Sprite extends Sprite
   {
       
      
      public function _a8b9520e8e1abba39e67cf110a6494ad837fde53ea097bb8860237f11e0df27f_flash_display_Sprite()
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
