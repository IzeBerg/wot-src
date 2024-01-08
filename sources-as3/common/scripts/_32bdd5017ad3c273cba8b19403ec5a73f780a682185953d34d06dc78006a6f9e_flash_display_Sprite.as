package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _32bdd5017ad3c273cba8b19403ec5a73f780a682185953d34d06dc78006a6f9e_flash_display_Sprite extends Sprite
   {
       
      
      public function _32bdd5017ad3c273cba8b19403ec5a73f780a682185953d34d06dc78006a6f9e_flash_display_Sprite()
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
