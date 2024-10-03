package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _56f156cee58d4dddc157a8f8e0ade949066968da46a4968fc9a5623f434193b0_flash_display_Sprite extends Sprite
   {
       
      
      public function _56f156cee58d4dddc157a8f8e0ade949066968da46a4968fc9a5623f434193b0_flash_display_Sprite()
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
