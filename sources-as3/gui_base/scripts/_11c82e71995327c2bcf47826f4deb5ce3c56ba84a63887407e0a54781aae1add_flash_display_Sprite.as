package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _11c82e71995327c2bcf47826f4deb5ce3c56ba84a63887407e0a54781aae1add_flash_display_Sprite extends Sprite
   {
       
      
      public function _11c82e71995327c2bcf47826f4deb5ce3c56ba84a63887407e0a54781aae1add_flash_display_Sprite()
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
